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
import Sirius.server.middleware.types.MetaClass;
import Sirius.server.middleware.types.MetaObjectNode;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.io.WKTReader;

import org.apache.log4j.Logger;

import org.openide.util.lookup.ServiceProvider;

import java.io.UnsupportedEncodingException;

import java.net.URLDecoder;

import java.sql.Timestamp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.CidsServerSearch;
import de.cismet.cids.server.search.MetaObjectNodeServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Finds resources that meets criteria defined by the query-attribute.
 *
 * @author   jruiz
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = CidsServerSearch.class)
public class MetaObjectUniversalSearchStatement extends AbstractCidsServerSearch implements MetaObjectNodeServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectUniversalSearchStatement.class);

    private static final String DOMAIN = "SWITCHON";
    private static final int GEOM_SRID = 4326;

    private static final String REGEX_QUERY = "(!?[A-Za-z_\\-]+?):\"(.+?)\"\\s?";

    private static final String NOT_FILTER = "!";

    private static final String FILTER__CLASS = "class";
    private static final String FILTER__KEYWORD = "keyword";
    private static final String FILTER__TEXT = "text";
    private static final String FILTER__TOPIC = "topic";

    private static final String FILTER__TEMPORAL__FROMDATE = "fromdate";
    private static final String FILTER__TEMPORAL__TODATE = "todate";
    private static final String FILTER__SPATIAL__GEO = "geo";
    private static final String FILTER__SPATIAL__GEO_INTERSECTS = "geo-intersects";
    private static final String FILTER__SPATIAL__GEO_BUFFER = "geo-buffer";
    private static final String FILTER__COLLECTION = "collection";
    private static final String FILTER__FUNCTION = "function";
    private static final String FILTER__ACCESS_CONDITIONS = "access-condition";
    private static final String FILTER__OFFSET = "offset";
    private static final String FILTER__LIMIT = "limit";

    private static final String METACLASSNAME__RESOURCE = "resource";

    private static final DateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    //~ Instance fields --------------------------------------------------------

    protected StringBuilder sqlQuery;
    protected boolean objectFilled = true;

    protected String query;

    private MetaService metaService = null;

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
     * @param   query  The query that defines the criteria of the resources that have
     *
     * @throws  UnsupportedOperationException  if the query could not be decoded URLDecoder.decode(query, "UTF-8")
     */
    public void setQuery(final String query) {
        try {
            this.query = URLDecoder.decode(query, "UTF-8");
        } catch (final UnsupportedEncodingException ex) {
            throw new UnsupportedOperationException("query '" + query + "' couldn't be decoded", ex);
        }
    }

    /**
     * interprets the filter query and use the informations to create a MetaObjectNodeResourceSearchStatement and set
     * the found filter values.
     *
     * @param   query  the query to interpret
     *
     * @return  MetaObjectNodeResourceSearchStatement
     *
     * @throws  SearchException  DOCUMENT ME!
     */
    protected MetaObjectNodeResourceSearchStatement interpretQuery(final String query) throws SearchException {
        if (LOG.isDebugEnabled()) {
            LOG.debug("interpreting query: \n" + query);
        }

        if (this.metaService == null) {
            if (this.getActiveLocalServers().containsKey(DOMAIN)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("initializing MetaService");
                }
                this.metaService = (MetaService)getActiveLocalServers().get(DOMAIN);
            } else {
                final String msg = "no metaservice for domain '" + DOMAIN + "' found!";
                LOG.error(msg);
                throw new SearchException(msg);
            }
        }

        final boolean isValid = Pattern.compile("^(" + REGEX_QUERY + ")+$").matcher(query).find();

        if (isValid) {
            final MetaObjectNodeResourceSearchStatement nrs = new MetaObjectNodeResourceSearchStatement(this.getUser());
            nrs.setActiveLocalServers(this.getActiveLocalServers());

            final List<String> keywordList = new LinkedList<String>();
            final List<String[]> keywordGroupList = new LinkedList<String[]>();
            final List<String> negatedKeywordList = new LinkedList<String>();
            final List<MetaClass> classList = new LinkedList<MetaClass>();
            Date fromDate = null;
            Date toDate = null;
            Geometry geometryToSearchFor = null;
            boolean isGeoIntersectsEnabled = false;
            long geoBuffer = 0;
            String fulltext = null;
            String topic = null;
            int limit = -1;
            int offset = -1;
            String collection = null;
            String function = null;
            String accessConditions = null;

            // add resource class by default
            try {
                classList.add(metaService.getClassByTableName(getUser(), METACLASSNAME__RESOURCE));
            } catch (final Exception ex) {
                LOG.warn("metaclass \"" + METACLASSNAME__RESOURCE + "\" couldn't be loaded", ex);
            }

            // find all filters
            final Matcher matcher = Pattern.compile(REGEX_QUERY).matcher(query);
            while (matcher.find()) {
                String key = matcher.group(1).trim();
                String value = matcher.group(2);
                final boolean notFilter;

                if (key.startsWith(NOT_FILTER)) {
                    LOG.info("found a NOT filter for parameter '" + key + "'");
                    key = key.substring(1);
                    notFilter = true;
                } else {
                    notFilter = false;
                }

                switch (key) {
                    case FILTER__TEMPORAL__FROMDATE: {
                        try {
                            fromDate = DATE_FORMAT.parse(value.trim());
                        } catch (final ParseException ex) {
                            throw new SearchException("fromdate couldn't be parsed", ex);
                        }
                        break;
                    }
                    case FILTER__TEMPORAL__TODATE: {
                        try {
                            toDate = DATE_FORMAT.parse(value.trim());
                        } catch (final ParseException ex) {
                            throw new SearchException("toDate couldn't be parsed", ex);
                        }
                        break;
                    }
                    case FILTER__SPATIAL__GEO: {
                        try {
                            geometryToSearchFor = new WKTReader().read(value.trim());
                            geometryToSearchFor.setSRID(GEOM_SRID);
                        } catch (final com.vividsolutions.jts.io.ParseException ex) {
                            throw new SearchException("geometry couldn't be parsed", ex);
                        }
                        break;
                    }
                    case FILTER__SPATIAL__GEO_INTERSECTS: {
                        isGeoIntersectsEnabled = value.trim().toLowerCase().equals("true");
                        break;
                    }
                    case FILTER__SPATIAL__GEO_BUFFER: {
                        try {
                            final long geoBufferTemp = Long.parseLong(value);
                            if (geoBufferTemp > 0) {
                                geoBuffer = geoBufferTemp;
                            }
                        } catch (NumberFormatException numberFormatException) {
                            LOG.warn("could not parse: " + key + " = " + value + " to long", numberFormatException);
                        }
                        break;
                    }
                    case FILTER__CLASS: {
                        try {
                            classList.add(metaService.getClassByTableName(getUser(), value.trim()));
                        } catch (final Exception ex) {
                            throw new SearchException("metaclass \"" + value.trim() + "\" couldn't be loaded", ex);
                        }
                        break;
                    }
                    case FILTER__KEYWORD: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            negatedKeywordList.add(value);
                        } else {
                            keywordList.add(value);
                        }

                        break;
                    }
                    case FILTER__TEXT: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            value = "!" + value;
                        }

                        fulltext = value;
                        break;
                    }
                    case FILTER__TOPIC: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            value = "!" + value;
                        }

                        topic = value;
                        break;
                    }
                    case FILTER__LIMIT: {
                        try {
                            final int limitTemp = Integer.parseInt(value);
                            if (limitTemp > 0) {
                                limit = limitTemp;
                            }
                        } catch (NumberFormatException numberFormatException) {
                            LOG.warn("could not parse: " + key + " = " + value + " to integer", numberFormatException);
                        }
                        break;
                    }
                    case FILTER__OFFSET: {
                        try {
                            final int offsetTemp = Integer.parseInt(value);
                            if (offsetTemp > 0) {
                                offset = offsetTemp;
                            }
                        } catch (NumberFormatException numberFormatException) {
                            LOG.warn("could not parse: " + key + " = " + value + " to integer", numberFormatException);
                        }
                        break;
                    }
                    case FILTER__COLLECTION: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            value = "!" + value;
                        }

                        collection = value;
                        break;
                    }
                    case FILTER__FUNCTION: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            value = "!" + value;
                        }

                        function = value;
                        break;
                    }
                    case FILTER__ACCESS_CONDITIONS: {
                        if (notFilter) {
                            if (LOG.isDebugEnabled()) {
                                LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                            }
                            value = "!" + value;
                        }

                        accessConditions = value;
                        break;
                    }
                    default: {
                        if ((key.length() > 8) && key.startsWith("keyword-", 0)) {
                            if (notFilter) {
                                if (LOG.isDebugEnabled()) {
                                    LOG.debug("applying not filter to '" + key + ": '" + value + "'");
                                }
                                negatedKeywordList.add(value);
                            } else {
                                final String[] keywordGroup = new String[] { key.substring(8), value };
                                if (LOG.isDebugEnabled()) {
                                    LOG.debug("keywordGroup '" + keywordGroup[0] + "' found in: " + key + " = "
                                                + value);
                                }
                                keywordGroupList.add(keywordGroup);
                            }
                        } else {
                            LOG.warn("ignoring unknown key: " + key + " = " + value);
                        }
                    }
                }
            }

            // set all found filters to the nrs-search
            if (!classList.isEmpty()) {
                // not yet defined what to do with other classes then resource
            }

            if (!keywordList.isEmpty()) {
                nrs.setKeywordList(keywordList);
                if (LOG.isDebugEnabled()) {
                    for (final String keyword : keywordList) {
                        if (LOG.isDebugEnabled()) {
                            LOG.debug("keyword \"" + keyword + "\" added");
                        }
                    }
                }
            }

            if (!negatedKeywordList.isEmpty()) {
                nrs.setNegatedKeywordList(negatedKeywordList);
                if (LOG.isDebugEnabled()) {
                    for (final String keyword : negatedKeywordList) {
                        if (LOG.isDebugEnabled()) {
                            LOG.debug("negated keyword \"" + keyword + "\" added");
                        }
                    }
                }
            }

            if (!keywordGroupList.isEmpty()) {
                nrs.setKeywordGroupList(keywordGroupList);
                if (LOG.isDebugEnabled()) {
                    for (final String[] keywordGroup : keywordGroupList) {
                        if (LOG.isDebugEnabled()) {
                            LOG.debug("keyword \"" + keywordGroup[1] + "\" of group \"" + keywordGroup[0] + "\" added");
                        }
                    }
                }
            }

            if (fromDate != null) {
                nrs.setFromDate(new Timestamp(fromDate.getTime()));
                if (LOG.isDebugEnabled()) {
                    LOG.debug("fromDate set to: \"" + fromDate + "\"");
                }
            }
            if (toDate != null) {
                nrs.setToDate(new Timestamp(toDate.getTime()));
                if (LOG.isDebugEnabled()) {
                    LOG.debug("toDate set to: \"" + toDate + "\"");
                }
            }
            if (geometryToSearchFor != null) {
                nrs.setGeometryToSearchFor(geometryToSearchFor);
                if (LOG.isDebugEnabled()) {
                    LOG.debug("geometryToSearchFor set to: \"" + geometryToSearchFor.toText() + "\"");
                }
            }
            if (isGeoIntersectsEnabled) {
                nrs.setGeometryFunction(MetaObjectNodeResourceSearchStatement.GeometryFunction.INTERSECT);
                if (LOG.isDebugEnabled()) {
                    LOG.debug("geometryFunction set to: \""
                                + MetaObjectNodeResourceSearchStatement.GeometryFunction.INTERSECT.toString() + "\"");
                }
            } else {
                nrs.setGeometryFunction(MetaObjectNodeResourceSearchStatement.GeometryFunction.CONTAINS);
                if (LOG.isDebugEnabled()) {
                    LOG.debug("geometryFunction set to: \""
                                + MetaObjectNodeResourceSearchStatement.GeometryFunction.CONTAINS.toString() + "\"");
                }
            }
            if (geoBuffer > 0) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("searching with geo buffer: \"" + geoBuffer + "\"");
                }
                nrs.setGeoBuffer(geoBuffer);
            }
            if (fulltext != null) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("fulltext search in title and description for: \"" + fulltext + "\"");
                }
                nrs.setTitle(fulltext);
                nrs.setDescription(fulltext);
            }
            if ((topic != null) && (topic.length() > 0)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("INSIRE topic category search for: \"" + topic + "\"");
                }
                nrs.setTopicCategory(topic);
            }
            if (limit > 0) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("LIMIT: \"" + limit + "\"");
                }
                nrs.setLimit(limit);
            }
            if ((collection != null) && (collection.length() > 0)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("COLLECTION: \"" + collection + "\"");
                }
                nrs.setCollection(collection);
            }
            if ((function != null) && (function.length() > 0)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("FUNCTION: \"" + function + "\"");
                }
                nrs.setFunction(function);
            }
            if ((accessConditions != null) && (accessConditions.length() > 0)) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("ACCESS_CONDITIONS: \"" + accessConditions + "\"");
                }
                nrs.setAccessConditions(accessConditions);
            }
            if (offset > 0) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("OFFSET: \"" + offset + "\"");
                }
                nrs.setOffset(offset);
            }

            return nrs;
        } else {
            LOG.error("invalid query: " + query);
            throw new SearchException("invalid query: " + query);
        }
    }

    @Override
    public Collection<MetaObjectNode> performServerSearch() throws SearchException {
        final MetaObjectNodeResourceSearchStatement nrs = interpretQuery(this.query);
        return nrs.performServerSearch();
    }
}
