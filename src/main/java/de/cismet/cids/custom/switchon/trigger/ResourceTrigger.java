/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.trigger;

import Sirius.server.localserver.DBServer;
import Sirius.server.newuser.User;

import org.openide.util.lookup.ServiceProvider;

import java.net.URL;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.List;

import javax.activation.UnsupportedDataTypeException;

import de.cismet.cids.custom.switchon.utils.server.CleanupTools;
import de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools;
import de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools.FileType;
import de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools.UpdateStatus;

import de.cismet.cids.dynamics.CidsBean;

import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;

import de.cismet.commons.concurrency.CismetConcurrency;

/**
 * This trigger copies either a geometry from the geom table to the search_geom table when a new resource is added to
 * the repository or, if the resource has a SHP file representation, it tries to inspect the SHP File and extract the
 * geometries from the SHP file with help of the SpatialIndexTools.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = CidsTrigger.class)
public class ResourceTrigger extends AbstractDBAwareCidsTrigger {

    //~ Static fields/initializers ---------------------------------------------

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ResourceTrigger.class);

    //~ Instance fields --------------------------------------------------------

    private CleanupTools cleanupTools = null;
    private SpatialIndexTools spatialIndexTools = null;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SearchGeomTrigger object.
     *
     * @throws  Exception  DOCUMENT ME!
     */
    public ResourceTrigger() throws Exception {
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Lazy initilaisation of spatial index tools (requires active db connection and cannot be performed in
     * constructor).
     *
     * @return  true if initilaisation was successfull, false otherwise
     */
    protected synchronized boolean init() {
        if (this.cleanupTools == null) {
            try {
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("initialising Cleanup Tools");
                }

                cleanupTools = new CleanupTools(this.getDbServer().getActiveDBConnection().getConnection());
            } catch (SQLException ex) {
                LOGGER.fatal("could not initialise CleanupTools: " + ex.getMessage(), ex);
                this.cleanupTools = null;
                return false;
            }
        }

        if (this.spatialIndexTools == null) {
            try {
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("initialising Spatial Index Tools");
                }

                spatialIndexTools = new SpatialIndexTools(this.getDbServer().getActiveDBConnection());
            } catch (SQLException ex) {
                LOGGER.fatal("could not initialise SpatialIndexTools: " + ex.getMessage(), ex);
                this.spatialIndexTools = null;
                return false;
            }
        }

        return true;
    }

    @Override
    public void beforeInsert(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterInsert(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void beforeUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void beforeDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedInsert(final CidsBean resource, final User user) {
        // bail out if initialisation has failed;
        // FIXME(?): client will never know if trigger has failed
        if (!init()) {
            return;
        }

        final int resourceId = resource.getPrimaryKeyValue();
        final String resourceName = (resource.getProperty("name") != null) ? resource.getProperty("name").toString()
                                                                           : String.valueOf(resourceId);
        LOGGER.info("new Resource '" + resourceName + "' (" + resourceId
                    + ") created, attempting to update spatial index (geom_search table).");

        CismetConcurrency.getInstance("SWITCHON")
                .getDefaultExecutor()
                .execute(new javax.swing.SwingWorker<Integer, Void>() {

                        @Override
                        protected Integer doInBackground() throws Exception {
                            int updated = -1;
                            final List<CidsBean> representations = resource.getBeanCollectionProperty(
                                    "representation");
                            if ((representations != null) && !representations.isEmpty()) {
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug(
                                        "searching "
                                        + representations.size()
                                        + " representation (s) for processing instructions");
                                }

                                for (final CidsBean representation : representations) {
                                    updated = processRepresentation(representation, resourceId, resourceName);

                                    // import successfully performed, return updated polygon count
                                    if (updated != -1) {
                                        return updated;
                                    }
                                }
                            }

                            // continue when updated == -1 (no processing instruction or import failed)
                            final PreparedStatement searchGeomCopyStatement =
                                spatialIndexTools.getSearchGeomCopyStatement();

                            // aquire lock to prevent using the prepared statement from other threads!
                            synchronized (searchGeomCopyStatement) {
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug(
                                        "no processing instruction found in representations of resource '"
                                        + resourceName
                                        + "' ("
                                        + resourceId
                                        + ") updating spatial index with geometry of resource");
                                }

                                searchGeomCopyStatement.setInt(1, resourceId);
                                updated = searchGeomCopyStatement.executeUpdate();
                            }

                            return updated;
                        }

                        @Override
                        protected void done() {
                            try {
                                final Integer updated = get();
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.info(
                                        updated
                                        + " search geometries of new resource '"
                                        + resourceName
                                        + "' ("
                                        + resourceId
                                        + ") copied to search geometries table");
                                }
                            } catch (final Exception e) {
                                LOGGER.error(
                                    "could not copy search geometries of new resource '"
                                    + resourceName
                                    + "' ("
                                    + resourceId
                                    + ")  to search geometries table: "
                                    + e.getMessage(),
                                    e);
                            }
                        }
                    });
    }

    /**
     * DOCUMENT ME!
     *
     * @param   representation  DOCUMENT ME!
     * @param   resourceId      DOCUMENT ME!
     * @param   resourceName    DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int processRepresentation(final CidsBean representation,
            final int resourceId,
            final String resourceName) {
        final String processingInstruction = (representation.getProperty("uploadmessage") != null)
            ? representation.getProperty("uploadmessage").toString() : null;

        if (processingInstruction != null) {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("processing instruction '"
                            + processingInstruction
                            + "' found in repesentation '"
                            + representation.getProperty("contentlocation")
                            + "' ("
                            + representation.getPrimaryKeyValue()
                            + ") of resource '"
                            + resourceName
                            + "' ("
                            + resourceId
                            + ")");
            }
            try {
                if (
                    processingInstruction.toLowerCase().indexOf(
                                SpatialIndexTools.SPATIAL_PROCESSING_INSTRUCTION.toLowerCase())
                            != 0) {
                    throw new UnsupportedOperationException(
                        "unsupported processing instruction '"
                                + processingInstruction
                                + "' found in repesentation '"
                                + representation.getProperty("contentlocation")
                                + "' ("
                                + representation.getPrimaryKeyValue()
                                + ") of resource '"
                                + resourceName
                                + "' ("
                                + resourceId
                                + ")");
                }

                FileType filterType = null;
                final String fileTypeString = processingInstruction.substring(
                        SpatialIndexTools.SPATIAL_PROCESSING_INSTRUCTION.length())
                            .toLowerCase();

                for (final FileType ft : FileType.values()) {
                    if (ft.toString().equalsIgnoreCase(fileTypeString)) {
                        filterType = ft;
                        break;
                    }
                }

                if (filterType == null) {
                    throw new UnsupportedDataTypeException("unsupported file type '"
                                + fileTypeString + "' found in processing instruction '"
                                + processingInstruction
                                + "' found in repesentation '"
                                + representation.getProperty("contentlocation")
                                + "' ("
                                + representation.getPrimaryKeyValue()
                                + ") of resource '"
                                + resourceName
                                + "' ("
                                + resourceId
                                + ")");
                }

                final URL fileUrl = new URL(representation.getProperty("contentlocation").toString());

                return this.spatialIndexTools.updateSpatialIndex(fileUrl, filterType, resourceId);
            } catch (final Throwable t) {
                final String message = t.getClass().getSimpleName()
                            + " while executing processing instruction '"
                            + processingInstruction
                            + "' found in repesentation '"
                            + representation.getProperty("contentlocation")
                            + "' ("
                            + representation.getPrimaryKeyValue()
                            + ") of resource '"
                            + resourceName
                            + "' ("
                            + resourceId
                            + "): "
                            + t.getMessage();

                LOGGER.error(message, t);
                this.updateRepresentationStatus(representation, message);
            }
        }

        return -1;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  representation  DOCUMENT ME!
     * @param  message         DOCUMENT ME!
     */
    protected void updateRepresentationStatus(final CidsBean representation, final String message) {
        final String uuid = (representation.getProperty("uuid") != null) ? representation.getProperty("uuid").toString()
                                                                         : null;

        if (uuid != null) {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("updating status of representation '" + representation.getProperty("contentlocation")
                            + "' (" + uuid + ")");
            }
            try {
                final PreparedStatement updateRepresentationStatusStatement =
                    spatialIndexTools.getUpdateRepresentationStatusStatement();

                synchronized (updateRepresentationStatusStatement) {
                    updateRepresentationStatusStatement.setString(1, UpdateStatus.FAILED.toString());
                    updateRepresentationStatusStatement.setString(2, message);
                    updateRepresentationStatusStatement.setString(3, uuid);

                    final int updateStatus = updateRepresentationStatusStatement.executeUpdate();
                    if (updateStatus == 1) {
                        if (LOGGER.isDebugEnabled()) {
                            LOGGER.debug("status of representation '" + representation.getProperty("contentlocation")
                                        + "' (" + uuid + ") successfully updated");
                        }
                    } else {
                        if (LOGGER.isDebugEnabled()) {
                            LOGGER.debug("status of representation '" + representation.getProperty("contentlocation")
                                        + "' (" + uuid + ") not updated correctly (update count = " + updateStatus
                                        + ") but no exception was thrown!");
                        }
                    }
                }
            } catch (Exception e) {
                LOGGER.error("status of representation '" + representation.getProperty("contentlocation")
                            + "' (" + uuid + ") could not be updated: " + e.getMessage(),
                    e);
            }
        } else {
            LOGGER.warn("cannot update status of representation '" + representation.getProperty("contentlocation")
                        + "' (" + representation.getPrimaryKeyValue() + "): no UUID property found in representation!");
        }
    }

    @Override
    public void afterCommittedUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedDelete(final CidsBean resource, final User user) {
// bail out if initialisation has failed;
        // FIXME(?): client will never know if trigger has failed
        if (!init()) {
            return;
        }

        final int resourceId = resource.getPrimaryKeyValue();
        final String resourceName = (resource.getProperty("name") != null) ? resource.getProperty("name").toString()
                                                                           : String.valueOf(resourceId);
        LOGGER.info("Resource '" + resourceName + "' (" + resourceId
                    + ") deleted, attempting to clean up orphaned entities");

        CismetConcurrency.getInstance("SWITCHON")
                .getDefaultExecutor()
                .execute(new javax.swing.SwingWorker<Integer, Void>() {

                        @Override
                        protected Integer doInBackground() throws Exception {
                            return cleanupTools.cleanupResource(resourceId);
                        }

                        @Override
                        protected void done() {
                            try {
                                final Integer deleted = get();
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.info(
                                        deleted
                                        + " entities cleaned after deletion of resource '"
                                        + resourceName
                                        + "' ("
                                        + resourceId
                                        + ").");
                                }
                            } catch (final Exception e) {
                                LOGGER.error(
                                    "could not clean up entities after deletion of resource '"
                                    + resourceName
                                    + "' ("
                                    + resourceId
                                    + "): "
                                    + e.getMessage(),
                                    e);
                            }
                        }
                    });
    }

    @Override
    public CidsTriggerKey getTriggerKey() {
        return new CidsTriggerKey("SWITCHON", "RESOURCE");
    }

    @Override
    public int compareTo(final CidsTrigger o) {
        return Integer.MAX_VALUE;
    }

    @Override
    public final DBServer getDbServer() {
        return this.dbServer;
    }
}
