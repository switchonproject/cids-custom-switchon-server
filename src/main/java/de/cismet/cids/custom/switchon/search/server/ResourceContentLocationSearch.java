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

import lombok.Getter;
import lombok.Setter;

import org.apache.log4j.Logger;

import java.rmi.RemoteException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.SearchException;

import de.cismet.cidsx.base.types.Type;

import de.cismet.cidsx.server.api.types.SearchInfo;
import de.cismet.cidsx.server.api.types.SearchParameterInfo;
import de.cismet.cidsx.server.search.RestApiCidsServerSearch;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
public class ResourceContentLocationSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOGGER = Logger.getLogger(ResourceContentLocationSearch.class);
    private static final String DOMAIN = "SWITCHON";

    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(ClassNameSearch.class.getName());
        SEARCH_INFO.setName(ClassNameSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Content Location (URL) Search for REST Clients");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        final SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("url");
        searchParameterInfo.setType(Type.STRING);
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setDescription("Collection of Entities or empty collection");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.ENTITY);
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    private static final String QUERY_TEMPLATE = "SELECT\n"
                + "  (SELECT id\n"
                + "   FROM cs_class\n"
                + "   WHERE name ILIKE 'resource'), resource.name,\n"
                + "                                 resource.id\n"
                + "FROM resource\n"
                + "INNER JOIN jt_resource_representation jtrr ON resource.id = jtrr.resource_reference\n"
                + "INNER JOIN representation ON jtrr.representationid = representation.id\n"
                + "WHERE representation.contentlocation ILIKE '";

    //~ Instance fields --------------------------------------------------------

    @Getter @Setter private String url;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new ResourceContentLocationSearch object.
     */
    public ResourceContentLocationSearch() {
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection<MetaObject> performServerSearch() throws SearchException {
        if ((this.url == null) || (this.url.length() == 0)) {
            final String msg = "'url' is a required parameter of this search function!";
            LOGGER.error(msg);
            throw new SearchException(msg); // NOI18N
        }

        final String query = (url + QUERY_TEMPLATE + "'");
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(query);
        }

        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);
        if (ms != null) {
            try {
                final MetaObject[] metaObjects = ms.getMetaObject(this.getUser(), query);
                final ArrayList<MetaObject> collection = new ArrayList<MetaObject>(Arrays.asList(
                            metaObjects));
                return collection;
            } catch (RemoteException ex) {
                LOGGER.error(ex.getMessage(), ex);
                throw new SearchException(ex.getMessage());
            }
        } else {
            LOGGER.error("active local server not found"); // NOI18N
            throw new SearchException("active local server not found");
        }
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
