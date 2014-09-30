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

import it.geosolutions.geoserver.rest.GeoServerRESTPublisher;
import it.geosolutions.geoserver.rest.GeoServerRESTReader;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import org.openide.util.lookup.ServiceProvider;

import java.io.File;
import java.io.UnsupportedEncodingException;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import java.util.ArrayList;
import java.util.List;

import de.cismet.cids.dynamics.CidsBean;

import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;

import de.cismet.tools.PasswordEncrypter;
import de.cismet.tools.PropertyReader;

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

    private static final PropertyReader propertyReader;

    private static final String FILE_PROPERTY = "/de/cismet/cids/custom/switchon/trigger/geoserver.properties";

    private static final String GEOSERVER_REST_URL;
    private static final String GEOSERVER_REST_USER;
    private static final String GEOSERVER_REST_PASSWORD;

    static {
        propertyReader = new PropertyReader(FILE_PROPERTY);
        GEOSERVER_REST_URL = propertyReader.getProperty("GEOSERVER_REST_URL");           // NOI18N
        GEOSERVER_REST_USER = propertyReader.getProperty("GEOSERVER_REST_USER");         // NOI18N
        GEOSERVER_REST_PASSWORD = String.valueOf(PasswordEncrypter.decrypt(
                    propertyReader.getProperty("GEOSERVER_REST_PASSWORD").toCharArray(), // NOI18N
                    false));
    }

    //~ Instance fields --------------------------------------------------------

    private GeoServerRESTReader geoServerRESTReader;
    private final GeoServerRESTPublisher geoServerRESTPublisher;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new ResourceTrigger object.
     */
    public ResourceTrigger() {
        try {
            geoServerRESTReader = new GeoServerRESTReader(
                    GEOSERVER_REST_URL,
                    GEOSERVER_REST_USER,
                    GEOSERVER_REST_PASSWORD);
        } catch (MalformedURLException ex) {
            LOG.error(ex, ex);
        }
        geoServerRESTPublisher = new GeoServerRESTPublisher(
                GEOSERVER_REST_URL,
                GEOSERVER_REST_USER,
                GEOSERVER_REST_PASSWORD);
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @param  resource  DOCUMENT ME!
     */
    private void makeAdditionalRepresentationAndUploadToGeoServer(final CidsBean resource) {
        final String workspace = checkIfWorkspaceExists(resource);
        final List<CidsBean> representations = resource.getBeanCollectionProperty("representation");
        final List<CidsBean> newRepresentations = new ArrayList<CidsBean>();
        for (final CidsBean representation : representations) {
            final int status = representation.getMetaObject().getStatus();
            if ((status == MetaObject.NEW) || (status == MetaObject.MODIFIED)) {
                final List<CidsBean> tags = representation.getBeanCollectionProperty("tags");
                final List<CidsBean> publishStyles = returnAllOccurrencesOfTaggroup(tags, "publish type");

                for (final CidsBean publishStyleTag : publishStyles) {
                    if (publishStyleTag.getProperty("name").equals("geotiff")) {
                        try {
                            final String url = uploadToGeoServer(workspace, representation);
                            final CidsBean newRepresentation = createRepresentation(representation, url);
                            newRepresentations.add(newRepresentation);
                        } catch (MalformedURLException ex) {
                            LOG.error(ex, ex);
                        } catch (Exception ex) {
                            LOG.error(ex, ex);
                        }
                    }
                }
            }
        }
        representations.addAll(newRepresentations);
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workspace       DOCUMENT ME!
     * @param   representation  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  MalformedURLException  DOCUMENT ME!
     * @throws  Exception              DOCUMENT ME!
     */
    private String uploadToGeoServer(final String workspace, final CidsBean representation)
            throws MalformedURLException, Exception {
        if (!geoServerRESTReader.existGeoserver()) {
            final String message = "The URL '" + GEOSERVER_REST_URL + "' doesn't point to a GeoServer."; // NOI18N
            LOG.error(message);
            throw new Exception(message);
        }

        final String contentLocation = (String)representation.getProperty("contentlocation");
        final String prefix = FilenameUtils.getBaseName(contentLocation);
        final String suffix = FilenameUtils.getExtension(contentLocation);
        final File temp = File.createTempFile(prefix, suffix);
        FileUtils.copyURLToFile(new URL(contentLocation), temp);
        geoServerRESTPublisher.publishGeoTIFF(workspace, workspace + "-geotiff", temp);

        return "";
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

    /**
     * DOCUMENT ME!
     *
     * @param   resource  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private String checkIfWorkspaceExists(final CidsBean resource) {
        final String resourceName = urlEncode((String)resource.getProperty("name"), "_");
        if (!geoServerRESTReader.getWorkspaceNames().contains("resourceName")) {
            geoServerRESTPublisher.createWorkspace(resourceName);
        }
        return resourceName;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   string  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private String urlEncode(final String string) {
        return urlEncode(string, "%20");
    }

    /**
     * Encodes a URL with the class URLEncoder and the encoding UTF-8. If the encoding is not supported a standard
     * encoding will be used.
     *
     * @param   string             DOCUMENT ME!
     * @param   replaceWhiteSpace  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    private String urlEncode(String string, final String replaceWhiteSpace) {
        try {
            string = URLEncoder.encode(string, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            LOG.error("The encoding UTF-8 is not supported, use standard encoding instead.", ex);
            string = URLEncoder.encode(string);
        }
        return string.replace("+", replaceWhiteSpace);
    }
}
