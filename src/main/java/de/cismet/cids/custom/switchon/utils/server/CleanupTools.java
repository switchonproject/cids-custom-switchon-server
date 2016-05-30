/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.cismet.cids.custom.switchon.utils.server;

import Sirius.server.sql.DBConnection;

import org.apache.log4j.Logger;

import org.openide.util.Exceptions;

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

    protected final PreparedStatement deleteRelationshipMetadataStatement;
    protected final PreparedStatement deleteRelationshipMetadataReferenceStatement;

    //~ Constructors -----------------------------------------------------------

    /**
     * Creates a new CleanupTools object.
     *
     * @param   connection  DOCUMENT ME!
     *
     * @throws  SQLException  DOCUMENT ME!
     */
    public CleanupTools(final Connection connection) throws SQLException {
        this.deleteRelationshipMetadataStatement = connection.prepareStatement(deleteRelationshipMetadataTpl);

        this.deleteRelationshipMetadataReferenceStatement = connection.prepareStatement(
                deleteRelationshipMetadataReferenceTpl);
    }

    //~ Methods ----------------------------------------------------------------

    /**
     * Delete Relationship Metadata if the target resource (toresource) of the reletionship has been deleted.
     *
     * @param   resourceId  DOCUMENT ME!
     *
     * @return  DOCUMENT ME!
     */
    protected synchronized int deleteRelationshipMetadata(final int resourceId) {
        int result = -1;
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
     * DOCUMENT ME!
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
            LOGGER.error("could not delete Relationship Reference Metadata for Resource with id "
                        + resourceId + ": " + ex.getMessage(),
                ex);
        }

        return result;
    }
}
