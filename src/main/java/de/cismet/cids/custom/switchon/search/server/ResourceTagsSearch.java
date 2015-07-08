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

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

import java.util.ArrayList;
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
 * Returns all tags of the specified group that are actually assigned to resources in the Meta-Data Repository.
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = RestApiCidsServerSearch.class)
public class ResourceTagsSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final transient Logger LOG = Logger.getLogger(ResourceTagsSearch.class);
    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(ResourceTagsSearch.class.getName());
        SEARCH_INFO.setName(ResourceTagsSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Search for tags of the specified group that are actually assigned to resources in the Meta-Data Repository");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        final SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("taggroup");
        searchParameterInfo.setType(Type.STRING);
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.STRING);
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    //~ Instance fields --------------------------------------------------------

    private String taggroup;
    private MetaService metaService;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new ResourceTagsSearch object.
     */
    public ResourceTagsSearch() {
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Get the value of taggroup.
     *
     * @return  the value of taggroup
     */
    public String getTaggroup() {
        return taggroup;
    }

    /**
     * Set the value of taggroup.
     *
     * @param  taggroup  new value of taggroup
     */
    public void setTaggroup(final String taggroup) {
        this.taggroup = taggroup;
    }

    @Override
    public Collection performServerSearch() throws SearchException {
        final LinkedList<String> resourceTags = new LinkedList<String>();

        if (this.metaService == null) {
            if (this.getActiveLocalServers().containsKey(MetaObjectNodeResourceSearchStatement.DOMAIN)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("initializing MetaService");
                }
                this.metaService = (MetaService)getActiveLocalServers().get(
                        MetaObjectNodeResourceSearchStatement.DOMAIN);
            } else {
                final String msg = "no metaservice for domain '" + MetaObjectNodeResourceSearchStatement.DOMAIN
                            + "' found!";
                LOG.error(msg);
                throw new SearchException(msg);
            }
        }

        if ((this.getTaggroup() != null) && !this.getTaggroup().isEmpty()) {
            try {
                final String query = "SELECT DISTINCT tag.name\n"
                            + "FROM tag\n"
                            + "INNER JOIN jt_resource_tag ON jt_resource_tag.tagid = tag.id\n"
                            + "WHERE taggroup IN\n"
                            + "    (SELECT id\n"
                            + "     FROM taggroup\n"
                            + "     WHERE taggroup.name ILIKE '%"
                            + this.getTaggroup()
                            + "%')\n"
                            + "ORDER BY tag.name;";
                if (LOG.isDebugEnabled()) {
                    LOG.debug("search for used tags of taggroup '" + this.getTaggroup() + "' with query: \n"
                                + query);
                }

                final ArrayList<ArrayList> resultset = metaService.performCustomSearch(query); // NOI18N

                if (!resultset.isEmpty()) {
                    for (final ArrayList row : resultset) {
                        final String tagName = row.get(0).toString();
                        resourceTags.add(tagName);
                    }
                } else {
                    LOG.warn("no used tags of taggroup '" + this.getTaggroup()
                                + "' found, returning empty result");
                }
            } catch (final Exception ex) {
                final String message = "cannot search for used tags of taggroup '"
                            + this.getTaggroup()
                            + "': " + ex.getMessage();
                LOG.error(message, ex);
                throw new SearchException(message, ex); // NOI18N
            }
        } else {
            LOG.warn("taggroup is empty, cannot search for tags. return empty tag list!");
        }

        LOG.info(resourceTags.size() + " used tags for tag group '" + taggroup + "' found");
        return resourceTags;
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
