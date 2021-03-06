/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import org.apache.log4j.PropertyConfigurator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.File;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;

import static de.cismet.cids.custom.switchon.utils.server.SpatialIndexTools.LOGGER;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
public class ResourceCopy {

    //~ Static fields/initializers ---------------------------------------------

    private static final int NAME_RESOURCE_CELL = 1;
    private static final int TARGET_RESOURCE_CELL = 2;
    private static final int SOURCE_RESOURCE_CELL = 3;

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
        log4jProperties.put("log4j.appender.File.file", "resourceCopy.log");
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
            LOGGER.fatal("first required argument XSLX File is missing, bailing out!");
            System.exit(1);
        } else if (args.length < 1) {
            LOGGER.fatal("2nd required pg password argument is missing, bailing out!");
            System.exit(1);
        }

        try {
            final LinkedHashMap<Integer, List<Integer>> resourcesMap = new LinkedHashMap<Integer, List<Integer>>();

            final File xslxFile = new File(args[0]);
            final String dbPassword = args[1];
            final String database = (args.length > 2) ? args[2] : "jdbc:postgresql://127.0.0.1:5432/switchon";
            final String dbUser = (args.length > 3) ? args[3] : "switchon";

            SpatialIndexTools.LOGGER.info("Starting Spatial Index Copy with \n "
                        + "mapping file: '" + xslxFile.getAbsolutePath() + "'\n "
                        + "database: '" + database + "'\n "
                        + "user: '" + dbUser + "'");

            final SpatialIndexTools spatialIndexTools = new SpatialIndexTools(
                    database,
                    dbUser,
                    dbPassword,
                    null,
                    null);

            final Workbook workbook = WorkbookFactory.create(xslxFile);
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("reading XLS sheet '" + workbook.getSheetName(0)
                            + "' from workbook with " + workbook.getNumberOfSheets() + " sheets");
            }
            final Sheet resourcesSheet = workbook.getSheetAt(0);

            final int rows = resourcesSheet.getLastRowNum() + 1;
            LOGGER.info("processing resources from XLS Sheet " + resourcesSheet.getSheetName()
                        + " with " + rows + " rows.");

            short rowIdx = 0;
            final Iterator<Row> rowIterator = resourcesSheet.rowIterator();
            while (rowIterator.hasNext()) {
                try {
                    final Row row = rowIterator.next();
                    ++rowIdx;

                    if (rowIdx > 1) {
                        final String targetResourceName = row.getCell(NAME_RESOURCE_CELL).getStringCellValue();
                        final int targetResourceId = ((Double)row.getCell(TARGET_RESOURCE_CELL).getNumericCellValue())
                                    .intValue();
                        final int sourceResourceId = ((Double)row.getCell(SOURCE_RESOURCE_CELL).getNumericCellValue())
                                    .intValue();

                        if ((targetResourceId > 0) && (sourceResourceId > 0)) {
                            final List<Integer> targetResourceIds;
                            if (resourcesMap.containsKey(sourceResourceId)) {
                                targetResourceIds = resourcesMap.get(sourceResourceId);
                            } else {
                                targetResourceIds = new LinkedList<Integer>();
                                resourcesMap.put(sourceResourceId, targetResourceIds);
                            }

                            targetResourceIds.add(targetResourceId);
                            if (LOGGER.isDebugEnabled()) {
                                LOGGER.debug("target resource #" + rowIdx + " with id '" + targetResourceId
                                            + "' (" + targetResourceName + ") maps to source resource with id '"
                                            + sourceResourceId + "'");
                            }
                        } else {
                            LOGGER.warn("ignoring empty row #" + rowIdx + " in " + xslxFile.getName());
                        }
                    }
                } catch (Throwable t) {
                    LOGGER.error("could not process row " + rowIdx
                                + " due to error: " + t.getMessage(), t);
                }
            }

            int copyCount = 0;
            for (final Entry<Integer, List<Integer>> entry : resourcesMap.entrySet()) {
                final int sourceResourceId = entry.getKey();
                final List<Integer> targetResourceIds = entry.getValue();

                // remove self reference
                final int index = targetResourceIds.indexOf(sourceResourceId);
                if (index != -1) {
                    targetResourceIds.remove(index);
                }

                if (!targetResourceIds.isEmpty()) {
                    for (final int targetResourceId : targetResourceIds) {
                        try {
                            // copy representatrion
                            final int sourceRepresentationId = spatialIndexTools.copyResourceRepresentation(
                                    sourceResourceId,
                                    targetResourceId);
                            // final int sourceRepresentationId = -1;

                            // copy geometry
                            spatialIndexTools.copyResourceGeometry(sourceResourceId, targetResourceId);

                            copyCount++;

                            final String message = "target resource with id '" + targetResourceId
                                        + "' successfully updated with source representation with id '"
                                        + sourceRepresentationId
                                        + "' from source resource with id '" + sourceResourceId + "'";
                            LOGGER.info(message);
                            System.out.println(message);
                        } catch (Throwable t) {
                            SpatialIndexTools.LOGGER.fatal("could not copy source resource with id '"
                                        + sourceResourceId + "' to target resource with id '" + targetResourceId
                                        + "': " + t.getMessage(),
                                t);
                        }
                    }
                } else {
                    if (LOGGER.isDebugEnabled()) {
                        LOGGER.warn("ignoring equal target / source resource with id '"
                                    + sourceResourceId + "'");
                    }
                }
            }

            final String message = copyCount + " representations copied as defined in mapping file "
                        + xslxFile.getName() + "'";

            SpatialIndexTools.LOGGER.info(message);
            // System.out.println(message);
        } catch (Throwable t) {
            SpatialIndexTools.LOGGER.fatal(t.getMessage(), t);
            System.exit(1);
        }
    }
}
