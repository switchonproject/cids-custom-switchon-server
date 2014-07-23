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
import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.MetaObjectNodeServerSearch;
import de.cismet.cids.server.search.SearchException;
import de.cismet.cismap.commons.jtsgeometryfactories.PostGisGeometryFactory;
import java.rmi.RemoteException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author FabHewer
 */
public class MetaObjectNodeResourceSearchStatement extends AbstractCidsServerSearch implements MetaObjectNodeServerSearch {

    //- Static Constants and Objects -------------------------------------------
    
    private static final Logger LOG = Logger.getLogger(MetaObjectNodeResourceSearchStatement.class);
    protected static final String DOMAIN = "SWITCH-ON";
    
    //- Constructors -----------------------------------------------------------

    /**
     * Creates a new MetaObjectNodeDokumenteSearchStatement object.
     *
     * @param  user  DOCUMENT ME!
     */
    public MetaObjectNodeResourceSearchStatement(final User user) {
        this.user = user;
    }
    
    //- Variables --------------------------------------------------------------
    
    protected StringBuilder query;
    protected User user; 
    
    
        //- Queriables -//
    protected Geometry geometryToSearchFor;
    
    protected List<String> keywordList;
    protected String topicCategory;
    protected String description;
    protected String title;
    protected Time fromDate;
    protected Time toDate;
    //- Methods ----------------------------------------------------------------

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
        query.append("SELECT DISTINCT " +   "(SELECT id "
                    +               "FROM    cs_class "
                    +               "WHERE   name ilike 'resource' "
                    +               "), r.id, r.name ");
        query.append(" FROM resource r");
        if (geometryToSearchFor != null) {
            query.append(" join geom g ON r.geometrie = g.id ");
        }
        if (keywordList != null && !keywordList.isEmpty()) {
            query.append(" join jt_resource_tag jtrt ON r.id = jtrt.resource_reference")
                 .append(" join tag kwt ON jtrt.tag_id = kwt.id")
                 .append(" join taggroup kwt_tg ON t.taggroup = kwt_tg.id");
        }
        if (topicCategory != null) {
            query.append(" join tag tct ON resource.topiccategory = tct.id");
        }
        query.append(" WHERE TRUE ");
        //TODO append der einzelnen suchanfragen [appendTitle() / appendKeywords() / etc]
        appendGeometry();
        appendDescription();
        appendKeywords();
        appendTempora();
        appendTitle();
        appendtopic();

        return query.toString();
    }
    
    //- Append queryables and setter -------------------------------------------
    
    protected void appendGeometry() {
        if (geometryToSearchFor != null) {
            final String geostring = PostGisGeometryFactory.getPostGisCompliantDbString(geometryToSearchFor);
            query.append("and g.geo_field && st_geometryfromtext('").append(geostring).append("')");

            if ((geometryToSearchFor instanceof Polygon) || (geometryToSearchFor instanceof MultiPolygon)) { // with buffer for geostring
                query.append(" and st_intersects(" + "st_buffer(geo_field, 0.000001),"
                                + "st_buffer(st_geometryfromtext('")
                        .append(geostring)
                        .append("'), 0.000001))");
            } else {                                                                                         // without buffer for geostring
                query.append(" and st_intersects(" + "st_buffer(geo_field, 0.000001)," + "st_geometryfromtext('")
                        .append(geostring)
                        .append("'))");
            }
        }
    }
    
    private void appendTempora() {
        if (fromDate != null) {
            query.append(" and fromDate = ").append(fromDate.toString());
            if (toDate != null) {
                query.append(" and toDate = ").append(toDate.toString());
            } else { // If the dataset is ongoing, then toDate is set to NULL.
                query.append(" and toDate IS NULL");
            }
        }
    }
    
    private void appendKeywords() {
        if (keywordList != null && !keywordList.isEmpty()) {
            String[] keywords = null;
            keywords = keywordList.toArray(keywords);
            query.append(" and ( kwt.name = ").append(keywords[0])
                 .append(" and kwt_tg.name like 'keywords%'");
            if (keywords.length > 1) {
                for( int i = 1; i < keywords.length; i++) {
                    query.append(" OR kwt.name = ").append(keywords[i])
                 .append(" and kwt_tg.name like 'keywords%'");
                }
            }
            query.append(")");
        }
    }
    
    private void appendtopic() {
        if (topicCategory != null) {
            query.append(" and tct.name = ").append(topicCategory);
        }
    }
    
    private void appendDescription() {
        if (description != null) {
            query.append(" and r.description like %")
                 .append(description).append("%");
        }
    }
    
    private void appendTitle() {
        if (title != null) {
            query.append(" and r.title like %")
                 .append(title).append("%");
        }
    }

    public void setGeometryToSearchFor(Geometry geometryToSearchFor) {
        this.geometryToSearchFor = geometryToSearchFor;
    }

    public void setKeywordList(List<String> keywordList) {
        this.keywordList = keywordList;
    }

    public void setTopicCategory(String topicCategory) {
        this.topicCategory = topicCategory;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setFromDate(Time fromDate) {
        this.fromDate = fromDate;
    }

    public void setToDate(Time toDate) {
        this.toDate = toDate;
    }

    
    
    
}
