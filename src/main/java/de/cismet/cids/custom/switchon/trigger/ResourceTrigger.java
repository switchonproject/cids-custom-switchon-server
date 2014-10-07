/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.trigger;

import Sirius.server.middleware.types.LightweightMetaObject;
import Sirius.server.middleware.types.MetaClass;
import Sirius.server.middleware.types.MetaObject;
import Sirius.server.newuser.User;

import it.geosolutions.geoserver.rest.GeoServerRESTPublisher;
import it.geosolutions.geoserver.rest.GeoServerRESTReader;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import org.deegree.io.geotiff.GeoTiffReader;

import org.openide.util.lookup.ServiceProvider;

import java.io.File;
import java.io.UnsupportedEncodingException;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import de.cismet.cids.dynamics.CidsBean;

import de.cismet.cids.trigger.AbstractDBAwareCidsTrigger;
import de.cismet.cids.trigger.CidsTrigger;
import de.cismet.cids.trigger.CidsTriggerKey;

import de.cismet.commons.concurrency.CismetExecutors;

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

    public static final String UPDATE_UPLOADSTATUS = "UPDATE representation"
                + " SET uploadstatus = ? "
                + " WHERE uuid = ? ";

    //~ Instance fields --------------------------------------------------------

    public ExecutorService singleThreadExecutor = CismetExecutors.newSingleThreadExecutor();
    private User user;

    private GeoServerRESTReader geoServerRESTReader;
    private final GeoServerRESTPublisher geoServerRESTPublisher;

    private ArrayList<UploadToGeoServerInformation> uploadToGeoServerInformation =
        new ArrayList<UploadToGeoServerInformation>();

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
                    final String publishStyle = (String)publishStyleTag.getProperty("name");
                    if ("geotiff".equals(publishStyle) || "shapefile".equals(publishStyle)) {
                        try {
                            final String url = GEOSERVER_REST_URL
                                        + "/wms?service=wms&version=1.1.1&request=GetCapabilities&namespace="
                                        + workspace;
                            final CidsBean layerRepresentation = createLayerRepresentation(representation, url);
                            newRepresentations.add(layerRepresentation);
                            uploadToGeoServerInformation.add(new UploadToGeoServerInformation(
                                    publishStyleTag,
                                    workspace,
                                    representation,
                                    layerRepresentation));
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
     * @param  publishStyle         DOCUMENT ME!
     * @param  workspace            DOCUMENT ME!
     * @param  representation       DOCUMENT ME!
     * @param  layerRepresentation  DOCUMENT ME!
     */
    private void uploadToGeoServerWorker(final CidsBean publishStyle,
            final String workspace,
            final CidsBean representation,
            final CidsBean layerRepresentation) {
        singleThreadExecutor.submit(new Runnable() {

                @Override
                public void run() {
                    CidsBean uploadStatusTag = null;
                    try {
                        uploadToGeoServer(publishStyle, workspace, representation);
                        uploadStatusTag = fetchTagByName("finished");
                    } catch (Exception ex) {
                        try {
                            uploadStatusTag = fetchTagByName("failed");
                        } catch (Exception ex1) {
                            LOG.error(ex1, ex1);
                        }
                    } finally {
                        try {
                            updateLayerRepresentation((String)layerRepresentation.getProperty("uuid"), uploadStatusTag);
                        } catch (Exception ex) {
                            LOG.error(ex, ex);
                        }
                    }
                }

                private void updateLayerRepresentation(final String uuid, final CidsBean uploadStatusTag) {
                    PreparedStatement s = null;
                    try {
                        s = getDbServer().getActiveDBConnection().getConnection().prepareStatement(UPDATE_UPLOADSTATUS);

                        s.setInt(1, uploadStatusTag.getPrimaryKeyValue());

                        s.setString(2, uuid);

                        s.executeUpdate();
                    } catch (SQLException ex) {
                        if (s != null) {
                            LOG.error(
                                "Error while updating the Representation "
                                        + uuid
                                        + ". Query: "
                                        + s.toString(),
                                ex);
                        } else {
                            LOG.error("Error while updating the Representation " + uuid, ex);
                        }
                    }
                }
            });
    }

    /**
     * DOCUMENT ME!
     *
     * @param   publishStyle    DOCUMENT ME!
     * @param   workspace       DOCUMENT ME!
     * @param   representation  DOCUMENT ME!
     *
     * @throws  MalformedURLException  DOCUMENT ME!
     * @throws  Exception              DOCUMENT ME!
     */
    private void uploadToGeoServer(final CidsBean publishStyle, final String workspace, final CidsBean representation)
            throws MalformedURLException, Exception {
        if (!geoServerRESTReader.existGeoserver()) {
            final String message = "The URL '" + GEOSERVER_REST_URL + "' doesn't point to a GeoServer."; // NOI18N
            LOG.error(message);
            throw new Exception(message);
        }

        final String contentLocation = (String)representation.getProperty("contentlocation");
        final String prefix = FilenameUtils.getBaseName(contentLocation);
        final String suffix = FilenameUtils.getExtension(contentLocation);
        final File fileToUpload = File.createTempFile(prefix, suffix);
        FileUtils.copyURLToFile(new URL(contentLocation), fileToUpload);

        String layername = (String)representation.getProperty("name");
        if ((layername == null) || layername.trim().equals("")) {
            layername = prefix;
        }

        switch ((String)publishStyle.getProperty("name")) {
            case "geotiff": {
                uploadGeoTiff(workspace, fileToUpload, layername);
                break;
            }
            case "shapefile": {
                uploadShapeFile(workspace, fileToUpload);
                break;
            }
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workspace  DOCUMENT ME!
     * @param   geoTiff    DOCUMENT ME!
     * @param   layername  DOCUMENT ME!
     *
     * @throws  Exception  DOCUMENT ME!
     */
    private void uploadGeoTiff(final String workspace,
            final File geoTiff,
            final String layername) throws Exception {
        // check if file is a GeoTiff, throws an exception otherwise
        final GeoTiffReader tiffReader = new GeoTiffReader(geoTiff);
        // check if the used coordinate system is of the type (1) ModelTypeProjected (Projection Coordinate System) or
        // (2) ModelTypeGeographic (Geographic latitude-longitude System)
        final int modeltype = tiffReader.getGTModelTypeGeoKey();
        if ((modeltype != 1) && (modeltype != 2)) {
            throw new Exception(
                "GeoTiff invalid, the used coordinate system must be of the type projection or geographic.");
        }

        if (!geoServerRESTPublisher.publishGeoTIFF(workspace, workspace + "-geotiff", layername, geoTiff)) {
            throw new Exception("An error occured while uploading the GeoTiff.");
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workspace  DOCUMENT ME!
     * @param   shapeZip   DOCUMENT ME!
     *
     * @throws  Exception  DOCUMENT ME!
     */
    private void uploadShapeFile(final String workspace,
            final File shapeZip) throws Exception {
        String layername = null;
        // open a zip file for reading
        final ZipFile zipFile = new ZipFile(shapeZip);

        // get an enumeration of the ZIP file entries
        final Enumeration<? extends ZipEntry> e = zipFile.entries();

        while (e.hasMoreElements()) {
            final ZipEntry entry = e.nextElement();

            // get the name of the entry
            final String entryName = entry.getName();
            if (FilenameUtils.getExtension(entryName).equals("shp")) {
                layername = FilenameUtils.getBaseName(entryName);
                break;
            }
        }
        boolean uploaded = false;
        if (layername != null) {
            uploaded = geoServerRESTPublisher.publishShp(workspace, workspace + "-shape", layername, shapeZip);
        } else {
            throw new Exception("No entry in zip file with extension 'shp' found.");
        }
        if (!uploaded) {
            throw new Exception("An error occured while uploading the ShapeFile.");
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   representation  DOCUMENT ME!
     * @param   url             DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  Exception  DOCUMENT ME!
     */
    private CidsBean createLayerRepresentation(final CidsBean representation, final String url) throws Exception {
        final CidsBean newRepresentation = CidsBean.createNewCidsBeanFromTableName("SWITCHON", "representation");

        final String name = representation.getProperty("name") + " Layer";
        newRepresentation.setProperty("name", name);

        final CidsBean protocolTag = fetchTagByName("OGC:WMS");
        newRepresentation.setProperty("protocol", protocolTag);

        newRepresentation.setProperty("contentlocation", url);

        newRepresentation.setProperty("uploadstatus", fetchTagByName("uploading"));

        newRepresentation.setProperty("type", fetchTagByName("original data"));

        newRepresentation.setProperty("uuid", UUID.randomUUID().toString());

        return newRepresentation;
    }

    @Override
    public void beforeInsert(final CidsBean cidsBean, final User user) {
        this.user = user;
        uploadToGeoServerInformation.clear();
        makeAdditionalRepresentationAndUploadToGeoServer(cidsBean);
    }

    @Override
    public void afterInsert(final CidsBean cidsBean, final User user) {
        for (final UploadToGeoServerInformation info : uploadToGeoServerInformation) {
            uploadToGeoServerWorker(
                info.publishStyle,
                info.workspace,
                info.sourceRepresentation,
                info.layerRepresentation);
        }
    }

    @Override
    public void beforeUpdate(final CidsBean cidsBean, final User user) {
        this.user = user;
        uploadToGeoServerInformation.clear();
        makeAdditionalRepresentationAndUploadToGeoServer(cidsBean);
    }

    @Override
    public void afterUpdate(final CidsBean cidsBean, final User user) {
        for (final UploadToGeoServerInformation info : uploadToGeoServerInformation) {
            uploadToGeoServerWorker(
                info.publishStyle,
                info.workspace,
                info.sourceRepresentation,
                info.layerRepresentation);
        }
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
        if (!geoServerRESTReader.getWorkspaceNames().contains(resourceName)) {
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

    /**
     * DOCUMENT ME!
     *
     * @param   name  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  Exception  DOCUMENT ME!
     */
    private CidsBean fetchTagByName(final String name) throws Exception {
        final MetaClass tagClass;
        try {
            tagClass = getDbServer().getClassByTableName(user, "tag");
        } catch (Throwable ex) {
            throw new Exception(ex);
        }
        String query = "SELECT id, name ";
        query += " FROM tag ";
        query += " WHERE name ilike '" + name + "' limit 1";
        final LightweightMetaObject[] lmo = getDbServer().getLightweightMetaObjectsByQuery(tagClass.getId(),
                user,
                query,
                new String[] { "NAME" });

        return lmo[0].getBean();
    }

    //~ Inner Classes ----------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @version  $Revision$, $Date$
     */
    private class UploadToGeoServerInformation {

        //~ Instance fields ----------------------------------------------------

        CidsBean publishStyle;
        String workspace;
        CidsBean sourceRepresentation;
        CidsBean layerRepresentation;

        //~ Constructors -------------------------------------------------------

        /**
         * Creates a new UploadToGeoServerInformation object.
         *
         * @param  publishStyle          DOCUMENT ME!
         * @param  workspace             DOCUMENT ME!
         * @param  sourceRepresentation  DOCUMENT ME!
         * @param  layerRepresentation   DOCUMENT ME!
         */
        public UploadToGeoServerInformation(final CidsBean publishStyle,
                final String workspace,
                final CidsBean sourceRepresentation,
                final CidsBean layerRepresentation) {
            this.publishStyle = publishStyle;
            this.workspace = workspace;
            this.sourceRepresentation = sourceRepresentation;
            this.layerRepresentation = layerRepresentation;
        }
    }
}