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
 * Finds the usage relationships of a resource r. This means that r is used in this relationships as source, to create
 * another resource.
 *
 * @author   Gilles Baatz
 * @version  $Revision$, $Date$
 */
public class MetaObjectUsageRelationshipsSearchStatement extends AbstractCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectUsageRelationshipsSearchStatement.class);
    private static final String DOMAIN = "SWITCHON";

    //~ Instance fields --------------------------------------------------------

    private User user;

    private String query = " select (SELECT id "
                + " FROM    cs_class "
                + " WHERE   name ilike 'relationship' "
                + " ), rel.id, rel.name from relationship as rel "
                + " join jt_fromresource_relationship as jt on jt.relationship_reference = rel.id "
                + "where jt.resid =  ";

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectUsageRelationshipsSearchStatement object.
     *
     * @param  user        DOCUMENT ME!
     * @param  resourceId  DOCUMENT ME!
     */
    public MetaObjectUsageRelationshipsSearchStatement(final User user, final int resourceId) {
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
