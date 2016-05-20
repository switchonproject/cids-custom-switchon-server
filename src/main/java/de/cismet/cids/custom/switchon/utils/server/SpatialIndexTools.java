/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import java.net.URL;

import java.nio.file.FileSystems;
import java.nio.file.Path;

import java.util.LinkedList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
public class SpatialIndexTools {

    //~ Static fields/initializers ---------------------------------------------

    protected static final Logger LOGGER = Logger.getLogger(SpatialIndexTools.class);

    //~ Instance fields --------------------------------------------------------

    protected final String curlArgsTpl =
        "--output download.zip --fail --write-out \"%{http_code}\" --retry 3 --silent $url";
    protected final String unzipArgs = "-o -j download.zip";
    protected final String lsArgsTpl = "| grep -i \"$pattern\"";
    protected final String ogrinfoArgsTpl = "-ro $file";
    protected final String polygonExtractArgs =
        "ogr2ogr -progress -simplify 500 --config PG_USE_COPY YES -f PostgreSQL PG:\"host=$pghost port=$pgport dbname=$pgdbname password=$pgpassword user=$pguser\" -lco DIM=2 $file -overwrite -lco OVERWRITE=YES -t_srs \"EPSG:4326\" -a_srs \"EPSG:4326\" -lco SCHEMA=import_tables -lco GEOMETRY_NAME=geom -nln geosearch_import -gt 65536 -nlt PROMOTE_TO_MULTI";

    protected final Path tempPath;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new SpatialIndexTools object.
     */
    public SpatialIndexTools() {
        tempPath = FileSystems.getDefault().getPath(System.getProperty("java.io.tmpdir"), "switchon");
    }

    //~ Methods ----------------------------------------------------------------

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

        final String curlArgs = curlArgsTpl.replace("$url", fileURL.toString());
        final int timeout = 60;
        final ProcessBuilder processBuilder = new ProcessBuilder("curl", curlArgs);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("curl " + curlArgs);
        }
        final Process process = processBuilder.start();
        final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("downloading " + fileURL
                        + " timed out after " + timeout + " seconds.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final Exception processException = new Exception(
                    outputError(process.getInputStream(), process.getErrorStream()));
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

        final int timeout = 30;
        final ProcessBuilder processBuilder = new ProcessBuilder("unzip", unzipArgs);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("unzip " + unzipArgs);
        }
        final Process process = processBuilder.start();
        final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("unzipping 'download.zip' timed out after " + timeout + " seconds.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final Exception processException = new Exception(
                    outputError(process.getInputStream(), process.getErrorStream()));
            throw new ExecutionException("unzipping 'download.zip' failed with exit value " + exitValue,
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
     * @throws  IOException           DOCUMENT ME!
     * @throws  InterruptedException  DOCUMENT ME!
     * @throws  TimeoutException      DOCUMENT ME!
     * @throws  ExecutionException    DOCUMENT ME!
     */
    protected String getFileInfo(final File workingDir, final String file) throws IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException {
        LOGGER.info("getting info of file '" + file + "' in '"
                    + workingDir.getAbsolutePath() + "'");

        final String ogrinfoArgs = ogrinfoArgsTpl.replace("$file", file);
        final int timeout = 6;

        final ProcessBuilder processBuilder = new ProcessBuilder("ogrinfo", ogrinfoArgs);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("ogrinfo " + ogrinfoArgs);
        }
        final Process process = processBuilder.start();
        final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("getting info of file '" + file + "' timed out after " + timeout + " seconds.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final Exception processException = new Exception(
                    outputError(process.getInputStream(), process.getErrorStream()));
            throw new ExecutionException("getting info of file '" + file + "' failed with exit value " + exitValue,
                processException);
        }

        final String[] output = output(process.getInputStream());
        if (output.length == 0) {
            throw new IOException("getting info of file '" + file + "' failed: no info found by ogrinfo");
        }

        final StringBuilder sb = new StringBuilder();
        for (final String line : output) {
            sb.append(line).append(System.getProperty("line.separator"));
        }
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug(sb.toString());
        }
        return sb.toString();
    }

    /**
     * List all files in the working directory that have a specific pattern .
     *
     * @param   workingDir  DOCUMENT ME!
     * @param   extension   DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected File[] listFiles(final File workingDir, final String extension) {
        final File[] files = workingDir.listFiles(new FilenameFilter() {

                    @Override
                    public boolean accept(final File dir, final String name) {
                        return name.toLowerCase().endsWith("." + extension.toLowerCase());
                    }
                });

        return files;
    }

    /**
     * List all files in the working directory that match a specific pattern.
     *
     * @param       workingDir  DOCUMENT ME!
     * @param       pattern     DOCUMENT ME!
     *
     * @return      DOCUMENT ME!
     *
     * @throws      FileNotFoundException  DOCUMENT ME!
     * @throws      IOException            DOCUMENT ME!
     * @throws      InterruptedException   DOCUMENT ME!
     * @throws      TimeoutException       DOCUMENT ME!
     * @throws      ExecutionException     DOCUMENT ME!
     *
     * @depreacted  replaced by platform independent listFiles operation
     */
    protected String[] getFilenames(final File workingDir, final String pattern) throws FileNotFoundException,
        IOException,
        InterruptedException,
        TimeoutException,
        ExecutionException {
        final String lsArgs = lsArgsTpl.replaceAll("$pattern", pattern);
        final int timeout = 6;
        final ProcessBuilder processBuilder = new ProcessBuilder("ls", lsArgs);
        processBuilder.directory(workingDir);
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("ls " + lsArgs);
        }
        final Process process = processBuilder.start();
        final boolean completed = process.waitFor(timeout, TimeUnit.SECONDS);
        if (!completed) {
            process.destroy();
            throw new TimeoutException("getting file names from '"
                        + workingDir.getAbsolutePath() + "' timed out after " + timeout + " seconds.");
        }

        final int exitValue = process.exitValue();
        if (exitValue != 0) {
            final Exception processException = new Exception(
                    outputError(process.getInputStream(), process.getErrorStream()));
            throw new ExecutionException("getting file names from '"
                        + workingDir.getAbsolutePath() + "' failed with exit value " + exitValue,
                processException);
        }

        final String[] output = output(process.getInputStream());
        if (output.length == 0) {
            throw new FileNotFoundException("getting file names from '"
                        + workingDir.getAbsolutePath() + "' did not find any file matching the pattern '"
                        + pattern + "'");
        }

        return output;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  args  DOCUMENT ME!
     */
    public static void main(final String[] args) {
        BasicConfigurator.configure();

        final SpatialIndexTools spatialIndexTools = new SpatialIndexTools();

        try {
            final URL url = new URL("http://dl-ng003.xtr.deltares.nl/downloadallzip/zippeddownload/regulartzt.zip");
            final Path workingPath = spatialIndexTools.tempPath.resolve(String.valueOf(System.currentTimeMillis()));

            final File workingDir = workingPath.toFile();
            workingDir.mkdirs();

            spatialIndexTools.downloadFile(workingDir, url);

            spatialIndexTools.unzipFile(workingDir);

            final String[] filenames = spatialIndexTools.getFilenames(workingDir, "shp");
            if (filenames.length == 0) {
                throw new FileNotFoundException("getting file names from '"
                            + workingDir.getAbsolutePath() + "' did not find any file matching the pattern '*.shp'");
            }

            for (final String filename : filenames) {
                final String fileInfo = spatialIndexTools.getFileInfo(workingDir, filename);
                System.out.println(fileInfo);
            }
        } catch (Throwable t) {
            SpatialIndexTools.LOGGER.fatal(t.getMessage(), t);
            System.exit(1);
        }
    }

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
        sb.append(System.getProperty("line.separator")).append(processErrorStream);

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
}
