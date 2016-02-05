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

import lombok.Getter;
import lombok.Setter;

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

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
 * Get all tags of one or more taggroups.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = RestApiCidsServerSearch.class)
public final class TagsSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOGGER = Logger.getLogger(TagsSearch.class);
    private static final String DOMAIN = "SWITCHON";

    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(TagsSearch.class.getName());
        SEARCH_INFO.setName(TagsSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Tags Search for SWITCH-ON pure REST clients");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("taggroup");
        searchParameterInfo.setType(Type.STRING);
        searchParameterInfo.setDescription("name of the tag group");
        parameterDescription.add(searchParameterInfo);

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("tags");
        searchParameterInfo.setType(Type.STRING);
        searchParameterInfo.setDescription("comma separated list of tag names");
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setDescription("Collection of Entities or empty collection");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.ENTITY);
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    //~ Instance fields --------------------------------------------------------

    @Getter @Setter private String taggroup;
    @Getter @Setter private String tags;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new PostFilterTagsSearch object.
     */
    public TagsSearch() {
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection<MetaObject> performServerSearch() throws SearchException {
        final String[] tagArray;
        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);
        final StringBuilder queryBuilder = new StringBuilder();

        if ((this.taggroup == null) || this.taggroup.isEmpty()) {
            final String msg = "'taggroup' is a required parameter of this search function!";
            LOGGER.error(msg);
            throw new SearchException(msg); // NOI18N
        }

        if ((this.tags != null) && !this.tags.isEmpty()) {
            tagArray = this.tags.split(",");
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(tagArray.length + " tag found in '" + this.tags + "'");
            }
        } else {
            tagArray = new String[0];
        }

        LOGGER.info("searching for tags of taggroup '" + taggroup
                    + "' and restricting by " + tagArray.length + " tags");

        if (ms == null) {
            final String msg = "no metaservice for domain '" + DOMAIN + "' found!";
            LOGGER.error(msg);
            throw new SearchException(msg); // NOI18N
        }

        queryBuilder.append("SELECT DISTINCT "
                    + "  (SELECT id\n"
                    + "   FROM cs_class\n"
                    + "   WHERE name ILIKE 'tag') as class_id, "
                    + "   tag.id AS object_id, tag.name \n");
        queryBuilder.append("FROM tag \n");
        queryBuilder.append("JOIN taggroup ON tag.taggroup = taggroup.id \n");
        queryBuilder.append("WHERE taggroup.name = '").append(this.taggroup).append("' \n");

        if (tagArray.length > 0) {
            queryBuilder.append("AND tag.name in (");
            for (int i = 0; i < tagArray.length; i++) {
                if (i > 0) {
                    queryBuilder.append(',');
                }
                queryBuilder.append('\'').append(tagArray[i]).append('\'');
            }

            queryBuilder.append(") \n");
        }

        queryBuilder.append("ORDER BY tag.name;");

        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(queryBuilder.toString());
            }

            final MetaObject[] metaObjects = ms.getMetaObject(this.getUser(), queryBuilder.toString());
            final ArrayList<MetaObject> collection = new ArrayList<MetaObject>(Arrays.asList(
                        metaObjects));

            if ((tagArray.length > 0) && (collection.size() != tagArray.length)) {
                LOGGER.warn("expected to get " + tagArray.length + " tags but actually found "
                            + collection.size() + " tags!");
            }

            if (LOGGER.isDebugEnabled()) {
                LOGGER.info(collection.size() + " different tags for " + tagArray.length
                            + " taggroups in query result found");
            }

            return collection;
        } catch (final RemoteException re) {
            throw new SearchException("search for tags could not be performed", re); // NOI18N
        }
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
