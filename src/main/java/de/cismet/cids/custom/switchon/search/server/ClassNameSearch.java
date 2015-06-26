/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.server;

import Sirius.server.middleware.interfaces.domainserver.MetaService;

import org.openide.util.lookup.ServiceProvider;

import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;

import de.cismet.cids.base.types.Type;

import de.cismet.cids.server.api.types.SearchInfo;
import de.cismet.cids.server.api.types.SearchParameterInfo;
import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.RestApiCidsServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Simple search for [classid, className] entries. The result is indeed a <code>Collection</code> of <code>
 * Entry&lt;Integer, String&gt;</code>.
 *
 * @author   martin.scholl@cismet.de
 * @version  1.0
 */
@ServiceProvider(service = RestApiCidsServerSearch.class)
public final class ClassNameSearch extends AbstractCidsServerSearch implements RestApiCidsServerSearch {

    //~ Static fields/initializers ---------------------------------------------

    public static final SearchInfo SEARCH_INFO;

    static {
        SEARCH_INFO = new SearchInfo();
        SEARCH_INFO.setKey(ClassNameSearch.class.getName());
        SEARCH_INFO.setName(ClassNameSearch.class.getSimpleName());
        SEARCH_INFO.setDescription(
            "Class Name Search Search for SWITCH-ON pure REST clients");

        final List<SearchParameterInfo> parameterDescription = new LinkedList<SearchParameterInfo>();
        final SearchParameterInfo searchParameterInfo;

        searchParameterInfo = new SearchParameterInfo();
        searchParameterInfo.setKey("domain");
        searchParameterInfo.setType(Type.STRING);
        parameterDescription.add(searchParameterInfo);

        SEARCH_INFO.setParameterDescription(parameterDescription);

        final SearchParameterInfo resultParameterInfo = new SearchParameterInfo();
        resultParameterInfo.setKey("return");
        resultParameterInfo.setDescription("<Entry<Integer, String>> Collection");
        resultParameterInfo.setArray(true);
        resultParameterInfo.setType(Type.JAVA_CLASS);
        resultParameterInfo.setAdditionalTypeInfo("com.fasterxml.jackson.databind.node.ObjectNode");
        SEARCH_INFO.setResultDescription(resultParameterInfo);
    }

    //~ Instance fields --------------------------------------------------------

    protected String domain;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new ClassNameSearch object. The default domain is 'LOCAL'.
     */
    public ClassNameSearch() {
        domain = "LOCAL";
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Collection performServerSearch() throws SearchException {
        final MetaService ms = (MetaService)getActiveLocalServers().get(getDomain());
        if (ms == null) {
            throw new SearchException("no metaservice");                                                        // NOI18N
        } else {
            try {
                final ArrayList<ArrayList> resultset = ms.performCustomSearch("SELECT id, name FROM cs_class"); // NOI18N
                final ArrayList<Entry<Integer, String>> result = new ArrayList<Entry<Integer, String>>();

                for (final ArrayList row : resultset) {
                    final int cId = (Integer)row.get(0);
                    final String cName = (String)row.get(1);

                    final Entry<Integer, String> e = new SimpleEntry<Integer, String>(cId, cName);

                    result.add(e);
                }

                return result;
            } catch (final Exception ex) {
                throw new SearchException("cannot search for classid, classname", ex); // NOI18N
            }
        }
    }

    /**
     * Get the current search domain.
     *
     * @return  the search domain
     */
    public String getDomain() {
        return domain;
    }

    /**
     * Set the current search domain. If the domain is <code>null</code> nothing will be done.
     *
     * @param  domain  the new search domain
     */
    public void setDomain(final String domain) {
        if (domain != null) {
            this.domain = domain;
        }
    }

    @Override
    public SearchInfo getSearchInfo() {
        return SEARCH_INFO;
    }
}
