/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.server;

import Sirius.server.middleware.interfaces.domainserver.MetaService;
import Sirius.server.middleware.types.MetaObject;
import Sirius.server.middleware.types.MetaObjectNode;
import Sirius.server.newuser.User;

import org.apache.log4j.Logger;

import java.rmi.RemoteException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Finds the provenance relationship of a resource r. This is the relationship, whose toresource is the id of r.
 *
 * @author   Gilles Baatz
 * @version  $Revision$, $Date$
 */
public class MetaObjectProvenanceRelationshipSearchStatement extends AbstractCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectProvenanceRelationshipSearchStatement.class);
    private static final String DOMAIN = "SWITCHON";

    //~ Instance fields --------------------------------------------------------

    private String query = " select (SELECT id "
                + " FROM    cs_class "
                + " WHERE   name = 'relationship' "
                + " ), rel.id, rel.name from relationship as rel "
                + " where toresource = ";
    private User user;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectProvenanceRelationshipSearchStatement object.
     *
     * @param  user        DOCUMENT ME!
     * @param  resourceId  DOCUMENT ME!
     */
    public MetaObjectProvenanceRelationshipSearchStatement(final User user, final int resourceId) {
        this.query += resourceId;
        this.user = user;
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection performServerSearch() throws SearchException {
        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);
        if (ms != null) {
            try {
                final MetaObject[] metaObjects = ms.getMetaObject(user, query);
                final ArrayList<MetaObject> collection = new ArrayList<MetaObject>(Arrays.asList(
                            metaObjects));
                return collection;
            } catch (RemoteException ex) {
                LOG.error(ex.getMessage(), ex);
            }
        } else {
            LOG.error("active local server not found"); // NOI18N
        }
        return null;
    }
}
