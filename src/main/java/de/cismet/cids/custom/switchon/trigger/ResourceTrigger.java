/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.trigger;

import Sirius.server.middleware.types.MetaObject;
import Sirius.server.newuser.User;

import org.openide.util.lookup.ServiceProvider;

import java.util.ArrayList;
import java.util.List;

import de.cismet.cids.dynamics.CidsBean;

import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;

/**
 * DOCUMENT ME!
 *
 * @author   Gilles Baatz
 * @version  $Revision$, $Date$
 */
@ServiceProvider(service = CidsTrigger.class)
public class ResourceTrigger extends AbstractDBAwareCidsTrigger {

    //~ Static fields/initializers ---------------------------------------------

    private static final org.apache.log4j.Logger LOG = org.apache.log4j.Logger.getLogger(ResourceTrigger.class);

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @param  cidsBean  DOCUMENT ME!
     */
    private void makeAdditionalRepresentationAndUploadToGeoServer(final CidsBean cidsBean) {
        final List<CidsBean> representations = cidsBean.getBeanCollectionProperty("representation");
        for (final CidsBean representation : representations) {
            final int status = representation.getMetaObject().getStatus();
            if ((status == MetaObject.NEW) || (status == MetaObject.MODIFIED)) {
                final String url = uploadToGeoServer(representation);
                final CidsBean newRepresentation = createRepresentation(representation, url);
                representations.add(newRepresentation);
            }
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   representation  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private String uploadToGeoServer(final CidsBean representation) {
        LOG.fatal("ResourceTrigger.uploadToGeoServer: Not supported yet.", new Exception()); // NOI18N
        return null;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   representation  DOCUMENT ME!
     * @param   url             DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private CidsBean createRepresentation(final CidsBean representation, final String url) {
        LOG.fatal("ResourceTrigger.createRepresentation: Not supported yet.", new Exception()); // NOI18N
        return null;
    }

    @Override
    public void beforeInsert(final CidsBean cidsBean, final User user) {
        makeAdditionalRepresentationAndUploadToGeoServer(cidsBean);
    }

    @Override
    public void afterInsert(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void beforeUpdate(final CidsBean cidsBean, final User user) {
        makeAdditionalRepresentationAndUploadToGeoServer(cidsBean);
    }

    @Override
    public void afterUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void beforeDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedInsert(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedUpdate(final CidsBean cidsBean, final User user) {
    }

    @Override
    public void afterCommittedDelete(final CidsBean cidsBean, final User user) {
    }

    @Override
    public CidsTriggerKey getTriggerKey() {
        return new CidsTriggerKey("SWITCHON", "RESOURCE");
    }

    /**
     * DOCUMENT ME!
     *
     * @param   o  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    @Override
    public int compareTo(final CidsTrigger o) {
        return -1;
    }

    /**
     * Iterates through a list of tags and returns the tags whose taggroup equals the taggroup in the parameter.
     *
     * @param   tags      DOCUMENT ME!
     * @param   taggroup  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public static List<CidsBean> returnAllOccurrencesOfTaggroup(final List<CidsBean> tags, final String taggroup) {
        final List<CidsBean> tagsToReturn = new ArrayList<CidsBean>();
        for (final CidsBean tag : tags) {
            final CidsBean taggroupBean = (CidsBean)tag.getProperty("taggroup");
            final String taggroupName = (String)taggroupBean.getProperty("name");
            if (taggroupName.equals(taggroup)) {
                tagsToReturn.add(tag);
            }
        }
        return tagsToReturn;
    }
}
