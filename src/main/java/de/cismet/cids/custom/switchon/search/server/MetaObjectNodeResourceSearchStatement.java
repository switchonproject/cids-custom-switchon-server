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
import Sirius.server.newuser.User;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.geom.Polygon;

import org.apache.log4j.Logger;

import java.rmi.RemoteException;

import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.MetaObjectNodeServerSearch;
import de.cismet.cids.server.search.SearchException;

import de.cismet.cismap.commons.jtsgeometryfactories.PostGisGeometryFactory;

/**
 * DOCUMENT ME!
 *
 * @author   FabHewer
 * @version  $Revision$, $Date$
 */
public class MetaObjectNodeResourceSearchStatement extends AbstractCidsServerSearch
        implements MetaObjectNodeServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectNodeResourceSearchStatement.class);
    protected static final String DOMAIN = "SWITCHON";

    //~ Enums ------------------------------------------------------------------

    /**
     * The postgis functions which can be used to search by geometries.
     *
     * <p><b>Note:</b> When a new function is added the order of the parameters might be important, depending on the
     * commutativity of the function.</p>
     *
     * @version  $Revision$, $Date$
     */
    public enum GeometryFunction {

        //~ Enum constants -----------------------------------------------------

        CONTAINS("st_contains"), INTERSECT("st_intersects");

        //~ Instance fields ----------------------------------------------------

        private final String postGisFunction;

        //~ Constructors -------------------------------------------------------

        /**
         * Creates a new GeometryFunction object.
         *
         * @param  postGisFunction  DOCUMENT ME!
         */
        private GeometryFunction(final String postGisFunction) {
            this.postGisFunction = postGisFunction;
        }

        //~ Methods ------------------------------------------------------------

        @Override
        public String toString() {
            return postGisFunction;
        }
    }

    //~ Instance fields --------------------------------------------------------

    protected StringBuilder query;
    protected User user;

    // - Queriables - //
    protected Geometry geometryToSearchFor;

    protected List<String> keywordList;
    protected String topicCategory;
    protected String description;
    protected String title;
    protected Timestamp fromDate;
    protected Timestamp toDate;
    protected String location;
    protected float geoBuffer = 0.000001f;
    protected List<String[]> keywordGroupList;
    protected List<String> negatedKeywordList;
    private int limit = 0;

    private GeometryFunction geometryFunction = GeometryFunction.INTERSECT;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectNodeDokumenteSearchStatement object.
     *
     * @param  user  DOCUMENT ME!
     */
    public MetaObjectNodeResourceSearchStatement(final User user) {
        this.user = user;
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection<MetaObjectNode> performServerSearch() throws SearchException {
        final MetaService ms = (MetaService)getActiveLocalServers().get(DOMAIN);
        if (ms != null) {
            try {
                generateQuery();
                if (LOG.isDebugEnabled()) {
                    LOG.debug("The used query is: " + query.toString());
                }

                final ArrayList<ArrayList> resultset = ms.performCustomSearch(query.toString());
                final ArrayList result = new ArrayList();

                for (final ArrayList dokument : resultset) {
                    final int classID = (Integer)dokument.get(0);
                    final int objectID = (Integer)dokument.get(1);
                    final String name = (String)dokument.get(2);

                    final MetaObjectNode node = new MetaObjectNode(DOMAIN, objectID, classID, name);

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
    protected String generateQuery() {
        query = new StringBuilder();
        query.append("SELECT DISTINCT (SELECT id FROM cs_class WHERE name ilike 'resource')");
        query.append(" as class_id, r.id, r.name FROM resource r");
        if (geometryToSearchFor != null) {
            query.append(" join geom g ON r.spatialcoverage = g.id ");
        }
        if (((keywordList != null) && !keywordList.isEmpty())
                    || ((keywordGroupList != null) && !keywordGroupList.isEmpty())) {
            query.append(" join jt_resource_tag jtrt ON r.id = jtrt.resource_reference")
                    .append(" join tag kwt ON jtrt.tagid = kwt.id")
                    .append(" join taggroup kwt_tg ON kwt.taggroup = kwt_tg.id");
        }
        if (topicCategory != null) {
            query.append(" join tag tct ON r.topiccategory = tct.id");
        }
        if (location != null) {
            query.append(" join tag lct ON r.location = lct.id");
        }
        query.append(" WHERE TRUE ");
        appendGeometry();
        appendKeywords();
        appendKeywordGroups();
        appendKeywordCombination();
        appendTemporal();
        appendTitleDescription();
        appendTopicCategory();
        appendLocation();
        appendNegatedKeywords();
        appendLimit();

        return query.toString();
    }

    // - Append queryables and setter ------------------------------------------
    /**
     * DOCUMENT ME!
     */
    protected void appendGeometry() {
        if (geometryToSearchFor != null) {
            final String geostring = PostGisGeometryFactory.getPostGisCompliantDbString(geometryToSearchFor);
            query.append("and g.geo_field && st_geometryfromtext('").append(geostring).append("')");

            if ((geometryToSearchFor instanceof Polygon) || (geometryToSearchFor instanceof MultiPolygon)) {
                // with buffer for geostring
                query.append(" and ")
                        .append(geometryFunction)
                        .append("(")
                        .append("st_transform( st_buffer( st_transform(st_geometryfromtext('")
                        .append(geostring)
                        .append("'),3857), ")
                        .append(String.valueOf(geoBuffer))
                        .append("), 4326), ")
                        .append("st_buffer(geo_field, 0.000001))"); // <-- why ?????
            } else {
                // without buffer for geostring <-- why ?????
                query.append(" and ")
                        .append(geometryFunction)
                        .append("(")
                        .append("st_geometryfromtext('")
                        .append(geostring)
                        .append("')")
                        .append(", ")
                        .append("st_buffer(geo_field, 0.000001)")
                        .append(")");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTemporal() {
        if (fromDate != null) {
            query.append(" and r.fromDate >= '").append(fromDate.toString()).append("'");
            if (toDate != null) {
                query.append(" and r.toDate < '").append(toDate.toString()).append("'::Timestamp + '1 day'::interval");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendKeywords() {
        if ((keywordList != null) && !keywordList.isEmpty()) {
            String[] keywords = new String[keywordList.size()];

            keywords = keywordList.toArray(keywords);
            query.append("AND (");

            for (int i = 0; i < keywords.length; i++) {
                if (i > 0) {
                    query.append(" OR");
                }

                query.append(" kwt.name ilike '").append(keywords[i]).append("'");
            }

            query.append(" AND kwt_tg.name like 'keywords%')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendKeywordGroups() {
        if ((keywordGroupList != null) && !keywordGroupList.isEmpty()) {
            if ((keywordList != null) && !keywordList.isEmpty()) {
                query.append(" OR (");
            } else {
                query.append(" AND (");
            }

            String currentGroup = keywordGroupList.get(0)[0];
            int inGroupCount = 0;
            int groupCount = 0;

            for (int i = 0; i < keywordGroupList.size(); i++) {
                // check for new group
                if (!keywordGroupList.get(i)[0].equals(currentGroup)) {
                    groupCount++;
                    inGroupCount = 0;
                }

                // start of first or new group
                if (inGroupCount == 0) {
                    // start of new group: close previous group
                    if (groupCount > 0) {
                        currentGroup = keywordGroupList.get(i)[0];
                        query.append(" AND kwt_tg.name ilike '")
                                .append("keywords - ")
                                .append(currentGroup)
                                .append("'")
                                .append(")")
                                .append(" AND");
                    }
                } else {
                    query.append(" OR");
                }

                query.append(" kwt.name ilike '").append(keywordGroupList.get(i)[1]).append("'");
                inGroupCount++;
            }

            // end of loop: close last group
            query.append(" AND kwt_tg.name ilike '").append("keywords - ").append(currentGroup).append("'").append(")");
        }
    }

    /**
     * FAKE AND Statement for keywords. Filter by groups, e.g.
     */
    private void appendKeywordCombination() {
        int size = 0;
        size += (keywordList != null) ? keywordList.size() : 0;
        size += (keywordGroupList != null) ? keywordGroupList.size() : 0;
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTopicCategory() {
        if (topicCategory != null) {
            final StringBuilder topicCategoryParameter = new StringBuilder(topicCategory);
            if (checkForNot(topicCategoryParameter)) {
                query.append(" and tct.name ilike '").append(topicCategoryParameter).append("'");
            } else {
                query.append(" and tct.name NOT ilike '").append(topicCategoryParameter).append("'");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTitleDescription() {
        if ((title != null) && (description == null)) {
            final StringBuilder titleParameter = new StringBuilder(title);
            if (checkForNot(titleParameter)) {
                query.append(" and r.name NOT ilike '%").append(titleParameter).append("%'");
            } else {
                query.append(" and r.name ilike '%").append(titleParameter).append("%'");
            }
        } else if ((title != null) && (description != null)) {
            final StringBuilder titleParameter = new StringBuilder(title);
            if (checkForNot(titleParameter)) {
                query.append(" and (r.name NOT ilike '%").append(titleParameter).append("%'");
            } else {
                query.append(" and (r.name ilike '%").append(titleParameter).append("%'");
            }

            final StringBuilder descriptionParameter = new StringBuilder(description);
            if (checkForNot(descriptionParameter)) {
                query.append(" or r.description NOT ilike '%").append(descriptionParameter).append("%')");
            } else {
                query.append(" or r.description ilike '%").append(descriptionParameter).append("%')");
            }
        } else if ((title == null) && (description != null)) {
            final StringBuilder descriptionParameter = new StringBuilder(description);
            if (checkForNot(descriptionParameter)) {
                query.append(" and r.description ilike '%").append(descriptionParameter).append("%'");
            } else {
                query.append(" and r.description ilike '%").append(descriptionParameter).append("%'");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendLocation() {
        if (location != null) {
            query.append(" and lct.name ilike '").append(location).append("'");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendLimit() {
        if (limit > 0) {
            query.append(" LIMIT ").append(limit);
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendNegatedKeywords() {
        if ((negatedKeywordList != null) && !negatedKeywordList.isEmpty()) {
            String[] negatedKeywords = new String[negatedKeywordList.size()];

            negatedKeywords = negatedKeywordList.toArray(negatedKeywords);
            query.insert(0, "SELECT rresource.class_id, rresource.id, rresource.name FROM (");
            query.append(") AS rresource WHERE rresource.id NOT IN")
                    .append(
                            " (SELECT rr.id from resource rr, jt_resource_tag, tag WHERE jt_resource_tag.resource_reference = rr.id")
                    .append(" AND tag.id = jt_resource_tag.tagid AND");

            for (int i = 0; i < negatedKeywords.length; i++) {
                if (i > 0) {
                    query.append(" OR");
                }

                query.append(" tag.name ilike '").append(negatedKeywords[i]).append("'");
            }
            query.append(")");
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   parameter  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private boolean checkForNot(final StringBuilder parameter) {
        if (parameter.indexOf("!") == 0) {
            parameter.deleteCharAt(0);
            return true;
        }

        return false;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  geometryToSearchFor  DOCUMENT ME!
     */
    public void setGeometryToSearchFor(final Geometry geometryToSearchFor) {
        this.geometryToSearchFor = geometryToSearchFor;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  keywordList  DOCUMENT ME!
     */
    public void setKeywordList(final List<String> keywordList) {
        this.keywordList = keywordList;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  topicCategory  DOCUMENT ME!
     */
    public void setTopicCategory(final String topicCategory) {
        this.topicCategory = topicCategory;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  description  DOCUMENT ME!
     */
    public void setDescription(final String description) {
        this.description = description;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  title  DOCUMENT ME!
     */
    public void setTitle(final String title) {
        this.title = title;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  fromDate  DOCUMENT ME!
     */
    public void setFromDate(final Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  toDate  DOCUMENT ME!
     */
    public void setToDate(final Timestamp toDate) {
        this.toDate = toDate;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  location  DOCUMENT ME!
     */
    public void setLocation(final String location) {
        this.location = location;
    }

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public GeometryFunction getGeometryFunction() {
        return geometryFunction;
    }

    /**
     * The geometryFunction influences the behavior of the search by a geometry.
     *
     * @param  geometryFunction  DOCUMENT ME!
     */
    public void setGeometryFunction(final GeometryFunction geometryFunction) {
        this.geometryFunction = geometryFunction;
    }

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public float getGeoBuffer() {
        return geoBuffer;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  geoBuffer  DOCUMENT ME!
     */
    public void setGeoBuffer(final float geoBuffer) {
        if ((geoBuffer > 0) && (geoBuffer < 10000000000L)) {
            this.geoBuffer = geoBuffer;
        } else {
            LOG.warn("invalid geo buffer: " + geoBuffer);
        }
    }

    /**
     * Get the value of limit.
     *
     * @return  the value of limit
     */
    public int getLimit() {
        return limit;
    }

    /**
     * Set the value of limit.
     *
     * @param  limit  new value of limit
     */
    public void setLimit(final int limit) {
        this.limit = limit;
    }

    /**
     * Get the value of keywordGroupList.
     *
     * @return  the value of keywordGroupList
     */
    public List<String[]> getKeywordGroupList() {
        return keywordGroupList;
    }

    /**
     * Set the value of keywordGroupList.
     *
     * @param  keywordGroupList  new value of keywordGroupList
     */
    public void setKeywordGroupList(final List<String[]> keywordGroupList) {
        this.keywordGroupList = keywordGroupList;
    }

    /**
     * Get the value of negatedKeywordsLis.
     *
     * @return  the value of negatedKeywordsLis
     */
    public List<String> getNegatedKeywordList() {
        return negatedKeywordList;
    }

    /**
     * Set the value of negatedKeywordsLis.
     *
     * @param  negatedKeywordList  new value of negatedKeywordsLis
     */
    public void setNegatedKeywordList(final List<String> negatedKeywordList) {
        this.negatedKeywordList = negatedKeywordList;
    }
}
