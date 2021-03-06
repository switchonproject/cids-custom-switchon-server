/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import org.openide.util.Exceptions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Properties;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé <pascal.dihe@cismet.de>
 * @version  $Revision$, $Date$
 */
public class CleanupTools {

    //~ Static fields/initializers ---------------------------------------------

    protected static final Logger LOGGER = Logger.getLogger(CleanupTools.class);

    //~ Instance fields --------------------------------------------------------

    protected final String deleteRelationshipMetadataTagReferencesTpl = "DELETE\n"
                + "FROM jt_metadata_tag\n"
                + "WHERE metadata_reference IN\n"
                + "    ( SELECT id\n"
                + "     FROM \"public\".metadata\n"
                + "     WHERE \"type\" =\n"
                + "         (SELECT id\n"
                + "          FROM \"public\".tag\n"
                + "          WHERE name = 'relationship meta-data' LIMIT 1)\n"
                + "       AND id IN\n"
                + "         (SELECT metadataid\n"
                + "          FROM \"public\".jt_metadata_relationship\n"
                + "          WHERE relationship_reference IN\n"
                + "              (SELECT id\n"
                + "               FROM \"public\".relationship\n"
                + "               WHERE toresource = ?)))";

    protected final String deleteRelationshipMetadataTpl = "DELETE\n"
                + "FROM \"public\".metadata\n"
                + "WHERE \"type\" =\n"
                + "    (SELECT id\n"
                + "     FROM \"public\".tag\n"
                + "     WHERE name = 'relationship meta-data' LIMIT 1)\n"
                + "  AND id IN\n"
                + "    (SELECT metadataid\n"
                + "     FROM \"public\".jt_metadata_relationship\n"
                + "     WHERE relationship_reference IN\n"
                + "         (SELECT id\n"
                + "          FROM \"public\".relationship\n"
                + "          WHERE toresource = ?))";

    protected final String deleteRelationshipMetadataReferenceTpl = "DELETE\n"
                + "FROM \"public\".jt_metadata_relationship\n"
                + "WHERE relationship_reference IN\n"
                + "    (SELECT id\n"
                + "     FROM \"public\".relationship\n"
                + "     WHERE toresource = ?)";

    protected final String deleteRelationshipResourceReferenceTpl = "DELETE\n"
                + "FROM \"public\".jt_fromresource_relationship\n"
                + "WHERE resourceid = ?";

    protected final String deleteRelationshipResourceReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_fromresource_relationship\n"
                + "WHERE relationship_reference IN\n"
                + "    (SELECT id\n"
                + "     FROM \"public\".relationship\n"
                + "     WHERE toresource = ?)";

    protected final String deleteRelationshipTagReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_relationship_tag\n"
                + "WHERE relationship_reference IN\n"
                + "    (SELECT id\n"
                + "     FROM \"public\".relationship\n"
                + "     WHERE toresource = ?)";

    protected final String deleteRelationshipTpl = "DELETE\n"
                + "FROM \"public\".relationship\n"
                + "WHERE toresource = ?";

    protected final String deleteResourceMetadataTpl = "DELETE\n"
                + "FROM \"public\".metadata\n"
                + "WHERE id IN\n"
                + "    (SELECT DISTINCT metadataid\n"
                + "     FROM \"public\".jt_metadata_resource\n"
                + "     WHERE metadataid IN\n"
                + "         (SELECT DISTINCT metadataid\n"
                + "          FROM \"public\".jt_metadata_resource\n"
                + "          WHERE resource_reference = ?)\n"
                + "     GROUP BY metadataid HAVING count(resource_reference) < 2)";

    protected final String deleteResourceMetadataTagReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_metadata_tag\n"
                + "WHERE metadata_reference IN\n"
                + "    (SELECT DISTINCT metadataid\n"
                + "     FROM \"public\".jt_metadata_resource\n"
                + "     WHERE metadataid IN\n"
                + "         (SELECT DISTINCT metadataid\n"
                + "          FROM \"public\".jt_metadata_resource\n"
                + "          WHERE resource_reference = ?)\n"
                + "     GROUP BY metadataid HAVING count(resource_reference) < 2)";

    protected final String deleteResourceMetadataReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_metadata_resource\n"
                + "WHERE resource_reference = ?";

    protected final String deleteResourceRepresentationTpl = "DELETE\n"
                + "FROM \"public\".representation\n"
                + "WHERE id IN\n"
                + "    (SELECT representationid\n"
                + "     FROM \"public\".jt_resource_representation\n"
                + "     WHERE resource_reference = ?)";

    protected final String deleteResourceRepresentationTagReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_representation_tag\n"
                + "WHERE representation_reference IN\n"
                + "    (SELECT representationid\n"
                + "     FROM \"public\".jt_resource_representation\n"
                + "     WHERE resource_reference = ?)";

    protected final String deleteResourceRepresentationReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_resource_representation\n"
                + "WHERE resource_reference = ?";

    protected final String deleteResourceSearchGeometriesTpl = "DELETE\n"
                + "FROM \"public\".geom_search\n"
                + "WHERE resource = ?";

    protected final String deleteResourceGeometryTpl = "DELETE\n"
                + "FROM \"public\".geom\n"
                + "WHERE id IN\n"
                + "    (SELECT spatialcoverage\n"
                + "     FROM \"public\".resource\n"
                + "     WHERE id = ?)";

    protected final String deleteResourceTagReferencesTpl = "DELETE\n"
                + "FROM \"public\".jt_resource_tag\n"
                + "WHERE resource_reference  = ?";

    protected final PreparedStatement deleteRelationshipMetadataTagReferencesStatement;
    protected final PreparedStatement deleteRelationshipMetadataStatement;
    protected final PreparedStatement deleteRelationshipMetadataReferenceStatement;
    protected final PreparedStatement deleteRelationshipResourceReferenceStatement;
    protected final PreparedStatement deleteRelationshipResourceReferencesStatement;
    protected final PreparedStatement deleteRelationshipTagReferencesStatement;
    protected final PreparedStatement deleteRelationshipStatement;

    protected final PreparedStatement deleteResourceMetadataStatement;
    protected final PreparedStatement deleteResourceMetadataTagReferencesStatement;
    protected final PreparedStatement deleteResourceMetadataReferencesStatement;

    protected final PreparedStatement deleteResourceRepresentationStatement;
    protected final PreparedStatement deleteResourceRepresentationTagReferencesStatement;
    protected final PreparedStatement deleteResourceRepresentationReferencesStatement;

    protected final PreparedStatement deleteResourceSearchGeometriesStatement;
    protected final PreparedStatement deleteResourceGeometryStatement;

    protected final PreparedStatement deleteResourceTagReferencesStatement;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new CleanupTools object.
     *
     * @param   connection  DOCUMENT ME!
     *
     * @throws  SQLException  DOCUMENT ME!
     */
    public CleanupTools(final Connection connection) throws SQLException {
        this.deleteRelationshipMetadataTagReferencesStatement = connection.prepareStatement(
                deleteRelationshipMetadataTagReferencesTpl);
        this.deleteRelationshipMetadataStatement = connection.prepareStatement(deleteRelationshipMetadataTpl);
        this.deleteRelationshipMetadataReferenceStatement = connection.prepareStatement(
                deleteRelationshipMetadataReferenceTpl);
        this.deleteRelationshipResourceReferencesStatement = connection.prepareStatement(
                deleteRelationshipResourceReferencesTpl);
        this.deleteRelationshipResourceReferenceStatement = connection.prepareStatement(
                deleteRelationshipResourceReferenceTpl);
        this.deleteRelationshipTagReferencesStatement = connection.prepareStatement(deleteRelationshipTagReferencesTpl);
        this.deleteRelationshipStatement = connection.prepareStatement(deleteRelationshipTpl);

        this.deleteResourceMetadataStatement = connection.prepareStatement(deleteResourceMetadataTpl);
        this.deleteResourceMetadataTagReferencesStatement = connection.prepareStatement(
                deleteResourceMetadataTagReferencesTpl);
        this.deleteResourceMetadataReferencesStatement = connection.prepareStatement(
                deleteResourceMetadataReferencesTpl);

        this.deleteResourceRepresentationStatement = connection.prepareStatement(deleteResourceRepresentationTpl);
        this.deleteResourceRepresentationTagReferencesStatement = connection.prepareStatement(
                deleteResourceRepresentationTagReferencesTpl);
        this.deleteResourceRepresentationReferencesStatement = connection.prepareStatement(
                deleteResourceRepresentationReferencesTpl);

        this.deleteResourceSearchGeometriesStatement = connection.prepareStatement(
                deleteResourceSearchGeometriesTpl);
        this.deleteResourceGeometryStatement = connection.prepareStatement(
                deleteResourceGeometryTpl);

        this.deleteResourceTagReferencesStatement = connection.prepareStatement(deleteResourceTagReferencesTpl);
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public synchronized int cleanupResource(final int resourceId) {
        final long currentTime = System.currentTimeMillis();

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("cleaning oprhanened entities of resource with id " + resourceId);
        }

        int result = 0;

        result += this.deleteRelationshipMetadataTagReferences(resourceId);
        result += this.deleteRelationshipMetadata(resourceId);
        result += this.deleteRelationshipMetadataReference(resourceId);
        result += this.deleteRelationshipResourceReference(resourceId);
        result += this.deleteRelationshipResourceReferences(resourceId);
        result += this.deleteRelationshipTagReferences(resourceId);
        result += this.deleteRelationship(resourceId);

        result += this.deleteResourceMetadata(resourceId);
        result += this.deleteResourceMetadataTagReferences(resourceId);
        result += this.deleteResourceMetadataReferences(resourceId);

        result += this.deleteResourceRepresentation(resourceId);
        result += this.deleteResourceRepresentationTagReferences(resourceId);
        result += this.deleteResourceRepresentationReferences(resourceId);

        result += this.deleteResourceGeometry(resourceId);
        result += this.deleteResourceSearchGeometries(resourceId);

        result += this.deleteResourceTagReferences(resourceId);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.info(result + " oprhanened entities of resource with id "
                        + resourceId + " cleaned in " + (System.currentTimeMillis() - currentTime)
                        + " ms.");
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipMetadataTagReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Relationship Metadata Tag References for Resource with id " + resourceId);
            }
            this.deleteRelationshipMetadataTagReferencesStatement.setInt(1, resourceId);
            result = this.deleteRelationshipMetadataTagReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Metadata Tag References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Metadata Tag References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete Relationship Metadata if the target resource (toresource) of the reletionship has been deleted.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipMetadata(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Relationship Metadata for Resource with id " + resourceId);
            }
            this.deleteRelationshipMetadataStatement.setInt(1, resourceId);
            result = this.deleteRelationshipMetadataStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Metadata records deleted for Resource with id " + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Metadata for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete the Relationship Meta Data Reference a if the target resource (toresource) of the Relationship has been
     * deleted.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipMetadataReference(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Relationship Metadata Reference for Resource with id " + resourceId);
            }
            this.deleteRelationshipMetadataReferenceStatement.setInt(1, resourceId);
            result = this.deleteRelationshipMetadataReferenceStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Metadata Reference records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Metadata Reference for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete <strong>all</strong> Relationship Resource References a if the target resource (toresource) of the
     * Relationship has been deleted.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipResourceReference(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Relationship Resource Reference for Resource with id " + resourceId);
            }
            this.deleteRelationshipResourceReferenceStatement.setInt(1, resourceId);
            result = this.deleteRelationshipResourceReferenceStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Relationship Reference records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Relationship Reference for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipResourceReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting all Relationship Resource References for Resource with id " + resourceId);
            }
            this.deleteRelationshipResourceReferencesStatement.setInt(1, resourceId);
            result = this.deleteRelationshipResourceReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Resource References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Resource References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationshipTagReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting all Relationship Tag References for Resource with id " + resourceId);
            }
            this.deleteRelationshipTagReferencesStatement.setInt(1, resourceId);
            result = this.deleteRelationshipTagReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship Tag References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship Resource References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete the Relationship if the target resource (toresource) of the Relationship has been deleted.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteRelationship(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Relationship for Resource with id " + resourceId);
            }
            this.deleteRelationshipStatement.setInt(1, resourceId);
            result = this.deleteRelationshipStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Relationship records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Relationship for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete Metadata record(s) of the resource if and only if the metadata record is not associated with any other
     * resource.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceMetadata(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Metadata for Resource with id " + resourceId);
            }
            this.deleteResourceMetadataStatement.setInt(1, resourceId);
            result = this.deleteResourceMetadataStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Metadata records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Metadata for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceMetadataTagReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Metadata Tag References for Resource with id " + resourceId);
            }
            this.deleteResourceMetadataTagReferencesStatement.setInt(1, resourceId);
            result = this.deleteResourceMetadataTagReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Metadata Tag References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Metadata Tag References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceMetadataReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Metadata References for Resource with id " + resourceId);
            }
            this.deleteResourceMetadataReferencesStatement.setInt(1, resourceId);
            result = this.deleteResourceMetadataReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Metadata References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Metadata Tag References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * Delete Representation record(s) of the resource if and only if the metadata record is not associated with any
     * other resource.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceRepresentation(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Representation for Resource with id " + resourceId);
            }
            this.deleteResourceRepresentationStatement.setInt(1, resourceId);
            result = this.deleteResourceRepresentationStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Representation records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Representation for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceRepresentationTagReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Representation Tag References for Resource with id " + resourceId);
            }
            this.deleteResourceRepresentationTagReferencesStatement.setInt(1, resourceId);
            result = this.deleteResourceRepresentationTagReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Representation Tag References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Representation Tag References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceRepresentationReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Representation References for Resource with id " + resourceId);
            }
            this.deleteResourceRepresentationReferencesStatement.setInt(1, resourceId);
            result = this.deleteResourceRepresentationReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Representation References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Representation References for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceSearchGeometries(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Searc hGeometries for Resource with id " + resourceId);
            }
            this.deleteResourceSearchGeometriesStatement.setInt(1, resourceId);
            result = this.deleteResourceSearchGeometriesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Search Geometries records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Search Geometries for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceGeometry(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Geometry for Resource with id " + resourceId);
            }
            this.deleteResourceGeometryStatement.setInt(1, resourceId);
            result = this.deleteResourceGeometryStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Geometry records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource Geometry for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected int deleteResourceTagReferences(final int resourceId) {
        int result = 0;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting all Resource Tag References for Resource with id " + resourceId);
            }
            this.deleteResourceTagReferencesStatement.setInt(1, resourceId);
            result = this.deleteResourceTagReferencesStatement.executeUpdate();
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug(result + "  Resource Tag References records deleted for Resource with id "
                            + resourceId);
            }
        } catch (SQLException ex) {
            LOGGER.error("could not delete Resource TagReferences for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param  args  DOCUMENT ME!
     */
    public static void main(final String[] args) {
        try {
            final Properties log4jProperties = new Properties();
            log4jProperties.put("log4j.appender.Remote", "org.apache.log4j.net.SocketAppender");
            log4jProperties.put("log4j.appender.Remote.remoteHost", "localhost");
            log4jProperties.put("log4j.appender.Remote.port", "4445");
            log4jProperties.put("log4j.appender.Remote.locationInfo", "true");
            log4jProperties.put("log4j.rootLogger", "ALL,Remote");
            PropertyConfigurator.configure(log4jProperties);

            if (args.length == 0) {
                LOGGER.fatal("first required pg password argument is missing, bailing out!");
                System.exit(1);
            }

            final String dbPassword = args[0];
            final String jdbcUrl = (args.length > 1) ? args[1] : "jdbc:postgresql://127.0.0.1:5432/switchon_dev";
            final String dbUser = (args.length > 2) ? args[2] : "switchon";

            final String selectResourcesTpl = "SELECT resource.id, resource.name\n"
                        + "    FROM \n"
                        + "    resource\n"
                        + "    WHERE collection = (SELECT DISTINCT tag.id      \n"
                        + "            FROM tag      \n"
                        + "            WHERE tag.name ILIKE 'NTSG - AE_Land3'           \n"
                        + "                AND tag.taggroup IN \n"
                        + "                (SELECT id FROM taggroup WHERE name ILIKE 'collection' ) limit 1)\n"
                        + "  GROUP BY\n"
                        + "    resource.id, resource.name\n"
                        + "    ORDER BY resource.id ASC";

            final String deleteResourceTpl = "DELETE from resource where id = ?";

            final Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            final CleanupTools cleanupTools = new CleanupTools(connection);

            final PreparedStatement deleteResourcesStatement = connection.prepareStatement(deleteResourceTpl);
            final Statement selectResourcesStatement = connection.createStatement();
            final ResultSet resultSet = selectResourcesStatement.executeQuery(selectResourcesTpl);

            int i = 0;
            while (resultSet.next()) {
                final int resourceId = resultSet.getInt(1);
                cleanupTools.cleanupResource(resourceId);
                deleteResourcesStatement.setInt(1, resourceId);
                deleteResourcesStatement.executeUpdate();
                i++;
            }

            LOGGER.info("resources and orphanded entities of " + i + " resources successfully removed from db '"
                        + jdbcUrl + "'");
            resultSet.close();
            selectResourcesStatement.close();

            connection.close();
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage(), ex);
            System.exit(1);
        }
    }
}
