/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.utils.server;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    public int cleanupResource(final int resourceId) {
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

        return result;
    }

    /**
     * DOCUMENT ME!
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    synchronized int deleteRelationshipMetadataTagReferences(final int resourceId) {
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
    protected synchronized int deleteRelationshipMetadata(final int resourceId) {
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
    protected synchronized int deleteRelationshipMetadataReference(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteRelationshipResourceReference(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteRelationshipResourceReferences(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteRelationshipTagReferences(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteRelationship(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteResourceMetadata(final int resourceId) {
        int result = -1;
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("deleting Resource Metadata for Resource with id " + resourceId);
            }
            this.deleteRelationshipMetadataStatement.setInt(1, resourceId);
            result = this.deleteRelationshipMetadataStatement.executeUpdate();
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
    protected synchronized int deleteResourceMetadataTagReferences(final int resourceId) {
        int result = -1;
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
    protected synchronized int deleteResourceMetadataReferences(final int resourceId) {
        int result = -1;
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
}
