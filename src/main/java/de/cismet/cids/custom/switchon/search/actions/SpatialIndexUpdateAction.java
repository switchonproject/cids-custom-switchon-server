/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.actions;

import org.apache.log4j.Logger;

import de.cismet.cids.server.actions.ServerAction;
import de.cismet.cids.server.actions.ServerActionParameter;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
@org.openide.util.lookup.ServiceProvider(service = ServerAction.class)
public class SpatialIndexUpdateAction implements ServerAction {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOGGER = Logger.getLogger(SpatialIndexUpdateAction.class);

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SpatialIndexUpdateAction.
     */
    public SpatialIndexUpdateAction() {
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Object execute(final Object body, final ServerActionParameter... params) {
        if (params.length > 0) {
        } else {
            final String message = "Action '" + this.getTaskName() + "' called without parameters!";
            LOGGER.error(message);
            throw new RuntimeException(message);
        }

        try {
            return null;
        } catch (Exception ex) {
            LOGGER.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        }
    }

    @Override
    public String getTaskName() {
        return "spatialIndexUpdateAction";
    }
}
