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
package de.cismet.cids.custom.switchon.search;

import Sirius.server.middleware.interfaces.domainserver.MetaService;
import Sirius.server.middleware.types.MetaObjectNode;
import Sirius.server.newuser.User;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.geom.Polygon;

import org.apache.log4j.Logger;

import java.rmi.RemoteException;

import java.sql.Date;
import java.sql.Time;
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
        query.append("SELECT DISTINCT " + "(SELECT id "
                    + "FROM    cs_class "
                    + "WHERE   name ilike 'resource' "
                    + "), r.id, r.name ");
        query.append(" FROM resource r");
        if (geometryToSearchFor != null) {
            query.append(" join geom g ON r.spatialcoverage = g.id ");
        }
        if ((keywordList != null) && !keywordList.isEmpty()) {
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
        // TODO append der einzelnen suchanfragen [appendTitle() / appendKeywords() / etc]
        appendGeometry();
        appendKeywords();
        appendTempora();
        appendTitleDescription();
        appendtopic();
        appendLocation();

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

            if ((geometryToSearchFor instanceof Polygon) || (geometryToSearchFor instanceof MultiPolygon)) { // with buffer for geostring
                query.append(" and st_intersects(" + "st_buffer(geo_field, 0.000001),"
                                + "st_buffer(st_geometryfromtext('")
                        .append(geostring)
                        .append("'), 0.000001))");
            } else {                                                                                         // without buffer for
                // geostring
                query.append(" and st_intersects(" + "st_buffer(geo_field, 0.000001)," + "st_geometryfromtext('")
                        .append(geostring)
                        .append("'))");
            }
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTempora() {
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
            query.append(" and ( kwt.name ilike '").append(keywords[0]).append("' and kwt_tg.name like 'keywords%'");
            if (keywords.length > 1) {
                for (int i = 1; i < keywords.length; i++) {
                    query.append(" OR kwt.name ilike '")
                            .append(keywords[i])
                            .append("' and kwt_tg.name like 'keywords%'");
                }
            }
            query.append(")");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendtopic() {
        if (topicCategory != null) {
            query.append(" and tct.name ilike '").append(topicCategory).append("'");
        }
    }

    /**
     * DOCUMENT ME!
     */
    private void appendTitleDescription() {
        if ((title != null) && (description == null)) {
            query.append(" and r.name ilike '%").append(title).append("%'");
        } else if ((title != null) && (description != null)) {
            query.append(" and (r.name ilike '%").append(title).append("%'");
            query.append(" or r.description ilike '%").append(description).append("%')");
        } else if ((title == null) && (description != null)) {
            query.append(" and r.description ilike '%").append(description).append("%'");
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
}
