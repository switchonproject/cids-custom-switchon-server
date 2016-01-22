/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.server;

import Sirius.server.middleware.interfaces.domainserver.MetaService;

import lombok.Getter;
import lombok.Setter;

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

import java.rmi.RemoteException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;

import de.cismet.cids.custom.switchon.search.server.types.Tag;
import de.cismet.cids.custom.switchon.search.server.types.Taggroup;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.SearchException;

import de.cismet.cidsx.base.types.Type;

import de.cismet.cidsx.server.api.types.SearchInfo;
import de.cismet.cidsx.server.api.types.SearchParameterInfo;
import de.cismet.cidsx.server.search.RestApiCidsServerSearch;

/**
 * Get all tags of one or more taggroups.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = RestApiCidsServerSearch.class)
public final class TagsSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(TagsSearch.class);
    private static final String DOMAIN = "SWITCHON";

    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(TagsSearch.class.getName());
        SEARCH_INFO.setName(TagsSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Tags Search for SWITCH-ON pure REST clients");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        final SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("taggroups");
        searchParameterInfo.setType(Type.STRING);
        searchParameterInfo.setDescription("comma separated list of tag groups");
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setDescription("<Map.Entry<String, List<Tag>> Collection");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.JAVA_CLASS);
        resultParameterInfo.setAdditionalTypeInfo("com.fasterxml.jackson.databind.node.ObjectNode");
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    //~ Instance fields --------------------------------------------------------

    @Getter @Setter private String taggroups;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new PostFilterTagsSearch object.
     */
    public TagsSearch() {
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection performServerSearch() throws SearchException {
        final String[] taggroupsArray;
        if ((this.taggroups == null) || this.taggroups.isEmpty()) {
            final String msg = "'taggroups' is a required parameter of this search function!";
            LOG.error(msg);
            throw new SearchException(msg); // NOI18N
        } else {
            taggroupsArray = this.taggroups.split(",");
            if (LOG.isDebugEnabled()) {
                LOG.debug(taggroupsArray.length + " tag groups found in '" + this.taggroups + "'");
            }
        }

        final HashMap<String, List<Tag>> result = new LinkedHashMap<String, List<Tag>>();

        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);

        if (ms == null) {
            final String msg = "no metaservice for domain '" + DOMAIN + "' found!";
            LOG.error(msg);
            throw new SearchException(msg); // NOI18N
        }

        if (LOG.isDebugEnabled()) {
            LOG.info("retrieving tags of " + taggroupsArray.length + " tag groups");
        }

        final StringBuilder queryBuilder = new StringBuilder();

        queryBuilder.append("SELECT DISTINCT tag.id AS tag_id, \n");
        queryBuilder.append("       tag.name AS tag_name, \n");
        queryBuilder.append("       tag.description AS tag_description, \n");
        queryBuilder.append("       taggroup.id AS taggroup_id, \n");
        queryBuilder.append("       taggroup.name AS taggroup_name, \n");
        queryBuilder.append("       taggroup.description AS taggroup_description \n");
        queryBuilder.append("FROM tag \n");
        queryBuilder.append("JOIN taggroup ON tag.taggroup = taggroup.id \n");
        queryBuilder.append("WHERE taggroup.name in (");

        for (int i = 0; i < taggroupsArray.length; i++) {
            if (i > 0) {
                queryBuilder.append(',');
            }
            queryBuilder.append('\'').append(taggroupsArray[i]).append('\'');
        }

        queryBuilder.append(") \n");
        queryBuilder.append("ORDER BY taggroup.name, tag.name;");

        try {
            if (LOG.isDebugEnabled()) {
                LOG.debug(queryBuilder.toString());
            }
            final ArrayList<ArrayList> resultset = ms.performCustomSearch(queryBuilder.toString()); // NOI18N

            if (LOG.isDebugEnabled()) {
                LOG.debug(resultset.size() + " different tags for " + taggroupsArray.length
                            + " taggroups in query result found");
            }

            int i = 0;
            // add tag name + tag results count to the tag group list
            for (final ArrayList row : resultset) {
                final int tagId = (int)row.get(0);
                final String tagName = String.valueOf(row.get(1));
                final String tagDescription = String.valueOf(row.get(2));

                final int taggroupId = (int)row.get(3);
                final String taggroupName = String.valueOf(row.get(4));
                final String taggroupDescription = String.valueOf(row.get(5));

                final Taggroup taggroup = new Taggroup(taggroupId, taggroupName, taggroupDescription);
                final Tag tag = new Tag(tagId, tagName, tagDescription, taggroup);

                if (!result.containsKey(taggroupName)) {
                    if (LOG.isDebugEnabled()) {
                        LOG.debug("collecting tags of taggroup '" + taggroupName + "'");
                    }
                    result.put(taggroupName, new ArrayList<Tag>());
                }
                final List<Tag> tagList = result.get(taggroupName);
                tagList.add(tag);

                i++;
            }

            if (taggroupsArray.length != result.size()) {
                LOG.warn("expected to get tags of " + taggroupsArray.length
                            + " taggroups but found tags of " + result.size() + taggroups + "'!");
            }

            return result.entrySet();
        } catch (final RemoteException re) {
            throw new SearchException("search for tags could not be performed", re); // NOI18N
        }
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
