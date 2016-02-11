package de.cismet.cids.custom.switchon.trigger;

import Sirius.server.newuser.User;
import Sirius.server.sql.DBConnection;
import de.cismet.cids.dynamics.CidsBean;
import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;
import de.cismet.commons.concurrency.CismetConcurrency;
import java.sql.SQLException;
import org.openide.util.lookup.ServiceProvider;

/**
 *
 * @author Pascal Dihé <pascal.dihe@cismet.de>
 */
@ServiceProvider(service = CidsTrigger.class)
public class SearchGeomTrigger extends AbstractDBAwareCidsTrigger {
    
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SearchGeomTrigger.class);

    @Override
    public void beforeInsert(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void afterInsert(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void beforeUpdate(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void afterUpdate(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void beforeDelete(CidsBean cidsBean, User user) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void afterDelete(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void afterCommittedInsert(final CidsBean cidsBean, final User user) {
        LOGGER.info("new Resource '" + cidsBean.getProperty("name").toString() 
                + "' (" + cidsBean.getPrimaryKeyValue() + ") created, copy geometry to search geometries table");
        
        CismetConcurrency.getInstance("SWITCHON").getDefaultExecutor().execute(new javax.swing.SwingWorker<Integer, Void>() {

                    @Override
                    protected Integer doInBackground() throws Exception {
                        try {
                            final String name = cidsBean.toString();
                            if ((name == null) || name.equals("")) {
                                getDbServer().getActiveDBConnection()
                                        .submitInternalUpdate(
                                            DBConnection.DESC_DELETE_STRINGREPCACHEENTRY,
                                            cidsBean.getMetaObject().getClassID(),
                                            cidsBean.getMetaObject().getID());
                                return 0;
                            } else {
                                return getDbServer().getActiveDBConnection()
                                            .submitInternalUpdate(
                                                DBConnection.DESC_UPDATE_STRINGREPCACHEENTRY,
                                                name,
                                                cidsBean.getMetaObject().getClassID(),
                                                cidsBean.getMetaObject().getID());
                            }
                        } catch (SQLException e) {
                            getDbServer().getActiveDBConnection().submitInternalUpdate(
                                        DBConnection.DESC_DELETE_STRINGREPCACHEENTRY,
                                        cidsBean.getMetaObject().getClassID(),
                                        cidsBean.getMetaObject().getID());
                            return getDbServer().getActiveDBConnection()
                                        .submitInternalUpdate(
                                            DBConnection.DESC_INSERT_STRINGREPCACHEENTRY,
                                            cidsBean.getMetaObject().getClassID(),
                                            cidsBean.getMetaObject().getID(),
                                            cidsBean.toString());
                        }
                    }

                    @Override
                    protected void done() {
                        try {
                            final Integer result = get();
                        } catch (Exception e) {
                            LOGGER.error("Exception in Background Thread: afterUpdate", e);
                        }
                    }
                }); 
    }

    @Override
    public void afterCommittedUpdate(CidsBean cidsBean, User user) {
        
    }

    @Override
    public void afterCommittedDelete(CidsBean cidsBean, User user) {
        
    }

    @Override
    public CidsTriggerKey getTriggerKey() {
        return new CidsTriggerKey("SWITCHON", "RESOURCE");
    }

    @Override
    public int compareTo(CidsTrigger o) {
        return -1;
    }
}
