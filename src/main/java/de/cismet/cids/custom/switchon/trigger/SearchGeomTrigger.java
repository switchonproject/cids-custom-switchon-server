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

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.List;

import de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools;

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
public class SearchGeomTrigger extends AbstractDBAwareCidsTrigger {

    //~ Static fields/initializers ---------------------------------------------

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SearchGeomTrigger.class);

    //~ Instance fields --------------------------------------------------------

    private SpatialIndexTools spatialIndexTools = null;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SearchGeomTrigger object.
     *
     * @throws  Exception  DOCUMENT ME!
     */
    public SearchGeomTrigger() throws Exception {
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Lazy initilaisation of spatial index tools (requires active db connection and cannot be performed in
     * constructor).
     *
     * @return  true if initilaisation was successfull, false otherwise
     */
    protected synchronized boolean init() {
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
                            int updated = 0;
                            final boolean processingInstructionFound = false;
                            final List<CidsBean> representations = resource.getBeanCollectionProperty(
                                    "representations");
                            if ((representations != null) && !representations.isEmpty()) {
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug(
                                        "searching "
                                        + representations.size()
                                        + " for processing instructions");
                                }
                                for (final CidsBean representation : representations) {
                                    if (!processingInstructionFound) {
                                        final Object processingInstruction = representation.getProperty("uploadstatus");
                                        if (processingInstruction != null) {
                                            if (
                                        processingInstruction.toString().toLowerCase().indexOf(
                                                    SpatialIndexTools.SPATIAL_PROCESSING_INSTRUCTION.toLowerCase())
                                                != -1) {
                                                final String fileType = processingInstruction.toString()
                                                    .substring(
                                                        processingInstruction.toString().toLowerCase().indexOf(
                                                            SpatialIndexTools.SPATIAL_PROCESSING_INSTRUCTION
                                                                .toLowerCase()));
                                            } else {
                                                LOGGER.error(
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
                                        }
                                    }
                                }
                            }

                            synchronized (SearchGeomTrigger.this) {
                                if (!processingInstructionFound) {
                                    if (LOGGER.isDebugEnabled()) {
                                        LOGGER.debug(
                                            "no processing instruction found in representations of resurce '"
                                            + resourceName
                                            + "' ("
                                            + resourceId
                                            + ") updating spatial index with geometry of resource");
                                    }
                                }
                                final PreparedStatement searchGeomCopyStatement =
                                    spatialIndexTools.getSearchGeomCopyStatement();
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
                                    LOGGER.debug(
                                        updated
                                        + "search geometries of new Resource '"
                                        + resourceName
                                        + "' ("
                                        + resourceId
                                        + ") copied to search geometries table");
                                }
                            } catch (Exception e) {
                                LOGGER.error(
                                    "could not copy search geometries of new Resource '"
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

    @Override
    public void afterCommittedUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedDelete(final CidsBean cidsBean, final User user) {
        // TODO!!!!!!
    }

    @Override
    public CidsTriggerKey getTriggerKey() {
        return new CidsTriggerKey("SWITCHON", "RESOURCE");
    }

    @Override
    public int compareTo(final CidsTrigger o) {
        return -1;
    }

    @Override
    public final DBServer getDbServer() {
        return this.dbServer;
    }
}
