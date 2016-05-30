/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.actions;

import Sirius.server.middleware.impls.domainserver.DomainServerImpl;
import Sirius.server.sql.DBConnectionPool;

import org.apache.log4j.Logger;

import java.io.ByteArrayOutputStream;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import de.cismet.cids.server.actions.ServerAction;
import de.cismet.cids.server.actions.ServerActionParameter;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
@org.openide.util.lookup.ServiceProvider(service = ServerAction.class)
public class CsvExportAction implements ServerAction {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(CsvExportAction.class);

    //~ Instance fields --------------------------------------------------------

    private final transient String exportQuery = "SELECT title as name,\n"
                + "       abstract as description,\n"
                + "       topiccategory,\n"
                + "       keywords,\n"
                + "       wkt_geometry as spatialextent,\n"
                + "       conditionapplyingtoaccessanduse AS license,\n"
                + "       substring(links FROM '.*,+(.*$)') AS link\n"
                + "FROM pycsw.data_table order by title ASC;";

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new CsvExportAction object.
     */
    public CsvExportAction() {
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public Object execute(final Object body, final ServerActionParameter... params) {
        LOG.info("exporting Meta-Data Repository with query: \n" + this.exportQuery);

        boolean zip = false;
        if (params.length > 0) {
            if ((params[0].getKey() != null) && (params[0].getValue() != null)
                        && params[0].getKey().equalsIgnoreCase("zip")) {
                zip = Boolean.valueOf(params[0].getValue().toString());
            }
        } else {
            if (LOG.isDebugEnabled()) {
                LOG.debug("no action parameters provided");
            }
        }

        try {
            final DBConnectionPool connectionPool = DomainServerImpl.getServerInstance().getConnectionPool();
            final Statement statement = connectionPool.getDBConnection().getConnection().createStatement();

            final ResultSet resultSet = statement.executeQuery(this.exportQuery);
            final ResultSetMetaData metaData = resultSet.getMetaData();
            final StringBuilder csvBuilder = new StringBuilder();

            final int columnCount = metaData.getColumnCount();

            for (int i = 1; i <= columnCount; i++) {
                final String columnName = metaData.getColumnName(i);
                csvBuilder.append(columnName);
                if (i < columnCount) {
                    csvBuilder.append(", ");
                }
            }
            if (LOG.isDebugEnabled()) {
                LOG.debug("CSV Header: " + csvBuilder.toString());
            }
            csvBuilder.append(System.getProperty("line.separator"));

            int numResults = 0;
            while (resultSet.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    final String value = resultSet.getString(i);
                    if ((value != null) && (value.length() > 0)) {
                        csvBuilder.append('\"');
                        csvBuilder.append(value.replace('\"', '\'').replace('\n', ' '));
                        csvBuilder.append('\"');
                    }
                    if (i < columnCount) {
                        csvBuilder.append(", ");
                    }
                }
                csvBuilder.append(System.getProperty("line.separator"));
                numResults++;
            }

            LOG.info(numResults + " resources exported from Meta-Data Repository");
            resultSet.close();

            if (zip) {
                if (LOG.isDebugEnabled()) {
                    LOG.debug("zipping output");
                }
                final ByteArrayOutputStream output = new ByteArrayOutputStream();
                final ZipOutputStream zipStream = new ZipOutputStream(output);
                zipStream.putNextEntry(new ZipEntry("switchon-meta-data-repository.csv"));
                zipStream.write(csvBuilder.toString().getBytes("UTF-8"));
                zipStream.closeEntry();
                zipStream.close();

                return output.toByteArray();
            } else {
                return csvBuilder.toString();
            }
        } catch (Exception ex) {
            LOG.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        }
    }

    @Override
    public String getTaskName() {
        return "csvExportAction";
    }
}
