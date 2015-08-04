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

import de.cismet.cids.server.actions.ServerActionParameter;
import de.cismet.cidsx.base.types.MediaTypes;
import de.cismet.cidsx.base.types.Type;
import de.cismet.cidsx.server.actions.RestApiCidsServerAction;
import de.cismet.cidsx.server.api.types.ActionInfo;
import de.cismet.cidsx.server.api.types.GenericResourceWithContentType;
import de.cismet.cidsx.server.api.types.ActionParameterInfo;
import java.net.URL;
import java.nio.file.attribute.FileTime;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.zip.CRC32;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
@org.openide.util.lookup.ServiceProvider(service = RestApiCidsServerAction.class)
public class CsvExportAction implements RestApiCidsServerAction {

    //~ Static fields/initializers ---------------------------------------------

    private static final Logger LOG = Logger.getLogger(CsvExportAction.class);
    
    public static final String TASK_NAME = "csvExportAction";
    
    private final ActionInfo actionInfo;
    
    public enum PARAMETER_TYPE {
        ZIP
    }


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
        
        actionInfo = new ActionInfo();
        actionInfo.setName("Meta-Data Repository CSV Export");
        actionInfo.setActionKey(TASK_NAME);
        actionInfo.setDescription("Export the SWITCH-ON Meta-Data Repository as (zipped) CSV File.");

        final List<ActionParameterInfo> parameterDescriptions = new LinkedList<ActionParameterInfo>();
        ActionParameterInfo parameterDescription;

        parameterDescription = new ActionParameterInfo();
        parameterDescription.setKey(PARAMETER_TYPE.ZIP.name());
        parameterDescription.setType(Type.BOOLEAN);
        parameterDescription.setDescription("ZIP the CSV File (true or false)");
        parameterDescriptions.add(parameterDescription);
        actionInfo.setParameterDescription(parameterDescriptions);
        
        final ActionParameterInfo returnDescription = new ActionParameterInfo();
        returnDescription.setKey("return");
        returnDescription.setType(Type.STRING);
        returnDescription.setMediaType(MediaTypes.TEXT_CSV);
        returnDescription.setDescription("(Zipped) CSV File");
        actionInfo.setResultDescription(returnDescription);
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public GenericResourceWithContentType execute(final Object body, final ServerActionParameter... params) {
        LOG.info("exporting Meta-Data Repository with query: \n" + this.exportQuery);

        boolean zip = false;
        if (params.length > 0) {
            if ((params[0].getKey() != null) && (params[0].getValue() != null)
                        && params[0].getKey().equalsIgnoreCase(PARAMETER_TYPE.ZIP.name())) {
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
                final String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                
                final byte[] csv = csvBuilder.toString().getBytes("UTF-8");
                final CRC32 crc = new CRC32();
                crc.update(csv);
                
                final ZipEntry zipEntry = new ZipEntry("switchon-meta-data-repository-" 
                        + dateString + ".csv");
                zipEntry.setLastModifiedTime(FileTime.fromMillis(System.currentTimeMillis()));
                zipEntry.setTime(System.currentTimeMillis());
                zipEntry.setSize(csv.length);
                zipEntry.setCrc(crc.getValue());
               
                zipStream.putNextEntry(zipEntry);
                zipStream.write(csv);
                zipStream.closeEntry();
                zipStream.close();

                final byte[] zippedCsv = output.toByteArray();
                return new GenericResourceWithContentType(MediaTypes.APPLICATION_ZIP, zippedCsv);  
            } else {
                final String csv = csvBuilder.toString();
                return new GenericResourceWithContentType(MediaTypes.TEXT_CSV, csv);  
            }
        } catch (Exception ex) {
            LOG.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        }
    }

    @Override
    public String getTaskName() {
        return TASK_NAME;
    }
    
    @Override
    public ActionInfo getActionInfo() {
        return this.actionInfo;
    }
}
