/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.PropertyConfigurator;

import java.io.File;

import java.net.URL;

import java.util.Properties;

import static de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools.LOGGER;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
public class ShpImport {

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @param  args  DOCUMENT ME!
     */
    public static void main(final String[] args) {
        final Properties log4jProperties = new Properties();
        log4jProperties.put("log4j.appender.Remote", "org.apache.log4j.net.SocketAppender");
        log4jProperties.put("log4j.appender.Remote.remoteHost", "localhost");
        log4jProperties.put("log4j.appender.Remote.port", "4445");
        log4jProperties.put("log4j.appender.Remote.locationInfo", "true");

        log4jProperties.put("log4j.appender.File", "org.apache.log4j.FileAppender");
        log4jProperties.put("log4j.appender.File.file", "shpImport.log");
        log4jProperties.put("log4j.appender.File.layout", "org.apache.log4j.PatternLayout");
        log4jProperties.put(
            "log4j.appender.File.layout.ConversionPattern",
            "%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n");
        log4jProperties.put("log4j.appender.File.append", "false");

        log4jProperties.put(
            "log4j.logger.de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools",
            "ALL,Remote,File");

        PropertyConfigurator.configure(log4jProperties);

        if (args.length == 0) {
            LOGGER.fatal("first required argument zip file directory is missing, bailing out!");
            System.exit(1);
        } else if (args.length < 2) {
            LOGGER.fatal("2nd required pg password argument is missing, bailing out!");
            System.exit(1);
        }

        try {
            final File zipDir = new File(args[0]);
            final String dbPassword = args[1];
            final String geoserverPassword = (args.length > 2) ? args[2] : null;
            final String host = (args.length > 4) ? args[4] : "http://localhost:3030/";
            final String database = (args.length > 4) ? args[4] : "jdbc:postgresql://127.0.0.1:5432/switchon";
            final String dbUser = (args.length > 5) ? args[5] : "switchon";
            final String geoserverUser = (args.length > 6) ? args[6] : "admin";

            SpatialIndexTools.LOGGER.info("Starting Spatial Index Import with \n "
                        + "zip directory: '" + zipDir.getAbsolutePath() + "'\n "
                        + "database: '" + database + "'\n "
                        + "user: '" + dbUser + "'");

            final SpatialIndexTools spatialIndexTools = new SpatialIndexTools(
                    database,
                    dbUser,
                    dbPassword,
                    geoserverUser,
                    geoserverPassword);

            int i = 0;
            final File[] zipFiles = spatialIndexTools.listSupportedFiles(zipDir, SpatialIndexTools.FileType.ZIP);
            for (final File zipFile : zipFiles) {
                i++;
                try {
                    final String filename = zipFile.getName();
                    final int resourceId = Integer.parseInt(FilenameUtils.removeExtension(filename));
                    final URL downloadUrl = new URL(host + filename);
                    spatialIndexTools.updateSpatialIndex(
                        downloadUrl,
                        resourceId);

                    final String message = "file " + i + "/" + zipFiles.length + "'"
                                + filename + "' successfully imported into " + database + " and published to "
                                + SpatialIndexTools.GEOSERVER_URL;

                    SpatialIndexTools.LOGGER.info(message);
                    System.out.println(message);
                } catch (Throwable t) {
                    SpatialIndexTools.LOGGER.error("Processing file " + i + "/" + zipFiles.length
                                + "'" + zipFile + "' failed:" + t.getMessage(),
                        t);
                }
            }
        } catch (Throwable t) {
            SpatialIndexTools.LOGGER.fatal(t.getMessage(), t);
            System.exit(1);
        }
    }
}
