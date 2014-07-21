/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package de.cismet.cids.custom.switchon.search;

import Sirius.server.middleware.types.MetaObjectNode;
import de.cismet.cids.server.search.AbstractCidsServerSearch;
import de.cismet.cids.server.search.MetaObjectNodeServerSearch;
import de.cismet.cids.server.search.SearchException;
import java.util.Collection;

/**
 *
 * @author FabHewer
 */
public class MetaObjectNodeResourceSearchStatement extends AbstractCidsServerSearch implements MetaObjectNodeServerSearch {

    @Override
    public Collection<MetaObjectNode> performServerSearch() throws SearchException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
