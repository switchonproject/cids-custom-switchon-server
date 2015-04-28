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
    protected long geoBuffer = 0;
    protected List<String[]> keywordGroupList;
    protected List<String> negatedKeywordList;
    protected String collection;
    protected List<String> functionList;
    protected List<String> negatedFunctionList;
    protected List<String> accessConditions;
    protected List<String> negatedAccessConditions;
    protected int offset = 0;
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
        query.append("SELECT DISTINCT (SELECT id FROM cs_class WHERE name = 'resource')");
        query.append(" AS class_id, r.id, r.name FROM resource r");

        this.joinKeywords();
        this.joinTopicCategory();
        this.joinCollection();
        this.joinAccessConditions();
        this.joinFunctions();
        this.joinGeometry();

        query.append(" WHERE r.id IS NOT NULL ");

        appendTemporal();
        appendTitleDescription();
        appendKeywordCombination();
        appendOrderBy();
        appendNegatedKeywords();
        appendNegatedFunctions();
        appendNegatedAccessConditions();
        appendLimit();
        appendOffset();

        return query.toString();
    }

    /**
     * - Append JOIN statements.
     */
    protected void joinKeywords() {
        if (((keywordList != null) && !keywordList.isEmpty())
                    || ((keywordGroupList != null) && !keywordGroupList.isEmpty())) {
            query.append(" INNER JOIN jt_resource_tag jtrt ON r.id = jtrt.resource_reference")
                    .append(" INNER JOIN tag kwt ON jtrt.tagid = kwt.id")
                    .append(" INNER JOIN taggroup kwt_tg ON kwt.taggroup = kwt_tg.id");

            this.appendKeywords();
            this.appendKeywordGroups();
        }
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinTopicCategory() {
        if (topicCategory != null) {
            query.append(" INNER JOIN tag tct ON r.topiccategory = tct.id");
            this.appendTopicCategory();
        }
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinCollection() {
        if (collection != null) {
            query.append(" INNER JOIN tag tc ON r.collection = tc.id");
        }

        this.appendCollection();
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinGeometry() {
        if (geometryToSearchFor != null) {
            // need to create a RIGHT join when keyword tags are joined in
            // probaby a problem with the query optimizer.
            if (((keywordList != null) && !keywordList.isEmpty())
                        || ((keywordGroupList != null) && !keywordGroupList.isEmpty())) {
                query.append(" RIGHT");
            } else {
                query.append(" INNER");
            }

            query.append(" JOIN geom g ON r.spatialcoverage = g.id ");

            this.appendGeometry();
        }
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinLocation() {
        if (location != null) {
            query.append(" INNER JOIN tag lct ON r.location = lct.id");

            this.appendLocation();
        }
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinAccessConditions() {
        if ((accessConditions != null) && !accessConditions.isEmpty()) {
            query.append(" INNER JOIN tag acs ON r.accessconditions = acs.id");

            this.appendAccessConditions();
        }
    }

    /**
     * DOCUMENT ME!
     */
    protected void joinFunctions() {
        if ((functionList != null) && !functionList.isEmpty()) {
            query.append(" INNER JOIN jt_resource_representation jtrr ON r.id = jtrr.resource_reference");
            query.append(" INNER JOIN representation rep ON jtrr.representationid = rep.id");
            query.append(" INNER JOIN tag rfc ON rep.function = rfc.id");

            this.appendFunctions();
        }
    }

    // - Append queryables and setter ------------------------------------------
    /**
     * DOCUMENT ME!
     */
    protected void appendGeometry() {
        if (geometryToSearchFor != null) {
            final String geostring = PostGisGeometryFactory.getPostGisCompliantDbString(geometryToSearchFor);
            query.append("AND g.geo_field && st_GeomFromEWKT('").append(geostring).append("')");

            if (((geoBuffer > 0) && (geometryToSearchFor instanceof Polygon))
                        || (geometryToSearchFor instanceof MultiPolygon)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("performing geospatial search with buffer of " + geoBuffer + "m.");
                }
                // with buffer for geostring
                query.append(" AND ")
                        .append(geometryFunction)
                        .append("(")
                        .append("st_transform( st_buffer( st_transform(st_GeomFromEWKT('")
                        .append(geostring)
                        .append("'),3857), ")
                        .append(String.valueOf(geoBuffer))
                        .append("), 4326), ")
                        .append("geo_field)");
            } else {
                // without buffer for geostring
                query.append(" AND ")
                        .append(geometryFunction)
                        .append("(")
                        .append("st_GeomFromEWKT('")
                        .append(geostring)
                        .append("')")
                        .append(", ")
                        .append("geo_field")
                        .append(")");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTemporal() {
        if (fromDate != null) {
            query.append(" AND r.fromDate >= '").append(fromDate.toString()).append("'");
            if (toDate != null) {
                query.append(" AND r.toDate < '").append(toDate.toString()).append("'::Timestamp + '1 day'::interval");
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
            query.append(" AND (to_tsvector('simple', kwt.name) @@ to_tsquery('simple', '");

            for (int i = 0; i < keywords.length; i++) {
                if (i > 0) {
                    query.append(" | ");
                }
                query.append("''").append(keywords[i]).append("''");
            }

            query.append("')");
            query.append(" AND to_tsvector('simple', kwt_tg.name) @@ to_tsquery('simple', '''keywords'':*'))");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendKeywordGroups() {
        if ((keywordGroupList != null) && !keywordGroupList.isEmpty()) {
            if ((keywordList != null) && !keywordList.isEmpty()) {
                query.append(" OR (to_tsvector('simple', kwt.name) @@ to_tsquery('simple', '");
            } else {
                query.append(" AND (to_tsvector('simple', kwt.name) @@ to_tsquery('simple', '");
            }

            String currentGroup = keywordGroupList.get(0)[0];
            int inGroupCount = 0;
            int groupCount = 0;

            for (String[] keywordGroupArray : keywordGroupList) {
                // check for new group
                if (!keywordGroupArray[0].equals(currentGroup)) {
                    groupCount++;
                    inGroupCount = 0;
                }
                // start of first or new group
                if (inGroupCount == 0) {
                    // start of new group: close previous group
                    if (groupCount > 0) {
                        currentGroup = keywordGroupArray[0];
                        query.append("')");
                        query.append(" AND to_tsvector('simple', kwt_tg.name) @@ to_tsquery('simple', '''keywords - ")
                                .append(currentGroup)
                                .append("'''))");
                        query.append(" AND (to_tsvector('simple', kwt.name) @@ to_tsquery('simple', '");
                    }
                } else {
                    query.append(" | ");
                }
                query.append("''").append(keywordGroupArray[1]).append("''");
                inGroupCount++;
            }

            // end of loop: close last group
            query.append("')");
            query.append(" AND to_tsvector('simple', kwt_tg.name) @@ to_tsquery('simple', '''keywords - ")
                    .append(currentGroup)
                    .append("'''))");
        }
    }

    /**
     * FAKE AND Statement for keywords. Filter by groups, e.g.
     */
    private void appendKeywordCombination() {
        int size = 0;
        size += (keywordList != null) ? keywordList.size() : 0;
        size += (keywordGroupList != null) ? keywordGroupList.size() : 0;

        if (size > 0) {
            query.append(" GROUP BY r.id HAVING COUNT(kwt.id) = ").append(size);
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTopicCategory() {
        if (topicCategory != null) {
            final StringBuilder topicCategoryParameter = new StringBuilder(topicCategory);
            query.append(" AND to_tsvector('simple', tct.name) @@ to_tsquery('simple', '");
            if (checkForNot(topicCategoryParameter)) {
                query.append("!");
            }
            query.append("''").append(topicCategoryParameter).append("''')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendCollection() {
        if (collection != null) {
            final StringBuilder parameter = new StringBuilder(collection);
            query.append(" AND to_tsvector('simple', tc.name) @@ to_tsquery('simple', '");
            if (checkForNot(parameter)) {
                query.append("!");
            }
            query.append("''").append(parameter).append("''')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTitleDescription() {
        if ((title == null) && (description == null)) {
            // LOG.warn("cannot append title or description: both are null!");
            return;
        }

        StringBuilder parameter;
        query.append(" AND to_tsvector('simple',");
        if ((title != null) && (description != null)) {
            query.append(" r.name || ' ' || r.description) @@ to_tsquery('simple', '");

            parameter = new StringBuilder(title);
            if (checkForNot(parameter)) {
                query.append("!");
            }

            query.append("''").append(parameter).append("''");
            if (title.equals(description)) {
                query.append("')");
            } else {
                query.append(" & ");
                parameter = new StringBuilder(description);
                if (checkForNot(parameter)) {
                    query.append("!");
                }
                query.append("''").append(parameter).append("''')");
            }
        } else if (title != null) {
            parameter = new StringBuilder(title);
            query.append(" r.name) @@ to_tsquery('simple', '");
            if (checkForNot(parameter)) {
                query.append("!");
            }
            query.append("''").append(parameter).append("''')");
        } else {
            parameter = new StringBuilder(description);
            query.append(" r.description) @@ to_tsquery('simple', '");
            if (checkForNot(parameter)) {
                query.append("!");
            }
            query.append("''").append(parameter).append("''')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendLocation() {
        if (location != null) {
            query.append(" AND to_tsvector('simple', lct.name) @@ to_tsquery('simple', '''")
                    .append(location)
                    .append("''')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendAccessConditions() {
        if ((accessConditions != null) && !accessConditions.isEmpty()) {
            String[] accessConditionsArray = new String[accessConditions.size()];
            accessConditionsArray = accessConditions.toArray(accessConditionsArray);
            query.append(" AND to_tsvector('simple', acs.name) @@ to_tsquery('simple', '");

            for (int i = 0; i < accessConditionsArray.length; i++) {
                if (i > 0) {
                    query.append(" | ");
                }
                query.append("''").append(accessConditionsArray[i]).append("''");
            }

            query.append("')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendNegatedAccessConditions() {
        if ((negatedAccessConditions != null) && !negatedAccessConditions.isEmpty()) {
            String[] negatedAccessConditionsArray = new String[negatedAccessConditions.size()];

            negatedAccessConditionsArray = negatedAccessConditions.toArray(negatedAccessConditionsArray);

            query.insert(0, "SELECT acs_resource.class_id, acs_resource.id, acs_resource.name FROM (");
            query.append(") AS acs_resource WHERE acs_resource.id NOT IN")
                    .append(" (SELECT acs_rr.id from resource acs_rr, tag acs_tag WHERE")
                    .append(" acs_tag.id = acs_rr.accessconditions AND (");

            for (int i = 0; i < negatedAccessConditionsArray.length; i++) {
                if (i > 0) {
                    query.append(" OR");
                }
                query.append(" to_tsvector('simple', acs_tag.name) @@ to_tsquery('simple', '''")
                        .append(negatedAccessConditionsArray[i])
                        .append("''')");
            }
            query.append("))");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendFunctions() {
        if ((functionList != null) && !functionList.isEmpty()) {
            String[] functions = new String[functionList.size()];
            functions = functionList.toArray(functions);
            query.append(" AND to_tsvector('simple', rfc.name) @@ to_tsquery('simple', '");

            for (int i = 0; i < functions.length; i++) {
                if (i > 0) {
                    query.append(" | ");
                }
                query.append("''").append(functions[i]).append("''");
            }

            query.append("')");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendNegatedFunctions() {
        if ((negatedFunctionList != null) && !negatedFunctionList.isEmpty()) {
            String[] negatedFunctions = new String[negatedFunctionList.size()];

            negatedFunctions = negatedFunctionList.toArray(negatedFunctions);

            query.insert(0, "SELECT fcs_resource.class_id, fcs_resource.id, fcs_resource.name FROM (");
            query.append(") AS fcs_resource WHERE fcs_resource.id NOT IN")
                    .append(" (SELECT fcs_rr.id from resource fcs_rr")
                    .append(
                            " INNER JOIN jt_resource_representation fcs_jtrr ON fcs_rr.id = fcs_jtrr.resource_reference")
                    .append(" INNER JOIN representation fcs_rep ON fcs_jtrr.representationid = fcs_rep.id")
                    .append(" INNER JOIN tag fcs_tag ON fcs_rep.function = fcs_tag.id AND (");

            for (int i = 0; i < negatedFunctions.length; i++) {
                if (i > 0) {
                    query.append(" OR");
                }
                query.append(" to_tsvector('simple', fcs_tag.name) @@ to_tsquery('simple', '''")
                        .append(negatedFunctions[i])
                        .append("''')");
            }
            query.append("))");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendOrderBy() {
        query.append(" ORDER BY r.name");
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
    private void appendOffset() {
        if (offset > 0) {
            if (limit > 0) {
                if ((offset % limit) == 0) {
                    query.append(" OFFSET ").append(offset);
                } else {
                    LOG.warn("offset '" + offset + "' does not match limit '" + limit + "'");
                }
            } else {
                LOG.warn("offset '" + offset + "' cannot be applied without limit");
            }
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
                    .append(" AND tag.id = jt_resource_tag.tagid AND (");

            for (int i = 0; i < negatedKeywords.length; i++) {
                if (i > 0) {
                    query.append(" OR");
                }
                query.append(" to_tsvector('simple', tag.name) @@ to_tsquery('simple', '''")
                        .append(negatedKeywords[i])
                        .append("''')");
            }
            query.append("))");
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
    public long getGeoBuffer() {
        return geoBuffer;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  geoBuffer  DOCUMENT ME!
     */
    public void setGeoBuffer(final long geoBuffer) {
        if ((geoBuffer > 0) && (geoBuffer < 10000000000L)) {
            this.geoBuffer = geoBuffer;
        } else {
            LOG.warn("invalid geo buffer: " + geoBuffer);
            this.geoBuffer = 0;
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

    /**
     * Get the value of collection.
     *
     * @return  the value of collection
     */
    public String getCollection() {
        return collection;
    }

    /**
     * Set the value of collection.
     *
     * @param  collection  new value of collection
     */
    public void setCollection(final String collection) {
        this.collection = collection;
    }

    /**
     * Get the value of offset.
     *
     * @return  the value of offset
     */
    public int getOffset() {
        return offset;
    }

    /**
     * Set the value of offset.
     *
     * @param  offset  new value of offset
     */
    public void setOffset(final int offset) {
        this.offset = offset;
    }

    /**
     * Get the value of accessConditions.
     *
     * @return  the value of accessConditions
     */
    public List<String> getAccessConditions() {
        return accessConditions;
    }

    /**
     * Set the value of accessConditions.
     *
     * @param  accessConditions  new value of accessConditions
     */
    public void setAccessConditions(final List<String> accessConditions) {
        this.accessConditions = accessConditions;
    }

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public List<String> getNegatedAccessConditions() {
        return negatedAccessConditions;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  negatedAccessConditions  DOCUMENT ME!
     */
    public void setNegatedAccessConditions(final List<String> negatedAccessConditions) {
        this.negatedAccessConditions = negatedAccessConditions;
    }

    /**
     * Get the value of functionList.
     *
     * @return  the value of functionList
     */
    public List<String> getFunctionList() {
        return functionList;
    }

    /**
     * Set the value of functionList.
     *
     * @param  functionList  new value of functionList
     */
    public void setFunctionList(final List<String> functionList) {
        this.functionList = functionList;
    }

    /**
     * Get the value of negatedFunctionList.
     *
     * @return  the value of negatedFunctionList
     */
    public List<String> getNegatedFunctionList() {
        return negatedFunctionList;
    }

    /**
     * Set the value of negatedFunctionList.
     *
     * @param  negatedFunctionList  new value of negatedFunctionList
     */
    public void setNegatedFunctionList(final List<String> negatedFunctionList) {
        this.negatedFunctionList = negatedFunctionList;
    }
}
