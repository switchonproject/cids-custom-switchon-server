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
import java.util.Map.Entry;

import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.CidsServerSearch;
import de.cismet.cids.server.search.SearchException;

/**
 * Simple search for [classid, className] entries. The result is indeed a <code>Collection</code> of <code>
 * Entry&lt;Integer, String&gt;</code>.
 *
 * @author   martin.scholl@cismet.de
 * @version  1.0
 */
@ServiceProvider(service = CidsServerSearch.class)
public final class ClassNameSearch extends AbstractCidsServerSearch {

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
}
