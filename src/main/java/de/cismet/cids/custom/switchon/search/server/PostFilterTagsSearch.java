/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.server;

import Sirius.server.middleware.interfaces.domainserver.MetaService;

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

import java.io.UnsupportedEncodingException;

import java.net.URLDecoder;

import java.rmi.RemoteException;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.SearchException;

import de.cismet.cidsx.base.types.Type;

import de.cismet.cidsx.server.api.types.SearchInfo;
import de.cismet.cidsx.server.api.types.SearchParameterInfo;
import de.cismet.cidsx.server.search.RestApiCidsServerSearch;

/**
 * Enumerate tags of a whole search result set. Tags can be be used to apply a post filter to the search result.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = RestApiCidsServerSearch.class)
public final class PostFilterTagsSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(PostFilterTagsSearch.class);
    private static final String DOMAIN = "SWITCHON";

    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(PostFilterTagsSearch.class.getName());
        SEARCH_INFO.setName(PostFilterTagsSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Post Filter Tags Search for SWITCH-ON pure REST clients");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("query");
        searchParameterInfo.setType(Type.STRING);
        searchParameterInfo.setDescription("The Universal Query Format is parameter:\"value:\", "
                    + "e.g. keyword:\"water\"");
        parameterDescription.add(searchParameterInfo);

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("filterTagGroups");
        searchParameterInfo.setType(Type.STRING);
        searchParameterInfo.setDescription("comma separated list of tag groups used for post search filtering");
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setDescription("<Map.Entry<String, List<Map.Entry<String, String>>>> Collection");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.JAVA_CLASS);
        resultParameterInfo.setAdditionalTypeInfo("com.fasterxml.jackson.databind.node.ObjectNode");
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    //~ Instance fields --------------------------------------------------------

    private final Map<String, String> TAGGROUPS = new HashMap<String, String>();
    private final MetaObjectUniversalSearchStatement metaObjectUniversalSearchStatement;

    private final String TAGGROUP_FILTER_KEYWORD = "keyword";
    private final String TAGGROUP_FILTER_KEYWORD_XCUAHSI = "keyword-xcuahsi";
    private final String TAGGROUP_FILTER_ACCESS_CONDITONS = "access-condition";
    private final String TAGGROUP_FILTER_PROTOCOL = "protocol";
    private final String TAGGROUP_FILTER_FUNCTION = "function";
    private final String TAGGROUP_FILTER_RESOURCE_TYPE = "resource-type";
    private final String TAGGROUP_FILTER_TOTAL_RESOURCES = "$total";

    private String query;
    private String filterTagGroups;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new PostFilterTagsSearch object.
     */
    public PostFilterTagsSearch() {
        this.metaObjectUniversalSearchStatement = new MetaObjectUniversalSearchStatement();

        TAGGROUPS.put(TAGGROUP_FILTER_KEYWORD, "keywords%");
        TAGGROUPS.put(TAGGROUP_FILTER_KEYWORD_XCUAHSI, "keywords - X-CUAHSI");
        TAGGROUPS.put(TAGGROUP_FILTER_ACCESS_CONDITONS, "access conditions");
        TAGGROUPS.put(TAGGROUP_FILTER_PROTOCOL, "protocol");
        TAGGROUPS.put(TAGGROUP_FILTER_FUNCTION, "function");
        TAGGROUPS.put(TAGGROUP_FILTER_RESOURCE_TYPE, "resource type");
        TAGGROUPS.put(TAGGROUP_FILTER_TOTAL_RESOURCES, "$total");
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection performServerSearch() throws SearchException {
        if ((this.query == null) || (this.query.length() == 0)) {
            final String msg = "'query' is a required parameter of this search function!";
            LOG.error(msg);
            throw new SearchException(msg); // NOI18N
        }

        String[] filterTagGroupsArray;
        if ((this.filterTagGroups == null) || (this.filterTagGroups.length() == 0)) {
            final String msg = "parameter 'filterTagGroup' is missing, collecting tags of all supported tag groups!";
            LOG.warn(msg);
            filterTagGroupsArray = TAGGROUPS.keySet().toArray(new String[TAGGROUPS.keySet().size()]);
        } else {
            filterTagGroupsArray = this.filterTagGroups.split(",");
            if (LOG.isDebugEnabled()) {
                LOG.debug(filterTagGroupsArray.length + " filter tag groups found in '" + this.filterTagGroups + "'");
            }
        }

        if ((this.metaObjectUniversalSearchStatement.getUser() == null)
                    || (this.metaObjectUniversalSearchStatement.getActiveLocalServers() == null)) {
            if (LOG.isDebugEnabled()) {
                LOG.debug("initializing MetaObjectUniversalSearchStatement");
            }
            this.metaObjectUniversalSearchStatement.setUser(this.getUser());
            this.metaObjectUniversalSearchStatement.setActiveLocalServers(this.getActiveLocalServers());
        }

        final List<Map.Entry<String, List<Map.Entry<String, String>>>> result =
            new ArrayList<Map.Entry<String, List<Map.Entry<String, String>>>>();

        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);

        if (ms == null) {
            final String msg = "no metaservice for domain '" + DOMAIN + "' found!";
            LOG.error(msg);
            throw new SearchException(msg); // NOI18N
        }
        if (LOG.isDebugEnabled()) {
            LOG.debug("The input REST query is \n" + this.query);
        }
        final MetaObjectNodeResourceSearchStatement metaObjectNodeResourceSearchStatement = this
                    .metaObjectUniversalSearchStatement.interpretQuery(query);
        metaObjectNodeResourceSearchStatement.setLimit(0);
        metaObjectNodeResourceSearchStatement.setOffset(0);
        final String baseSqlQuery = metaObjectNodeResourceSearchStatement.generateQuery();
        if (LOG.isDebugEnabled()) {
            LOG.debug("The generated base SQL query is \n" + baseSqlQuery);
        }

        try {
            for (String filterParameter : filterTagGroupsArray) {
                filterParameter = filterParameter.trim();
                if (TAGGROUPS.containsKey(filterParameter)) {
                    final String tagGroup = TAGGROUPS.get(filterParameter);
                    final StringBuilder queryBuilder = new StringBuilder(baseSqlQuery);
                    final String baseQuery = "SELECT rtag.name as name, count(rtag.name) AS count FROM (";
                    final String groupByQuery = " GROUP BY rtag.name ORDER BY rtag.name";

                    // build the query ....
                    switch (filterParameter) {
                        case TAGGROUP_FILTER_KEYWORD:
                        case TAGGROUP_FILTER_KEYWORD_XCUAHSI: {
                            queryBuilder.insert(0, baseQuery);
                            queryBuilder.append(") rrr");
                            queryBuilder.append(
                                " INNER JOIN jt_resource_tag rjtrt ON rrr.id = rjtrt.resource_reference");
                            queryBuilder.append(" INNER JOIN tag rtag ON rjtrt.tagid = rtag.id");
                            queryBuilder.append(" INNER JOIN taggroup rtag_tg ON rtag.taggroup = rtag_tg.id");
                            queryBuilder.append(" AND");
                            queryBuilder.append(" to_tsvector('english', rtag_tg.name) @@ to_tsquery('''")
                                    .append(tagGroup)
                                    .append("''')");
                            queryBuilder.append(groupByQuery);
                            break;
                        }
                        case TAGGROUP_FILTER_ACCESS_CONDITONS: {
                            queryBuilder.insert(0, baseQuery);
                            queryBuilder.append(") rrr,");
                            queryBuilder.append(
                                " resource, tag rtag WHERE rrr.id = resource.id and resource.accessconditions = rtag.id");
                            queryBuilder.append(" GROUP BY rtag.name ORDER BY rtag.name");
                            break;
                        }
                        case TAGGROUP_FILTER_RESOURCE_TYPE: {
                            queryBuilder.insert(0, baseQuery);
                            queryBuilder.append(") rrr");
                            queryBuilder.append(
                                " INNER JOIN jt_resource_representation ON rrr.id = resource_reference");
                            queryBuilder.append(
                                " INNER JOIN representation ON jt_resource_representation.representationid = representation.id");
                            queryBuilder.append(" INNER JOIN tag rtag ON representation.type = rtag.id");
                            queryBuilder.append(groupByQuery);
                            break;
                        }
                        case TAGGROUP_FILTER_PROTOCOL: {
                            queryBuilder.insert(0, baseQuery);
                            queryBuilder.append(") rrr");
                            queryBuilder.append(
                                " INNER JOIN jt_resource_representation ON rrr.id = resource_reference");
                            queryBuilder.append(
                                " INNER JOIN representation ON jt_resource_representation.representationid = representation.id");
                            queryBuilder.append(" INNER JOIN tag rtag ON representation.protocol = rtag.id");
                            queryBuilder.append(groupByQuery);
                            break;
                        }
                        case TAGGROUP_FILTER_FUNCTION: {
                            queryBuilder.insert(0, baseQuery);
                            queryBuilder.append(") rrr");
                            queryBuilder.append(
                                " INNER JOIN jt_resource_representation ON rrr.id = resource_reference");
                            queryBuilder.append(
                                " INNER JOIN representation ON jt_resource_representation.representationid = representation.id");
                            queryBuilder.append(" INNER JOIN tag rtag ON representation.function = rtag.id");
                            queryBuilder.append(groupByQuery);
                            break;
                        }
                        case TAGGROUP_FILTER_TOTAL_RESOURCES: {
                            // add to colums to satify compatibility with tag lists (tag name, results count)
                            // FIXME: This ia  workaround for missing generic $total search results functionality
                            queryBuilder.insert(0, "SELECT '$total' as total, COUNT(DISTINCT rrr.id) as count FROM (");
                            queryBuilder.append(") rrr");
                            break;
                        }
                        default: {
                            final String msg = "the tag filter parameter '" + filterParameter
                                        + "' is currently not supported";
                            LOG.warn(msg);
                            throw new SearchException(msg);
                        }
                    }

                    if (LOG.isDebugEnabled()) {
                        LOG.debug("performing search for tags of group '" + filterParameter + "' with query: \n"
                                    + queryBuilder);
                    }
                    final ArrayList<ArrayList> resultset = ms.performCustomSearch(queryBuilder.toString()); // NOI18N
                    if (LOG.isDebugEnabled()) {
                        LOG.debug(resultset.size() + " different tags for group '" + filterParameter
                                    + "' in query result found");
                    }

                    final List<Map.Entry<String, String>> tagList = new ArrayList<Map.Entry<String, String>>(
                            resultset.size());
                    int i = 0;

                    // add tag name + tag results count to the tag group list
                    for (final ArrayList row : resultset) {
                        final String tagName = String.valueOf(row.get(0));
                        final String tagCount = String.valueOf(row.get(1));

                        final Map.Entry<String, String> tagListEntry = new AbstractMap.SimpleEntry<String, String>(
                                tagName,
                                tagCount);
                        tagList.add(tagListEntry);
                        i++;
                    }

                    // add the tag group list to the overall results list
                    final Map.Entry<String, List<Map.Entry<String, String>>> resultEntry =
                        new AbstractMap.SimpleEntry<String, List<Map.Entry<String, String>>>(
                            filterParameter,
                            tagList);
                    result.add(resultEntry);
                } else {
                    final String msg = "the tag filter parameter '" + filterParameter
                                + "' is unknown and cannot be mapped to a respective tag group";
                    LOG.error(msg);
                    throw new SearchException(msg); // NOI18N
                }
            }
            return result;
        } catch (final RemoteException re) {
            throw new SearchException("search for filter tag groups could not be performed", re); // NOI18N
        }
    }

    /**
     * Get the value of query.
     *
     * @return  the value of query
     */
    public String getQuery() {
        return query;
    }

    /**
     * Set the value of query.
     *
     * @param   query  new value of query
     *
     * @throws  UnsupportedOperationException  DOCUMENT ME!
     */
    public void setQuery(final String query) {
        try {
            this.query = URLDecoder.decode(query, "UTF-8");
        } catch (final UnsupportedEncodingException ex) {
            throw new UnsupportedOperationException("query '" + query + "' couldn't be decoded", ex);
        }
    }

    /**
     * Get the value of filterTagGroups.
     *
     * @return  the value of filterTagGroup
     */
    public String getFilterTagGroups() {
        return filterTagGroups;
    }

    /**
     * Set the value of filterTagGroups.
     *
     * @param  filterTagGroups  new value of filterTagGroup
     */
    public void setFilterTagGroups(final String filterTagGroups) {
        this.filterTagGroups = filterTagGroups;
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
