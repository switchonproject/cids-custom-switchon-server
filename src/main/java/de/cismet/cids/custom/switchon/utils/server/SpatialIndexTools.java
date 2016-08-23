/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import Sirius.server.sql.DBConnection;

import it.geosolutions.geoserver.rest.GeoServerRESTPublisher;
import it.geosolutions.geoserver.rest.encoder.GSLayerEncoder;
import it.geosolutions.geoserver.rest.encoder.GSResourceEncoder;
import it.geosolutions.geoserver.rest.encoder.feature.GSFeatureTypeEncoder;
import it.geosolutions.geoserver.rest.encoder.metadata.virtualtable.GSVirtualTableEncoder;
import it.geosolutions.geoserver.rest.encoder.metadata.virtualtable.VTGeometryEncoder;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import java.net.URI;
import java.net.URL;

import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import javax.activation.UnsupportedDataTypeException;

import static java.nio.file.StandardCopyOption.ATOMIC_MOVE;

/**
 * Tool for importing point or polygon geometries from shapefiles into a postgres database. Updates the spatial index
 * (geom_search table) of the SWITCH-ON Meta-Data Repository.
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
public class SpatialIndexTools {

    //~ Static fields/initializers ---------------------------------------------

    static final String GEOSERVER_URL = "http://data.water-switch-on.eu/geoserver";
    static final String GEOSERVER_WORKSPACE = "switchon";
    static final String GEOSERVER_DATASOURCE = "switchon";
    static final String GEOSERVER_LINE_STYLE = "switchon_line";
    static final String GEOSERVER_POLYGON_STYLE = "switchon_polygon";
    static final String GEOSERVER_POINT_STYLE = "switchon_point";
    static final String GEOSERVER_NAMED_POINT_STYLE = "switchon_named_point";

    static final String SRS = "EPSG:4326";
    static final String DOWNLOAD_FILENAME = "download.zip";
    public static final String SPATIAL_PROCESSING_INSTRUCTION = "deriveSpatialIndex:";

    /**
     * Decides if geoserver publisher publishes point shape files by uploading the actual shape file and creating a
     * shapefile layer (true) or by creating a database layer on basis of the geom_search table (false). Advantage of
     * the shape layer: the name property of the shape data can be used in the SLD to show names of points!
     */
    static final boolean PUBLISH_POINT_LAYER_AS_SHAPE = true;

    protected static final Logger LOGGER = Logger.getLogger(SpatialIndexTools.class);

    protected static final String selectVirtualLayerTpl =
        "SELECT id, geo_field FROM public.geom_search WHERE resource = %RESOURCE_ID%";
    protected static final String selectGeometryTypeTpl =
        "SELECT GeometryType(geo_field) from public.geom_search WHERE resource = %RESOURCE_ID% ORDER BY id DESC LIMIT 1";

    protected static final String searchGeomInsertPolygonTpl =
        "INSERT INTO public.geom_search(resource, geo_field) SELECT ?, ST_CollectionExtract(ST_MakeValid(geom),3) FROM import_tables.geosearch_import";
    protected static final String searchGeomInsertPointTpl =
        "INSERT INTO public.geom_search(resource, geo_field) SELECT ?, ST_Collect(ST_CollectionExtract(ST_MakeValid(geom),1)) FROM import_tables.geosearch_import";
    protected static final String searchGeomInsertLineTpl =
        "INSERT INTO public.geom_search(resource, geo_field) SELECT ?, ST_Union(ST_CollectionExtract(ST_MakeValid(geom),2)) FROM import_tables.geosearch_import";

    protected static final String updateResourceSpatialcoverageTpl = "WITH geom_coverage AS\n"
                + "  (INSERT INTO \"public\".geom (geo_field) SELECT ST_Envelope(ST_ConvexHull(ST_Collect(geo_field))) AS geo_field\n"
                + "   FROM public.geom_search\n"
                + "   WHERE resource = %RESOURCE_ID% RETURNING id)\n"
                + "UPDATE \"public\".resource\n"
                + "SET spatialcoverage =\n"
                + "  (SELECT id\n"
                + "   FROM geom_coverage)\n"
                + "WHERE id = %RESOURCE_ID%";

    protected static final String updateRepresentationStatusTpl = "UPDATE \"public\".representation\n"
                + "SET uploadstatus =\n"
                + "  (SELECT id\n"
                + "   FROM \"public\".tag\n"
                + "   WHERE name = ?\n"
                + "     AND taggroup =\n"
                + "       (SELECT id\n"
                + "        FROM \"public\".taggroup\n"
                + "        WHERE name = 'upload status' LIMIT 1) LIMIT 1), uploadmessage = ?\n"
                + "WHERE uuid = ?;";

    protected static final String searchGeomCopyTpl = "INSERT INTO geom_search(resource, geo_field, geom)\n"
                + "SELECT resource.id,\n"
                + "       geom.geo_field,\n"
                + "       geom.id\n"
                + "FROM resource\n"
                + "JOIN geom ON resource.spatialcoverage = geom.id\n"
                + "WHERE resource.id = ? LIMIT 1;";

    protected static final String clearGeomSearchTpl = "DELETE FROM geom_search WHERE resource = ?";

    protected static final String clearRepresentationTpl = "    DELETE\n"
                + "    FROM\n"
                + "        representation\n"
                + "    WHERE\n"
                + "        id IN (\n"
                + "            SELECT\n"
                + "                representation.id\n"
                + "            FROM\n"
                + "                representation\n"
                + "            JOIN\n"
                + "                jt_resource_representation\n"
                + "                    ON jt_resource_representation.resource_reference = ?\n"
                + "                    AND jt_resource_representation.representationid = representation.id\n"
                + "            WHERE\n"
                + "                representation.type = 213\n"
                + "                AND representation.function = 72\n"
                + "                AND representation.protocol IN (186, 205)\n"
                + "                AND representation.contenttype IN (51,59)\n"
                + "        )";

    protected static final String insertTMSRepresentationTpl = "WITH rep as \n"
                + "(INSERT INTO \"public\".representation \n"
                + "(\"type\", spatialresolution, \"name\", description, applicationprofile, tags, \n"
                + "\"function\", contentlocation, temporalresolution, protocol, content, \n"
                + "spatialscale, contenttype, uuid, uploadmessage, uploadstatus) \n"
                + "VALUES (213, NULL, 'switchon:%RESOURCE_ID% Tileserver', \n"
                + "'switchon:%RESOURCE_ID% Tileserver', 1359, 11950, 72, \n"
                + "'http://data.water-switch-on.eu/tileserver/switchon:%RESOURCE_ID%@EPSG:900913@png/{z}/{x}/{y}.png', \n"
                + "NULL, 205, NULL, NULL, 59, 'switchon:%RESOURCE_ID%', NULL, NULL) \n"
                + "RETURNING id) INSERT INTO \"public\".jt_resource_representation (representationid, resource_reference) \n"
                + "SELECT id, %RESOURCE_ID% from rep;";

    protected static final String insertWMSRepresentationTpl = "WITH rep as \n"
                + "(INSERT INTO \"public\".representation \n"
                + "(\"type\", spatialresolution, \"name\", description, applicationprofile, tags, \n"
                + "\"function\", contentlocation, temporalresolution, protocol, content, \n"
                + "spatialscale, contenttype, uuid, uploadmessage, uploadstatus) \n"
                + "VALUES (213, NULL, 'switchon:%RESOURCE_ID%', \n"
                + "'switchon:%RESOURCE_ID% WMS', 11, null, 72, \n"
                + "'http://data.water-switch-on.eu/tileserver/switchon:%RESOURCE_ID%@EPSG:900913@png/{z}/{x}/{y}.png', \n"
                + "NULL, 186, NULL, NULL, 51, 'switchon:%RESOURCE_ID%', NULL, NULL) \n"
                + "RETURNING id) INSERT INTO \"public\".jt_resource_representation (representationid, resource_reference) \n"
                + "SELECT id, %RESOURCE_ID% from rep;";

    protected static final String copyRepresentationTpl = "WITH rep as (INSERT INTO\n"
                + "    \"public\".representation (\n"
                + "        \"type\", spatialresolution, \"name\", description, applicationprofile, tags, \"function\", contentlocation, temporalresolution, protocol, content, spatialscale, contenttype, uploadmessage, uploadstatus)      \n"
                + "    (SELECT\n"
                + "        \"type\",\n"
                + "        spatialresolution,\n"
                + "        \"name\",\n"
                + "        description,\n"
                + "        applicationprofile,\n"
                + "        tags,\n"
                + "        \"function\",\n"
                + "        contentlocation,\n"
                + "        temporalresolution,\n"
                + "        protocol,\n"
                + "        content,\n"
                + "        spatialscale,\n"
                + "        contenttype,\n"
                + "        uploadmessage,\n"
                + "        uploadstatus       \n"
                + "    FROM\n"
                + "        \"public\".representation       \n"
                + "    WHERE\n"
                + "        id = %REPRESENTATION_ID%) RETURNING id) \n"
                + "INSERT INTO \"public\".jt_resource_representation (representationid, resource_reference)\n"
                + "    SELECT id, %RESOURCE_ID% from rep;";

    protected static final String findRepresentationTpl = "SELECT\n"
                + "    representation.id     \n"
                + "FROM\n"
                + "    representation                                                       \n"
                + "JOIN\n"
                + "    jt_resource_representation                                                                                                                                              \n"
                + "        ON jt_resource_representation.representationid = representation.id               -- \n"
                + "        AND jt_resource_representation.resource_reference = ?                  \n"
                + "WHERE\n"
                + "    representation.type = 213                                                                                              \n"
                + "    AND representation.function = 72                                                                                      \n"
                + "    AND representation.protocol IN (\n"
                + "        186, 205                                                                                    \n"
                + "    )                                                                                     \n"
                + "    AND representation.contenttype IN (\n"
                + "        51,59                                                                                             \n"
                + "    )            \n"
                + "ORDER BY representation.id DESC\n"
                + "LIMIT 1";

    //~ Enums ------------------------------------------------------------------

    /**
     * List of supported Geometry Types.
     *
     * @version  $Revision$, $Date$
     */
    public enum GeometryType {

        //~ Enum constants -----------------------------------------------------

        POINT("POINT"), POLYGON("POLYGON"), LINE("LINE");

        //~ Instance fields ----------------------------------------------------

        private final String text;

        //~ Constructors -------------------------------------------------------

        /**
         * Creates a new GeometryType object.
         *
         * @param  text  DOCUMENT ME!
         */
        private GeometryType(final String text) {
            this.text = text;
        }

        //~ Methods ------------------------------------------------------------

        /* (non-Javadoc)
         * @see java.lang.Enum#toString()
         */
        @Override
        public String toString() {
            return text;
        }
    }

    /**
     * List of supported File Types.
     *
     * @version  $Revision$, $Date$
     */
    public enum FileType {

        //~ Enum constants -----------------------------------------------------

        SHAPE("shp"), ZIP("zip");

        //~ Instance fields ----------------------------------------------------

        private final String fileExtension;

        //~ Constructors -------------------------------------------------------

        /**
         * Creates a new GeometryType object.
         *
         * @param  fileExtension  DOCUMENT ME!
         */
        private FileType(final String fileExtension) {
            this.fileExtension = fileExtension;
        }

        //~ Methods ------------------------------------------------------------

        /* (non-Javadoc)
         * @see java.lang.Enum#toString()
         */
        @Override
        public String toString() {
            return fileExtension;
        }
    }

    /**
     * List of supported update status types.
     *
     * @version  $Revision$, $Date$
     */
    public enum UpdateStatus {

        //~ Enum constants -----------------------------------------------------

        // yes, 'uploading' is right. We reuse the tag group 'upload status'
        FAILED("failed"), FINISHED("finished"), UPDATING("uploading");

        //~ Instance fields ----------------------------------------------------

        private final String status;

        //~ Constructors -------------------------------------------------------

        /**
         * Creates a new GeometryType object.
         *
         * @param  status  fileExtension DOCUMENT ME!
         */
        private UpdateStatus(final String status) {
            this.status = status;
        }

        //~ Methods ------------------------------------------------------------

        /* (non-Javadoc)
         * @see java.lang.Enum#toString()
         */
        @Override
        public String toString() {
            return status;
        }
    }

    //~ Instance fields --------------------------------------------------------

    protected final GeoServerRESTPublisher publisher;
    protected final Connection connection;

    protected final PreparedStatement searchGeomInsertPointStatement;
    protected final PreparedStatement searchGeomInsertPolygonStatement;
    protected final PreparedStatement searchGeomInsertLineStatement;
    protected final PreparedStatement clearGeomSearchStatement;
    protected final PreparedStatement clearRepresentationStatement;
    protected final PreparedStatement searchGeomCopyStatement;
    protected final PreparedStatement updateRepresentationStatusStatement;
    protected final PreparedStatement findRepresentationStatement;

    protected final String pghost;
    protected final String pgport;
    protected final String pgdbname;
    protected final String pgpassword;
    protected final String pguser;

    protected final List<String> curlCmdTpl = Arrays.asList(
            new String[] {
                "curl",
                "--output",
                DOWNLOAD_FILENAME,
                "--fail",
                "--write-out",
                "\'%{http_code}\'",
                "--retry",
                "3",
                "--silent"
            });

    protected final String[] unzipCmd = new String[] {
            "unzip",
            "-o",
            "-j",
            DOWNLOAD_FILENAME
        };

    protected final List<String> ogrinfoCmdTpl = Arrays.asList(
            new String[] {
                "ogrinfo",
                "-ro",
                "-q"
            });

    protected final List<String> ogr2ogrPolygonCmdTpl = Arrays.asList(
            new String[] {
                "ogr2ogr",
                "-progress",
                "-simplify",
                "0.005",
                "--config",
                "PG_USE_COPY YES",
                "-f PostgreSQL",
                "PG:host=$pghost port=$pgport dbname=$pgdbname password=$pgpassword user=$pguser",
                "-lco",
                "DIM=2",
                "$file",
                "-sql",
                "SELECT FID FROM \"$layer\"",
                "-overwrite",
                "-lco",
                "OVERWRITE=YES",
                "-t_srs",
                SRS,
                "-a_srs",
                SRS,
                "-lco",
                "SCHEMA=import_tables",
                "-lco",
                "GEOMETRY_NAME=geom",
                "-nln",
                "geosearch_import",
                "-gt",
                "65536",
                "-nlt",
                "PROMOTE_TO_MULTI",
                "-skipfailures"
            });

    protected final List<String> ogr2ogrPointCmdTpl = Arrays.asList(
            new String[] {
                "ogr2ogr",
                "-progress",
                "--config",
                "PG_USE_COPY YES",
                "-f PostgreSQL",
                "PG:host=$pghost port=$pgport dbname=$pgdbname password=$pgpassword user=$pguser",
                "-lco",
                "DIM=2",
                "$file",
                "-sql",
                "SELECT FID FROM \"$layer\"",
                "-overwrite",
                "-lco",
                "OVERWRITE=YES",
                "-t_srs",
                SRS,
                "-a_srs",
                SRS,
                "-lco",
                "SCHEMA=import_tables",
                "-lco",
                "GEOMETRY_NAME=geom",
                "-nln",
                "geosearch_import",
                "-gt",
                "65536",
                "-skipfailures"
            });

    protected final Path tempPath;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SpatialIndexTools object.
     *
     * @param   dbConnection  DOCUMENT ME!
     *
     * @throws  SQLException  DOCUMENT ME!
     */
    public SpatialIndexTools(final DBConnection dbConnection) throws SQLException {
        this.tempPath = FileSystems.getDefault().getPath(System.getProperty("java.io.tmpdir"), "switchon");

        final URI dbConnectionUri = URI.create(dbConnection.getURL().substring(5));

        final String dbName = (dbConnectionUri.getPath().indexOf('/') == 0) ? dbConnectionUri.getPath().substring(1)
                                                                            : dbConnectionUri.getPath();
        this.pgdbname = (dbName.indexOf(';') != -1) ? dbName.substring(0, dbName.indexOf(';')) : dbName;
        this.pghost = dbConnectionUri.getHost();
        this.pgport = String.valueOf(dbConnectionUri.getPort());
        this.pgpassword = dbConnection.getPassword();
        this.pguser = dbConnection.getUser();
        this.connection = dbConnection.getConnection();
        this.searchGeomInsertPointStatement = this.connection.prepareStatement(searchGeomInsertPointTpl);
        this.searchGeomInsertPolygonStatement = this.connection.prepareStatement(searchGeomInsertPolygonTpl);
        this.searchGeomInsertLineStatement = this.connection.prepareStatement(searchGeomInsertLineTpl);
        this.searchGeomCopyStatement = this.connection.prepareStatement(searchGeomCopyTpl);
        this.updateRepresentationStatusStatement = this.connection.prepareStatement(updateRepresentationStatusTpl);
        this.clearGeomSearchStatement = this.connection.prepareStatement(clearGeomSearchTpl);
        this.clearRepresentationStatement = this.connection.prepareStatement(clearRepresentationTpl);
        this.findRepresentationStatement = this.connection.prepareStatement(findRepresentationTpl);
        this.publisher = null;
    }

    /**
     * Creates a new SpatialIndexTools object.
     *
     * @param   jdbcUrl            DOCUMENT ME!
     * @param   dbUser             DOCUMENT ME!
     * @param   dbPassword         DOCUMENT ME!
     * @param   geoserverUser      DOCUMENT ME!
     * @param   geoserverPassword  DOCUMENT ME!
     *
     * @throws  ClassNotFoundException  DOCUMENT ME!
     * @throws  SQLException            DOCUMENT ME!
     */
    SpatialIndexTools(final String jdbcUrl,
            final String dbUser,
            final String dbPassword,
            final String geoserverUser,
            final String geoserverPassword) throws ClassNotFoundException, SQLException {
        this.tempPath = FileSystems.getDefault().getPath(System.getProperty("java.io.tmpdir"), "switchon");

        final URI dbConnectionUri = URI.create(jdbcUrl.substring(5));
        final String dbName = (dbConnectionUri.getPath().indexOf('/') == 0) ? dbConnectionUri.getPath().substring(1)
                                                                            : dbConnectionUri.getPath();

        this.pgdbname = (dbName.indexOf(';') != -1) ? dbName.substring(0, dbName.indexOf(';')) : dbName;
        this.pghost = dbConnectionUri.getHost();
        this.pgport = String.valueOf(dbConnectionUri.getPort());
        this.pgpassword = dbPassword;
        this.pguser = dbUser;

        this.publisher = ((geoserverUser != null) && (geoserverPassword != null))
            ? new GeoServerRESTPublisher(GEOSERVER_URL, geoserverUser, geoserverPassword) : null;
        this.connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        this.searchGeomInsertPointStatement = this.connection.prepareStatement(searchGeomInsertPointTpl);
        this.searchGeomInsertPolygonStatement = this.connection.prepareStatement(searchGeomInsertPolygonTpl);
        this.searchGeomInsertLineStatement = this.connection.prepareStatement(searchGeomInsertLineTpl);
        this.searchGeomCopyStatement = this.connection.prepareStatement(searchGeomCopyTpl);
        this.updateRepresentationStatusStatement = this.connection.prepareStatement(updateRepresentationStatusTpl);
        this.clearGeomSearchStatement = this.connection.prepareStatement(clearGeomSearchTpl);
        this.clearRepresentationStatement = this.connection.prepareStatement(clearRepresentationTpl);
        this.findRepresentationStatement = this.connection.prepareStatement(findRepresentationTpl);
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Convenience operation for updateSpatialIndex that processes SHP Files by default.
     *
     * @param   fileURL     DOCUMENT ME!
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  Exception  DOCUMENT ME!
     */
    public int updateSpatialIndex(final URL fileURL, final int resourceId) throws Exception {
        return this.updateSpatialIndex(fileURL, FileType.SHAPE, resourceId);
    }

    /**
     * Updates the spatial index of the Meta-Data Repository with the geometries from the the file downloaded from <i>
     * fileURL</i> and associates the geometries into the geom_search table with the respurc eindentified by the
     * parameter *resourceId*.<br>
     * This operation supports currently only zippded ESRI SHape Files.
     *
     * @param   fileURL     link to download file
     * @param   fileType    DOCUMENT ME!
     * @param   resourceId  id of the resource
     *
     * @return  DOCUMENT ME!
     *
     * @throws  Exception              DOCUMENT ME!
     * @throws  FileNotFoundException  DOCUMENT ME!
     * @throws  IOException            DOCUMENT ME!
     */
    public int updateSpatialIndex(
            final URL fileURL,
            final FileType fileType,
            final int resourceId) throws Exception {
        final long currentTime = System.currentTimeMillis();

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("downloading '" + fileURL + "' and inserting search geometries from *."
                        + fileType.toString() + " files for resource with id " + resourceId);
        }

        final Path workingPath = this.tempPath.resolve(
                String.valueOf(resourceId)
                        + "_"
                        + String.valueOf(System.currentTimeMillis()));

        final File workingDir = workingPath.toFile();
        workingDir.mkdirs();

        final File zipFile = this.downloadFile(workingDir, fileURL);

        this.unzipFile(workingDir);

        final File[] files = this.sanitizeFilenames(workingDir, fileType);

        if (files.length == 0) {
            throw new FileNotFoundException("getting file names from '"
                        + workingDir.getAbsolutePath() + "' did not find any file matching the pattern '*."
                        + fileType.toString() + "'");
        } else if (files.length > 1) {
            LOGGER.warn("the file downloaded from '" + fileURL + "' contains "
                        + files.length + " *." + fileType.toString()
                        + " files! Commonly only one spatial file should be processed at once.");
        }

        int i = 0;
        int searchGeomUpdateCount = 0;
        for (final File file : files) {
            i++;
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("processing file " + i + " of " + files.length + ": '" + file.getAbsolutePath() + "'");
            }

            final GeometryType geometryType = this.getFileInfo(workingDir, file.getName());
            this.importGeometries(
                workingDir,
                geometryType,
                this.pghost,
                this.pgport,
                this.pgdbname,
                this.pgpassword,
                this.pguser,
                files[0].getName());

            searchGeomUpdateCount += this.insertSearchGeometries(geometryType, resourceId);

            if (this.publisher != null) {
                if (this.publishToGeoserver(zipFile, geometryType, resourceId)) {
                    this.insertTMSRepresentation(resourceId);
                } else {
                    final String message = "could not publish resource " + resourceId + " to geoserver.";
                    LOGGER.error(message);
                    throw new IOException(message);
                }
            }
        }

        int geomUpdateCount = 0;
        if (searchGeomUpdateCount > 0) {
            geomUpdateCount = this.updateResourceSpatialcoverage(resourceId);
        }

        LOGGER.info("downloaded '" + fileURL + "', inserted " + searchGeomUpdateCount + " search geometries from *."
                    + fileType.toString() + " file and updated " + geomUpdateCount
                    + " spatial coverage for resource with id " + resourceId
                    + " in " + ((System.currentTimeMillis() - currentTime) / 1000) + " seconds.");

        return searchGeomUpdateCount;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   fileURL     DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  IOException           DOCUMENT ME!
     * @throws  InterruptedException  DOCUMENT ME!
     * @throws  TimeoutException      DOCUMENT ME!
     * @throws  ExecutionException    DOCUMENT ME!
     */
    protected File downloadFile(final File workingDir, final URL fileURL) throws IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException {
        LOGGER.info("downloading file from '" + fileURL + "' to '"
                    + workingDir.getAbsolutePath() + "'");

        final String[] curlCmd = curlCmdTpl.toArray(new String[curlCmdTpl.size() + 1]);
        curlCmd[curlCmd.length - 1] = fileURL.toString();

        final int timeout = 15;
        final ProcessBuilder processBuilder = new ProcessBuilder(curlCmd);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(curlCmd));
        }

        final Process process = processBuilder.start();
        // disabled for Java 1.7 compatibility final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES); if
        // (!completed) { process.destroy(); throw new TimeoutException("downloading " + fileURL + " timed out after " +
        // timeout + " minutes."); }

        final int exitValue = process.waitFor();
        if (exitValue != 0) {
            final String message = outputError(process.getInputStream(), process.getErrorStream());
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("downloading " + fileURL
                        + " failed with exit value " + exitValue,
                processException);
        }

        final File zipFile = new File(workingDir, DOWNLOAD_FILENAME);
        if (zipFile.exists() && zipFile.canRead()) {
            return zipFile;
        } else {
            final String message = "downloaded file '" + zipFile.getAbsolutePath()
                        + "' does not exist or is not readable!";
            LOGGER.error(message);
            throw new FileNotFoundException(message);
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workingDir  DOCUMENT ME!
     *
     * @throws  IOException           DOCUMENT ME!
     * @throws  InterruptedException  DOCUMENT ME!
     * @throws  TimeoutException      DOCUMENT ME!
     * @throws  ExecutionException    DOCUMENT ME!
     */
    protected void unzipFile(final File workingDir) throws IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException {
        LOGGER.info("unzipping downloaded file to '"
                    + workingDir.getAbsolutePath() + "'");

        final int timeout = 2;
        final ProcessBuilder processBuilder = new ProcessBuilder(unzipCmd);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(unzipCmd));
        }
        final Process process = processBuilder.start();
        // disabled for Java 1.7 compatibility final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES); if
        // (!completed) { process.destroy(); throw new TimeoutException("unzipping '" + DOWNLOAD_FILENAME + "' timed out
        // after " + timeout + " minutes."); }

        final int exitValue = process.waitFor();
        if (exitValue != 0) {
            final String message = outputError(process.getInputStream(), process.getErrorStream());
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("unzipping '" + DOWNLOAD_FILENAME + "' failed with exit value " + exitValue,
                processException);
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   file        DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  IOException                   DOCUMENT ME!
     * @throws  InterruptedException          DOCUMENT ME!
     * @throws  TimeoutException              DOCUMENT ME!
     * @throws  ExecutionException            DOCUMENT ME!
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     */
    protected GeometryType getFileInfo(final File workingDir, final String file) throws IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException,
        UnsupportedDataTypeException {
        LOGGER.info("getting info of file '" + file + "' in '"
                    + workingDir.getAbsolutePath() + "'");

        final String[] ogrinfoCmd = ogrinfoCmdTpl.toArray(new String[ogrinfoCmdTpl.size() + 1]);
        ogrinfoCmd[ogrinfoCmd.length - 1] = file;
        final int timeout = 30;

        final ProcessBuilder processBuilder = new ProcessBuilder(ogrinfoCmd);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(ogrinfoCmd));
        }
        final Process process = processBuilder.start();
        // disabled for Java 1.7 compatibility final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS); if
        // (!completed) { process.destroy(); throw new TimeoutException("getting info of file '" + file + "' timed out
        // after " + timeout + " seconds."); }

        final int exitValue = process.waitFor();
        if (exitValue != 0) {
            final String message = outputError(process.getInputStream(), process.getErrorStream());
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("getting info of file '" + file + "' failed with exit value " + exitValue,
                processException);
        }

        final String[] output = output(process.getInputStream());
        if (output.length == 0) {
            throw new IOException("getting info of file '" + file + "' failed: no info found by ogrinfo");
        }

        final StringBuilder sb = new StringBuilder();
        GeometryType geometryType = null;

        for (final String line : output) {
            sb.append(line).append(System.getProperty("line.separator"));
            if (line.toLowerCase().contains(GeometryType.POINT.toString().toLowerCase())) {
                if (geometryType == null) {
                    geometryType = GeometryType.POINT;
                } else {
                    LOGGER.warn("spatial file '" + file + "' seems to contain more than one layer: '"
                                + geometryType + "' + '" + GeometryType.POINT
                                + "'! Only the type of the first layer is considered!");
                }
            } else if (line.toLowerCase().contains(GeometryType.POLYGON.toString().toLowerCase())) {
                if (geometryType == null) {
                    geometryType = GeometryType.POLYGON;
                } else {
                    LOGGER.warn("spatial file '" + file + "' seems to contain more than one layer: '"
                                + geometryType + "' + '" + GeometryType.POLYGON
                                + "'! Only the type of the first layer is considered!");
                }
            } else if (line.toLowerCase().contains(GeometryType.LINE.toString().toLowerCase())) {
                if (geometryType == null) {
                    geometryType = GeometryType.LINE;
                } else {
                    LOGGER.warn("spatial file '" + file + "' seems to contain more than one layer: '"
                                + geometryType + "' + '" + GeometryType.LINE
                                + "'! Only the type of the first layer is considered!");
                }
            } else {
                LOGGER.warn("no supported geometry type found in layer info: '" + line + "'");
            }
        }

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(sb.toString());
        }

        if (geometryType == null) {
            throw new UnsupportedDataTypeException("info spatial file '" + file + "' does not contain '"
                        + GeometryType.POINT.toString() + "', '" + GeometryType.POLYGON.toString()
                        + "' or '" + GeometryType.LINE.toString() + "': "
                        + sb.toString());
        }

        return geometryType;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workingDir    DOCUMENT ME!
     * @param   geometryType  DOCUMENT ME!
     * @param   pghost        DOCUMENT ME!
     * @param   pgport        DOCUMENT ME!
     * @param   pgdbname      DOCUMENT ME!
     * @param   pgpassword    DOCUMENT ME!
     * @param   pguser        DOCUMENT ME!
     * @param   file          DOCUMENT ME!
     *
     * @throws  IOException                   DOCUMENT ME!
     * @throws  InterruptedException          DOCUMENT ME!
     * @throws  TimeoutException              DOCUMENT ME!
     * @throws  ExecutionException            DOCUMENT ME!
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     */
    protected void importGeometries(
            final File workingDir,
            final GeometryType geometryType,
            final String pghost,
            final String pgport,
            final String pgdbname,
            final String pgpassword,
            final String pguser,
            final String file) throws IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException,
        UnsupportedDataTypeException {
        LOGGER.info("importing '" + geometryType + "' spatial file '" + file + "' from '"
                    + workingDir.getAbsolutePath() + "' into database '" + pghost + ":" + pgport + "/" + pgdbname
                    + "'");
        // FIXME: can we safely assume that the shp layer name is always the filename of the SHP file?
        final String layer = FilenameUtils.removeExtension(file);
        final String[] ogr2ogrCmd;
        final int argPgIndex;
        final int argFileIndex;
        final int argLayerIndex;

        // choose polygon or point ogr2ogr import command
        if ((geometryType == GeometryType.POLYGON) || (geometryType == GeometryType.LINE)) {
            ogr2ogrCmd = ogr2ogrPolygonCmdTpl.toArray(new String[ogr2ogrPolygonCmdTpl.size()]);
            argPgIndex = 7;
            argFileIndex = 10;
            argLayerIndex = 12;
        } else if (geometryType == GeometryType.POINT) {
            ogr2ogrCmd = ogr2ogrPointCmdTpl.toArray(new String[ogr2ogrPointCmdTpl.size()]);
            argPgIndex = 5;
            argFileIndex = 8;
            argLayerIndex = 10;
        } else {
            throw new UnsupportedDataTypeException("Geometry Type '" + geometryType
                        + "' is not supported by this operation");
        }

        ogr2ogrCmd[argPgIndex] = ogr2ogrCmd[argPgIndex].replace("$pghost", pghost);
        ogr2ogrCmd[argPgIndex] = ogr2ogrCmd[argPgIndex].replace("$pgport", pgport);
        ogr2ogrCmd[argPgIndex] = ogr2ogrCmd[argPgIndex].replace("$pgdbname", pgdbname);
        ogr2ogrCmd[argPgIndex] = ogr2ogrCmd[argPgIndex].replace("$pgpassword", pgpassword);
        ogr2ogrCmd[argPgIndex] = ogr2ogrCmd[argPgIndex].replace("$pguser", pguser);
        ogr2ogrCmd[argFileIndex] = file;
        ogr2ogrCmd[argLayerIndex] = ogr2ogrCmd[argLayerIndex].replace("$layer", layer);

        // wait 30 minutes for import
        final int timeout = 30;

        final File outputFile = new File(workingDir, "output.txt");
        outputFile.createNewFile();

        final File errorFile = new File(workingDir, "error.txt");
        errorFile.createNewFile();

        final ProcessBuilder processBuilder = new ProcessBuilder(ogr2ogrCmd);
        processBuilder.directory(workingDir);
        processBuilder.redirectOutput(outputFile);
        processBuilder.redirectError(errorFile);
        // processBuilder.redirectErrorStream(true);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(ogr2ogrCmd));
        }
        final Process process = processBuilder.start();
        // disabled for Java 1.7 compatibility final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES); if
        // (!completed) { process.destroy();
        //
        // throw new TimeoutException("importing spatial file '" + file + "' into database '" + pghost + ":" + pgport +
        // "/" + pgdbname + "' timed out after " + timeout + " seconds."); }

        final int exitValue = process.waitFor();
        if (exitValue != 0) {
            final String message = outputError(new FileInputStream(outputFile), new FileInputStream(errorFile));
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("importing spatial file '" + file
                        + "' into database '" + pghost + ":" + pgport + "/" + pgdbname + "' failed with exit value "
                        + exitValue,
                processException);
        }

        final String[] output = output(new FileInputStream(outputFile));
        if (output.length == 0) {
            throw new IOException("importing spatial file '" + file
                        + "' into database '" + pghost + ":" + pgport + "/" + pgdbname
                        + "' failed: no progress reported from ogr2ogr command");
        }

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(output));
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   geometryType  DOCUMENT ME!
     * @param   resourceId    DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     */
    protected int insertSearchGeometries(final GeometryType geometryType, final int resourceId)
            throws UnsupportedDataTypeException, SQLException {
        LOGGER.info("inserting imported '" + geometryType + "' geometries for resource with id '"
                    + resourceId + "' into the search geometries table");

        synchronized (clearGeomSearchStatement) {
            clearGeomSearchStatement.setInt(1, resourceId);
            final int deleteCount = clearGeomSearchStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(deleteCount + " old '" + geometryType + "' geometries for resource with id '"
                            + resourceId + "' removed from search geometries table");
            }
        }

        final PreparedStatement searchGeomInsertStatement;
        if (geometryType == GeometryType.POLYGON) {
            searchGeomInsertStatement = searchGeomInsertPolygonStatement;
        } else if (geometryType == GeometryType.POINT) {
            searchGeomInsertStatement = searchGeomInsertPointStatement;
        } else if (geometryType == GeometryType.LINE) {
            searchGeomInsertStatement = searchGeomInsertLineStatement;
        } else {
            throw new UnsupportedDataTypeException("Geometry Type '" + geometryType
                        + "' is not supported by this operation");
        }

        final int updateCount;
        synchronized (searchGeomInsertStatement) {
            searchGeomInsertStatement.setInt(1, resourceId);
            updateCount = searchGeomInsertStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(updateCount + " imported '" + geometryType + "' geometries for resource with id '"
                            + resourceId + "' inserted into the search geometries table");
            }
        }

        return updateCount;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     */
    protected int insertTMSRepresentation(final int resourceId) throws UnsupportedDataTypeException, SQLException {
        return this.insertRepresentation(resourceId, true);
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     */
    protected int insertWMSRepresentation(final int resourceId) throws UnsupportedDataTypeException, SQLException {
        return this.insertRepresentation(resourceId, false);
    }

    /**
     * Helper Method to insert a new representation referring to a TMS Layer.
     *
     * @param   resourceId  DOCUMENT ME!
     * @param   isTMS       DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     */
    protected int insertRepresentation(final int resourceId, final boolean isTMS) throws UnsupportedDataTypeException,
        SQLException {
        LOGGER.info("inserting new representation for resource with id '"
                    + resourceId + "'");

        synchronized (clearRepresentationStatement) {
            clearRepresentationStatement.setInt(1, resourceId);
            final int deleteCount = clearRepresentationStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(deleteCount + " old " + (isTMS ? "TMS" : "WMS")
                            + " representations for resource with id '"
                            + resourceId + "' removed");
            }
        }

        final String insertRepresentation;

        if (isTMS) {
            insertRepresentation = insertTMSRepresentationTpl.replaceAll(
                    "%RESOURCE_ID%",
                    String.valueOf(resourceId));
        } else {
            insertRepresentation = insertWMSRepresentationTpl.replaceAll(
                    "%RESOURCE_ID%",
                    String.valueOf(resourceId));
        }

        final Statement insertRepresentationStatement = this.connection.createStatement();
        final int updateCount = insertRepresentationStatement.executeUpdate(insertRepresentation);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(updateCount + " representations for resource with id '"
                        + resourceId + "' inserted");
        }

        return updateCount;
    }

    /**
     * Copies a WMS/TMS map layer representation from a source to a target resource.
     *
     * @param   sourceResourceId  DOCUMENT ME!
     * @param   targetResourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     * @throws  FileNotFoundException         DOCUMENT ME!
     */
    public int copyRepresentation(
            final int sourceResourceId,
            final int targetResourceId) throws UnsupportedDataTypeException, SQLException, FileNotFoundException {
        LOGGER.info("copying representation from source resource with id '"
                    + sourceResourceId + "' to target resource with id '" + targetResourceId + "'");

        int representationId = -1;
        synchronized (findRepresentationStatement) {
            findRepresentationStatement.setInt(1, sourceResourceId);
            final ResultSet resultSet = findRepresentationStatement.executeQuery();
            if (resultSet.next()) {
                representationId = resultSet.getInt(1);
            }
            resultSet.close();
        }

        if (representationId == -1) {
            final String message = "could no copy representation from source resource with id '"
                        + sourceResourceId + "' to target resource with id '" + targetResourceId
                        + "': no suitable representation found for source resource";
            LOGGER.error(message);
            throw new FileNotFoundException(message);
        }

        synchronized (clearRepresentationStatement) {
            clearRepresentationStatement.setInt(1, targetResourceId);
            final int deleteCount = clearRepresentationStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(deleteCount + " old representations for resource with id '"
                            + targetResourceId + "' removed");
            }
        }

        final String copyRepresentation = copyRepresentationTpl.replaceAll(
                    "%RESOURCE_ID%",
                    String.valueOf(targetResourceId))
                    .replaceAll("%REPRESENTATION_ID%", String.valueOf(targetResourceId));

        final Statement copyRepresentationStatement = this.connection.createStatement();
        final int updateCount = copyRepresentationStatement.executeUpdate(copyRepresentation);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(updateCount + " representations from source resource with id '"
                        + sourceResourceId + "' to target resource with id '" + targetResourceId + "' copied");
        }

        return updateCount;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  SQLException  DOCUMENT ME!
     */
    protected int updateResourceSpatialcoverage(final int resourceId) throws SQLException {
        LOGGER.info("updating the spatial coverage of resource with id '"
                    + resourceId + "'");

        final String updateResourceSpatialcoverage = updateResourceSpatialcoverageTpl.replaceAll(
                "%RESOURCE_ID%",
                String.valueOf(resourceId));

        final Statement updateResourceSpatialcoverageStatement = this.connection.createStatement();
        final int updateCount = updateResourceSpatialcoverageStatement.executeUpdate(updateResourceSpatialcoverage);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(updateCount + " spatial coverages for resource with id '"
                        + resourceId + "' updated");
        }

        return updateCount;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  SQLException            DOCUMENT ME!
     * @throws  NoSuchElementException  DOCUMENT ME!
     */
    protected String getGeometryTypeForResource(final int resourceId) throws SQLException {
        LOGGER.info("retrieving geometry type for  '" + resourceId + "' from PostGIS database");

        final String selectGeometryType = selectGeometryTypeTpl.replaceAll(
                "%RESOURCE_ID%",
                String.valueOf(resourceId));

        final Statement selectGeometryTypeStatement = this.connection.createStatement();
        final ResultSet resultSet = selectGeometryTypeStatement.executeQuery(selectGeometryType);

        if (resultSet.next()) {
            final String geometryType = resultSet.getString(1);
            return geometryType;
        } else {
            throw new NoSuchElementException("search geometry for  '" + resourceId
                        + "' could not be found PostGIS database");
        }
    }

    /**
     * DOCUMENT ME!
     *
     * @param   zipFile       DOCUMENT ME!
     * @param   geometryType  DOCUMENT ME!
     * @param   resourceId    DOCUMENT ME!
     *
     * @return  true if the operation completed successfully
     *
     * @throws  UnsupportedDataTypeException  DOCUMENT ME!
     * @throws  SQLException                  DOCUMENT ME!
     * @throws  FileNotFoundException         DOCUMENT ME!
     * @throws  NullPointerException          DOCUMENT ME!
     */
    protected boolean publishToGeoserver(
            final File zipFile,
            final GeometryType geometryType,
            final int resourceId) throws UnsupportedDataTypeException, SQLException, FileNotFoundException {
        if (this.publisher == null) {
            throw new NullPointerException("cannot pusblish layer for resource "
                        + resourceId + " of type '" + geometryType + "': GeoServerPublisher not initialized!");
        }

        final String geometryTypeForResource = this.getGeometryTypeForResource(resourceId);

        if (PUBLISH_POINT_LAYER_AS_SHAPE && (geometryType == GeometryType.POINT)) {
            LOGGER.info("publishing new SHAPEFILE layer '" + resourceId + "' of type '" + geometryTypeForResource
                        + "' (" + geometryType + ") to " + GEOSERVER_URL);

            return publisher.publishShp(
                    GEOSERVER_WORKSPACE,
                    String.valueOf(resourceId),
                    String.valueOf(resourceId),
                    zipFile,
                    SRS,
                    GEOSERVER_NAMED_POINT_STYLE);
        } else {
            final GSLayerEncoder layer = new GSLayerEncoder();
            if (geometryType == GeometryType.POLYGON) {
                layer.setDefaultStyle(GEOSERVER_POLYGON_STYLE);
            } else if (geometryType == GeometryType.POINT) {
                layer.setDefaultStyle(GEOSERVER_POINT_STYLE);
            } else if (geometryType == GeometryType.LINE) {
                layer.setDefaultStyle(GEOSERVER_LINE_STYLE);
            } else {
                throw new UnsupportedDataTypeException("Geometry Type '" + geometryType
                            + "' for resource " + resourceId + " is not supported by this operation");
            }

            LOGGER.info("publishing new DATABASE layer '" + resourceId + "' of type '" + geometryTypeForResource
                        + "' (" + geometryType + ") to " + GEOSERVER_URL);

            final VTGeometryEncoder vtGeom = new VTGeometryEncoder();
            vtGeom.setName("geo_field");
            vtGeom.setType(geometryTypeForResource);
            vtGeom.setSrid("4326");

            final String selectVirtualLayerStatement = selectVirtualLayerTpl.replaceAll(
                    "%RESOURCE_ID%",
                    String.valueOf(resourceId));

            // Set-up the virtual table
            final GSVirtualTableEncoder vte = new GSVirtualTableEncoder();
            vte.setName(String.valueOf(resourceId));
            vte.setSql(selectVirtualLayerStatement);
            vte.addKeyColumn("id");
            vte.addVirtualTableGeometry(vtGeom);

            final GSFeatureTypeEncoder featureType = new GSFeatureTypeEncoder();
            featureType.setName(String.valueOf(resourceId));
            featureType.setTitle(String.valueOf(resourceId));
            featureType.setAbstract("Feature Layer for SWITCH-ON Resource " + resourceId);
            featureType.setDescription("Feature Layer for SWITCH-ON Resource " + resourceId);
            featureType.setSRS(SRS);
            featureType.setNativeCRS(SRS);
            featureType.addKeyword("SWITCHON");
            featureType.setProjectionPolicy(GSResourceEncoder.ProjectionPolicy.FORCE_DECLARED);

            featureType.setMetadataVirtualTable(vte);

            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("FeatureType '" + featureType.toString() + " created");
            }

            return publisher.publishDBLayer(GEOSERVER_WORKSPACE, GEOSERVER_DATASOURCE,
                    featureType, layer);
        }
    }

    /**
     * Helper method to sanitize File names for OGR2OGR.
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   fileType    DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  IOException  DOCUMENT ME!
     */
    protected File[] sanitizeFilenames(final File workingDir, final FileType fileType) throws IOException {
        if (fileType == FileType.SHAPE) {
            final File[] allFiles = workingDir.listFiles(new FilenameFilter() {

                        @Override
                        public boolean accept(final File dir, final String name) {
                            // don't sanitize zip file name
                            return !name.equalsIgnoreCase(DOWNLOAD_FILENAME);
                        }
                    });

            for (final File file : allFiles) {
                if (file.isFile()) {
                    boolean invalidFilename = true;
                    try {
                        Integer.parseInt(file.getName().substring(0, 1));
                    } catch (final Throwable ignore) {
                        invalidFilename = false;
                    }

                    if (invalidFilename) {
                        final Path oldPath = file.toPath();
                        final Path newPath = oldPath.resolveSibling(FileType.SHAPE.toString() + "_" + file.getName());
                        if (LOGGER.isDebugEnabled()) {
                            LOGGER.warn("'" + oldPath.toString() + "' is an invalid "
                                        + FileType.SHAPE.toString() + " filename, renaming to '"
                                        + newPath.toString() + "'.");
                        }

                        Files.move(oldPath, newPath, ATOMIC_MOVE);
                    }
                }
            }
        }

        return listSupportedFiles(workingDir, fileType);
    }

    /**
     * List all files in the working directory that have a specific pattern .
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   fileType    extension DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected File[] listSupportedFiles(final File workingDir, final FileType fileType) {
        final File[] files = workingDir.listFiles(new FilenameFilter() {

                    @Override
                    public boolean accept(final File dir, final String name) {
                        return name.toLowerCase().endsWith("." + fileType.toString().toLowerCase());
                    }
                });

        Arrays.sort(files);
        return files;
    }
    /**
     * Start with resourceId, postgres password, geoserver password.
     *
     * @param  args  DOCUMENT ME!
     */
    public static void main(final String[] args) {
        final Properties log4jProperties = new Properties();
        log4jProperties.put("log4j.appender.Remote", "org.apache.log4j.net.SocketAppender");
        log4jProperties.put("log4j.appender.Remote.remoteHost", "localhost");
        log4jProperties.put("log4j.appender.Remote.port", "4445");
        log4jProperties.put("log4j.appender.Remote.locationInfo", "true");
        log4jProperties.put("log4j.rootLogger", "ALL,Remote");
        PropertyConfigurator.configure(log4jProperties);

        if (args.length == 0) {
            LOGGER.fatal("first required argument resource id is missing, bailing out!");
            System.exit(1);
        } else if (args.length < 2) {
            LOGGER.fatal("2nd required pg password argument is missing, bailing out!");
            System.exit(1);
        }

        final int resourceId = Integer.parseInt(args[0]);
        final String dbPassword = args[1];
        final String geoserverPassword = (args.length > 2) ? args[2] : null;
        final String download = (args.length > 3) ? args[3] : ("http://localhost:3030/" + resourceId + ".zip");
        final String database = (args.length > 4) ? args[4] : "jdbc:postgresql://127.0.0.1:5432/switchon";
        final String dbUser = (args.length > 5) ? args[5] : "switchon";
        final String geoserverUser = (args.length > 6) ? args[6] : "admin";

        SpatialIndexTools.LOGGER.info("Starting Spatial Index Import with \n "
                    + "resource: '" + resourceId + "'\n "
                    + "file: '" + download + "'\n "
                    + "database: '" + database + "'\n "
                    + "user: '" + dbUser + "'");

        try {
            final SpatialIndexTools spatialIndexTools = new SpatialIndexTools(
                    database,
                    dbUser,
                    dbPassword,
                    geoserverUser,
                    geoserverPassword);

            spatialIndexTools.updateSpatialIndex(
                new URL(download),
                resourceId);
        } catch (Throwable t) {
            SpatialIndexTools.LOGGER.fatal(t.getMessage(), t);
            System.exit(1);
        }
    }

    // Connection

    /**
     * DOCUMENT ME!
     *
     * @param   processOutputStream  DOCUMENT ME!
     * @param   processErrorStream   DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected static String outputError(final InputStream processOutputStream, final InputStream processErrorStream) {
        final StringBuilder sb = outputError(processOutputStream);
        sb.append(System.getProperty("line.separator")).append(outputError(processErrorStream));

        return sb.toString();
    }

    /**
     * DOCUMENT ME!
     *
     * @param   processOutputStream  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected static StringBuilder outputError(final InputStream processOutputStream) {
        final StringBuilder sb = new StringBuilder();
        BufferedReader br = null;
        try {
            br = new BufferedReader(new InputStreamReader(processOutputStream));
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append(System.getProperty("line.separator"));
            }
        } catch (IOException ex) {
            sb.append(ex.getMessage());
            LOGGER.error(ex.getMessage(), ex);
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException ex) {
                    sb.append(ex.getMessage());
                    LOGGER.warn(ex.getMessage(), ex);
                }
            }
        }

        return sb;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   processOutputStream  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     *
     * @throws  IOException  DOCUMENT ME!
     */
    protected static String[] output(final InputStream processOutputStream) throws IOException {
        final LinkedList<String> output = new LinkedList<String>();
        BufferedReader br = null;
        try {
            br = new BufferedReader(new InputStreamReader(processOutputStream));
            String line;
            while ((line = br.readLine()) != null) {
                output.add(line);
            }
        } finally {
            if (br != null) {
                br.close();
            }
        }

        return output.toArray(new String[output.size()]);
    }

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public PreparedStatement getSearchGeomCopyStatement() {
        return searchGeomCopyStatement;
    }

    /**
     * DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public PreparedStatement getUpdateRepresentationStatusStatement() {
        return updateRepresentationStatusStatement;
    }
}
