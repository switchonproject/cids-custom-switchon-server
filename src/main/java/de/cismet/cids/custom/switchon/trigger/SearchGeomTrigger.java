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

import de.cismet.cids.dynamics.CidsBean;

import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;

import de.cismet.commons.concurrency.CismetConcurrency;

/**
 * This trigger copies a geometry from the geom table to the search_geom table when a new resource is added to the
 * repository.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = CidsTrigger.class)
public class SearchGeomTrigger extends AbstractDBAwareCidsTrigger {

    //~ Static fields/initializers ---------------------------------------------

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SearchGeomTrigger.class);

    //~ Instance fields --------------------------------------------------------

    private PreparedStatement searchGeomInsertStatement = null;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SearchGeomTrigger object.
     *
     * @throws  Exception  DOCUMENT ME!
     */
    public SearchGeomTrigger() throws Exception {
//        try {
//            final Statement cleanupStatement = this.getDbServer()
//                        .getActiveDBConnection()
//                        .getConnection()
//                        .createStatement();
//            final int deleted = cleanupStatement.executeUpdate(
//                    "DELETE FROM geom_search WHERE geom_search.resource NOT IN (SELECT id FROM resource);");
//            if (LOGGER.isDebugEnabled()) {
//                LOGGER.debug("cleanup of geom_search table removed " + deleted + " orphaned search geometries");
//            }
//        } catch (Exception ex) {
//            LOGGER.error("could not perform cleanup of geom_search table:" + ex.getMessage(), ex);
//        }
    }

    //~ Methods ----------------------------------------------------------------

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
        throw new UnsupportedOperationException("Not supported yet."); // To change body of generated methods, choose
                                                                       // Tools | Templates.
    }

    @Override
    public void afterDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedInsert(final CidsBean cidsBean, final User user) {
        if (searchGeomInsertStatement == null) {
            try {
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("initialising insert search geom statement");
                }
                // final String query_oracle = "insert into geom (geo_field) values(SDO_GEOMETRY('%1$s', %2$s))";
                final String searchGeomInsertTpl = "INSERT INTO geom_search(resource, geo_field, geom)\n"
                            + "SELECT resource.id,\n"
                            + "       geom.geo_field,\n"
                            + "       geom.id\n"
                            + "FROM resource\n"
                            + "JOIN geom ON resource.spatialcoverage = geom.id\n"
                            + "WHERE resource.id = ? LIMIT 1;";
                searchGeomInsertStatement = this.getDbServer().getActiveDBConnection().getConnection()
                            .prepareStatement(searchGeomInsertTpl);
            } catch (SQLException ex) {
                LOGGER.error("couöd not prepare insert search geom statement: " + ex.getMessage(), ex);
                return;
            }
        }

        final int id = cidsBean.getPrimaryKeyValue();
        LOGGER.info("new Resource '" + cidsBean.getProperty("name").toString()
                    + "' (" + id + ") created, copying geometry to search geometries table");

        CismetConcurrency.getInstance("SWITCHON")
                .getDefaultExecutor()
                .execute(new javax.swing.SwingWorker<Integer, Void>() {

                        @Override
                        protected Integer doInBackground() throws Exception {
                            // final int srid = -1; final Geometry g = (Geometry)cidsBean.getProperty("geo_field");
                            // final String dialect = Lookup.getDefault().lookup(DialectProvider.class).getDialect();
                            // final String geometry = SQLTools.getGeometryFactory(dialect).getDbString(g);

                            searchGeomInsertStatement.setInt(1, id);
                            final int updated = searchGeomInsertStatement.executeUpdate();
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
                                        + cidsBean.getProperty("name").toString()
                                        + "' ("
                                        + id
                                        + ") copied to search geometries table");
                                }
                            } catch (Exception e) {
                                LOGGER.error(
                                    "could not copy search geometries of new Resource '"
                                    + cidsBean.getProperty("name").toString()
                                    + "' ("
                                    + id
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
        return dbServer;
    }
}
