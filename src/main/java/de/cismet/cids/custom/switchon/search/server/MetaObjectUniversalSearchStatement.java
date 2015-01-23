/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.cismet.cids.custom.switchon.search.server;

import Sirius.server.middleware.interfaces.domainserver.MetaService;
import Sirius.server.middleware.types.MetaObjectNode;

import org.apache.log4j.Logger;

import java.rmi.RemoteException;

import java.util.ArrayList;
import java.util.Collection;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.CidsServerSearch;
import de.cismet.cids.server.search.MetaObjectNodeServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Finds resources that meets criteria defined by a query.
 *
 * @author   jruiz
 * @version  $Revision$, $Date$
 */
@org.openide.util.lookup.ServiceProvider(service = CidsServerSearch.class)
public class MetaObjectUniversalSearchStatement extends AbstractCidsServerSearch implements MetaObjectNodeServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectUniversalSearchStatement.class);

    //~ Instance fields --------------------------------------------------------

    protected StringBuilder sqlQuery;
    protected boolean objectFilled = true;

    protected String query;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectQueryResourceSearchStatement object.
     */
    public MetaObjectUniversalSearchStatement() {
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @return  The query that defines the criteria of the resources that have to be found.
     */
    public String getQuery() {
        if (query == null) {
            return ""; // default
        }
        return query;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  query  The query that defines the criteria of the resources that have
     */
    public void setQuery(final String query) {
        this.query = query;
    }

    @Override
    public Collection<MetaObjectNode> performServerSearch() throws SearchException {
        final MetaService ms = (MetaService)getActiveLocalServers().get(getUser().getDomain());
        if (ms != null) {
            try {
                generateQuery();

                final ArrayList<ArrayList> resultset = ms.performCustomSearch(sqlQuery.toString());
                final ArrayList result = new ArrayList();

                for (final ArrayList dokument : resultset) {
                    final int classID = (Integer)dokument.get(0);
                    final int objectID = (Integer)dokument.get(1);
                    final String name = (String)dokument.get(2);

                    final MetaObjectNode node = new MetaObjectNode(getUser().getDomain(), objectID, classID, name);
                    result.add(node);
                }
                return result;
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
    private String generateQuery() {
        sqlQuery = new StringBuilder();
        sqlQuery.append("SELECT DISTINCT " + "(SELECT id "
                    + "FROM    cs_class "
                    + "WHERE   name ilike 'resource' "
                    + "), r.id, r.name ");
        sqlQuery.append(" FROM resource r");
        sqlQuery.append(" WHERE TRUE LIMIT 10");

        return sqlQuery.toString();
    }
}
