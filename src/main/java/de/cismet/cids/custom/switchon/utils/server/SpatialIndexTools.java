/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import Sirius.server.sql.DBConnection;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import java.net.URI;
import java.net.URL;

import java.nio.file.CopyOption;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
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

    public static final String DOWNLOAD_FILENAME = "download.zip";
    public static final String SPATIAL_PROCESSING_INSTRUCTION = "deriveSpatialIndex:";

    protected static final Logger LOGGER = Logger.getLogger(SpatialIndexTools.class);

    protected static final String searchGeomInsertPolygonTpl =
        "INSERT INTO public.geom_search(resource, geo_field) SELECT ?, geom FROM import_tables.geosearch_import";
    protected static final String searchGeomInsertPointTpl =
        "INSERT INTO public.geom_search(resource, geo_field) SELECT ?, ST_Collect(geom) FROM import_tables.geosearch_import";

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

    //~ Enums ------------------------------------------------------------------

    /**
     * List of supported Geometry Types.
     *
     * @version  $Revision$, $Date$
     */
    public enum GeometryType {

        //~ Enum constants -----------------------------------------------------

        POINT("POINT"), POLYGON("POLYGON");

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

        SHAPE("shp");

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

    protected final PreparedStatement searchGeomInsertPointStatement;
    protected final PreparedStatement searchGeomInsertPolygonStatement;
    protected final PreparedStatement searchGeomCopyStatement;
    protected final PreparedStatement updateRepresentationStatusStatement;

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
            "-s",
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
                "500",
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
                "EPSG:4326",
                "-a_srs",
                "EPSG:4326",
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
                "EPSG:4326",
                "-a_srs",
                "EPSG:4326",
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
        this.searchGeomInsertPointStatement = dbConnection.getConnection().prepareStatement(searchGeomInsertPointTpl);
        this.searchGeomInsertPolygonStatement = dbConnection.getConnection()
                    .prepareStatement(searchGeomInsertPolygonTpl);
        this.searchGeomCopyStatement = dbConnection.getConnection().prepareStatement(searchGeomCopyTpl);
        this.updateRepresentationStatusStatement = dbConnection.getConnection()
                    .prepareStatement(updateRepresentationStatusTpl);
    }

    /**
     * Creates a new SpatialIndexTools object.
     *
     * @param   jdbcUrl   DOCUMENT ME!
     * @param   user      DOCUMENT ME!
     * @param   password  DOCUMENT ME!
     *
     * @throws  ClassNotFoundException  DOCUMENT ME!
     * @throws  SQLException            DOCUMENT ME!
     */
    private SpatialIndexTools(final String jdbcUrl, final String user, final String password)
            throws ClassNotFoundException, SQLException {
        this.tempPath = FileSystems.getDefault().getPath(System.getProperty("java.io.tmpdir"), "switchon");

        final URI dbConnectionUri = URI.create(jdbcUrl.substring(5));
        final String dbName = (dbConnectionUri.getPath().indexOf('/') == 0) ? dbConnectionUri.getPath().substring(1)
                                                                            : dbConnectionUri.getPath();

        this.pgdbname = (dbName.indexOf(';') != -1) ? dbName.substring(0, dbName.indexOf(';')) : dbName;
        this.pghost = dbConnectionUri.getHost();
        this.pgport = String.valueOf(dbConnectionUri.getPort());
        this.pgpassword = password;
        this.pguser = user;

        final Connection connection = DriverManager.getConnection(jdbcUrl, user, password);
        this.searchGeomInsertPointStatement = connection.prepareStatement(searchGeomInsertPointTpl);
        this.searchGeomInsertPolygonStatement = connection.prepareStatement(searchGeomInsertPolygonTpl);
        this.searchGeomCopyStatement = connection.prepareStatement(searchGeomCopyTpl);
        this.updateRepresentationStatusStatement = connection.prepareStatement(updateRepresentationStatusTpl);
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Convienence operation for updateSpatialIndex that processes SHP Files by default.
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
     */
    public int updateSpatialIndex(final URL fileURL, final FileType fileType, final int resourceId) throws Exception {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("downloading '" + fileURL + "' and inserting search geometries from *."
                        + fileType.toString() + " files for resource with id " + resourceId);
        }

        final Path workingPath = this.tempPath.resolve(String.valueOf(System.currentTimeMillis()));

        final File workingDir = workingPath.toFile();
        workingDir.mkdirs();

        this.downloadFile(workingDir, fileURL);

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
        int updateCount = 0;
        for (final File file : files) {
            i++;
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("processing file " + i + " of" + files.length + ": '" + file.getAbsolutePath() + "'");
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

            updateCount += this.insertSearchGeometries(geometryType, resourceId);
        }

        LOGGER.info("downloaded '" + fileURL + "' and inserted " + updateCount + " search geometries from *."
                    + fileType.toString() + " files for resource with id " + resourceId);

        return updateCount;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   fileURL     DOCUMENT ME!
     *
     * @throws  IOException           DOCUMENT ME!
     * @throws  InterruptedException  DOCUMENT ME!
     * @throws  TimeoutException      DOCUMENT ME!
     * @throws  ExecutionException    DOCUMENT ME!
     */
    protected void downloadFile(final File workingDir, final URL fileURL) throws IOException,
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
        final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("downloading " + fileURL
                        + " timed out after " + timeout + " minutes.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final String message = outputError(process.getInputStream(), process.getErrorStream());
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("downloading " + fileURL
                        + " failed with exit value " + exitValue,
                processException);
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
        final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("unzipping '" + DOWNLOAD_FILENAME + "' timed out after " + timeout
                        + " minutes.");
        }

        final int exitValue = process.exitValue();
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
        final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("getting info of file '" + file + "' timed out after " + timeout + " seconds.");
        }

        final int exitValue = process.exitValue();
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
            } else {
                LOGGER.warn("no supported geometry type found in layer info: '" + line + "'");
            }
        }

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(sb.toString());
        }

        if (geometryType == null) {
            throw new UnsupportedDataTypeException("info spatial file '" + file + "' does not contain '"
                        + GeometryType.POINT.toString() + "' or '" + GeometryType.POLYGON.toString() + "': "
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
        if (geometryType == GeometryType.POLYGON) {
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

        final ProcessBuilder processBuilder = new ProcessBuilder(ogr2ogrCmd);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(Arrays.toString(ogr2ogrCmd));
        }
        final Process process = processBuilder.start();
        final boolean completed = process.waitFor(timeout, TimeUnit.MINUTES);
        if (!completed) {
            process.destroy();

            throw new TimeoutException("importing spatial file '" + file
                        + "' into database '" + pghost + ":" + pgport + "/" + pgdbname + "' timed out after " + timeout
                        + " seconds.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final String message = outputError(process.getInputStream(), process.getErrorStream());
            LOGGER.error(message);
            final Exception processException = new Exception(message);
            throw new ExecutionException("importing spatial file '" + file
                        + "' into database '" + pghost + ":" + pgport + "/" + pgdbname + "' failed with exit value "
                        + exitValue,
                processException);
        }

        final String[] output = output(process.getInputStream());
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

        final PreparedStatement searchGeomInsertStatement;
        if (geometryType == GeometryType.POLYGON) {
            searchGeomInsertStatement = searchGeomInsertPolygonStatement;
        } else if (geometryType == GeometryType.POINT) {
            searchGeomInsertStatement = searchGeomInsertPointStatement;
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
     * Helper methid to sanitize File names for OGR2OGR.
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
                        LOGGER.warn("'" + oldPath.toString() + "' is an invalid "
                                    + FileType.SHAPE.toString() + " filename, renaming to '"
                                    + newPath.toString() + "'.");

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

        return files;
    }
    /**
     * DOCUMENT ME!
     *
     * @param  args  DOCUMENT ME!
     */
    public static void main(final String[] args) {
        BasicConfigurator.configure();

        if (args.length == 0) {
            LOGGER.fatal("first required argument pg password is missing, bailing out!");
            System.exit(1);
        }

        try {
            final SpatialIndexTools spatialIndexTools = new SpatialIndexTools(
                    "jdbc:postgresql://switchon.cismet.de:5434/switchon_dev",
                    "postgres",
                    args[0]);

            spatialIndexTools.updateSpatialIndex(
                new URL("http://dl-ng003.xtr.deltares.nl/downloadallzip/zippeddownload/regulartzt.zip"),
                11986);
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
