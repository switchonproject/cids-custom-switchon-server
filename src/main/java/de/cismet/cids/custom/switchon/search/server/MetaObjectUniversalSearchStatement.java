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

import java.io.UnsupportedEncodingException;

import java.net.URLDecoder;

import java.rmi.RemoteException;

import java.sql.Timestamp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
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
@org.openide.util.lookup.ServiceProvider(service = CidsServerSearch.class)
public class MetaObjectUniversalSearchStatement extends AbstractCidsServerSearch implements MetaObjectNodeServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(MetaObjectUniversalSearchStatement.class);

    private static final String DOMAIN = "SWITCHON";
    private static final int GEOM_SRID = 4326;

    private static final String REGEX_QUERY = "(\\w+?):\"(.+?)\"\\s?";

    private static final String FILTER__CLASS = "class";
    private static final String FILTER__KEYWORD = "keyword";
    private static final String FILTER__TEXT = "text";

    private static final String FILTER__TEMPORAL__FROMDATE = "fromdate";
    private static final String FILTER__TEMPORAL__TODATE = "todate";
    private static final String FILTER__SPATIAL__GEO = "geo";
    private static final String FILTER__SPATIAL__GEO_INTERSECTS = "geo_intersects";

    private static final String METACLASSNAME__RESOURCE = "resource";

    private static final DateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    //~ Instance fields --------------------------------------------------------

    protected StringBuilder sqlQuery;
    protected boolean objectFilled = true;

    protected String query;

    private MetaService ms;

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
            throw new UnsupportedOperationException("query couldn't be decoded", ex);
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
    private MetaObjectNodeResourceSearchStatement interpretQuery(final String query) throws SearchException {
        final boolean isValid = Pattern.compile("^(" + REGEX_QUERY + ")+$").matcher(query).find();

        if (isValid) {
            final MetaObjectNodeResourceSearchStatement nrs = new MetaObjectNodeResourceSearchStatement(getUser());
            nrs.setUser(getUser());
            nrs.setActiveLocalServers(getActiveLocalServers());

            final List<String> keywordList = new ArrayList<String>();
            final List<MetaClass> classList = new ArrayList<MetaClass>();
            Date fromDate = null;
            Date toDate = null;
            Geometry geometryToSearchFor = null;
            boolean isGeoIntersectsEnabled = false;
            String fulltext = null;

            // add resource class by default
            try {
                classList.add(ms.getClassByTableName(getUser(), METACLASSNAME__RESOURCE));
            } catch (final RemoteException ex) {
                LOG.warn("metaclass \"" + METACLASSNAME__RESOURCE + "\" couldn't be loaded", ex);
            }

            // find all filters
            final Matcher matcher = Pattern.compile(REGEX_QUERY).matcher(query);
            while (matcher.find()) {
                final String key = matcher.group(1).trim();
                final String value = matcher.group(2);

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
                    case FILTER__CLASS: {
                        try {
                            classList.add(ms.getClassByTableName(getUser(), value.trim()));
                        } catch (final RemoteException ex) {
                            throw new SearchException("metaclass \"" + value.trim() + "\" couldn't be loaded", ex);
                        }
                        break;
                    }
                    case FILTER__KEYWORD: {
                        keywordList.add(value);
                        break;
                    }
                    case FILTER__TEXT: {
                        fulltext = value;
                        break;
                    }
                    default: {
                        LOG.warn("unknown key: " + key + " = " + value);
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
            if (fulltext != null) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("fulltext search in title and description for: \"" + fulltext + "\"");
                }
                nrs.setTitle(fulltext);
                nrs.setDescription(fulltext);
            }
            return nrs;
        } else {
            throw new SearchException("invalid query");
        }
    }

    @Override
    public Collection<MetaObjectNode> performServerSearch() throws SearchException {
        if ((ms = (MetaService)getActiveLocalServers().get(DOMAIN)) != null) {
            final MetaObjectNodeResourceSearchStatement nrs = interpretQuery(this.query);
            return nrs.performServerSearch();
        } else {
            LOG.error("active local server not found"); // NOI18N
            return null;
        }
    }
}
