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
import Sirius.server.newuser.User;

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

import java.rmi.RemoteException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import de.cismet.cids.base.types.Type;

import de.cismet.cids.server.api.types.SearchInfo;
import de.cismet.cids.server.api.types.SearchParameterInfo;
import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.LookupableServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Finds the provenance relationship of a resource r. This is the relationship, whose toresource is the id of r.
 *
 * @author   Gilles Baatz
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = LookupableServerSearch.class)
public final class MetaObjectProvenanceRelationshipSearchStatement extends AbstractCidsServerSearch
        implements LookupableServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectProvenanceRelationshipSearchStatement.class);
    private static final String DOMAIN = "SWITCHON";

    //~ Instance fields --------------------------------------------------------

// private String query = " select (SELECT id "
// + " FROM    cs_class "
// + " WHERE   name = 'relationship' "
// + " ), rel.id, rel.name from relationship as rel "
// + " where toresource = ";
//
    private String query = " select * from relationship where toresource = ";

    private int resourceId = -1;

    private final SearchInfo searchInfo;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectProvenanceRelationshipSearchStatement object.
     */
    public MetaObjectProvenanceRelationshipSearchStatement() {
        searchInfo = new SearchInfo();
        searchInfo.setKey(this.getClass().getName());
        searchInfo.setName(this.getClass().getSimpleName());
        searchInfo.setDescription(
            "Finds the provenance relationship of a resource r. This is the relationship, whose toresource is the id of r.");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        final SearchParameterInfo searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("ResourceId");
        searchParameterInfo.setType(Type.INTEGER);
        parameterDescription.add(searchParameterInfo);
        searchInfo.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.ENTITY_REFERENCE);
        searchInfo.setResultDescription(resultParameterInfo);
    }

    /**
     * Creates a new MetaObjectProvenanceRelationshipSearchStatement object.
     *
     * @param  user        DOCUMENT ME!
     * @param  resourceId  DOCUMENT ME!
     */
    public MetaObjectProvenanceRelationshipSearchStatement(final User user, final int resourceId) {
        this();
        this.setResourceId(resourceId);
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection performServerSearch() throws SearchException {
        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);
        if (ms != null) {
            try {
                // final MetaObject[] metaObjects = ms.getMetaObject(this.getUser(), query);

                final MetaObject[] metaObjects = ms.getLightweightMetaObjectsByQuery(
                        18,
                        this.getUser(),
                        this.query,
                        new String[] { "name", "description", "type" });

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

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public int getResourceId() {
        return resourceId;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  resourceId  DOCUMENT ME!
     */
    public void setResourceId(final int resourceId) {
        this.resourceId = resourceId;
        this.query += resourceId;
    }

    @Override
    public SearchInfo getSearchInfo() {
        return this.searchInfo;
    }
}
