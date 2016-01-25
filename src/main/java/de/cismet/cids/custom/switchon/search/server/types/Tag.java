/***************************************************
*
* cismet GmbH, Saarbruecken, Germany
*
*              ... and it just works.
*
****************************************************/
package de.cismet.cids.custom.switchon.search.server.types;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

import java.util.Objects;

/**
 * DOCUMENT ME!
 *
 * @author   Pascal Dihé
 * @version  $Revision$, $Date$
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@JacksonXmlRootElement
public class Tag implements Serializable, Cloneable, Comparable<Tag> {

    //~ Instance fields --------------------------------------------------------

    @JacksonXmlProperty private int id;

    @JacksonXmlProperty private String name;

    @JacksonXmlProperty private String description;

    @JacksonXmlProperty private Taggroup taggroup;

    //~ Constructors -----------------------------------------------------------

    /**
     * Copy-Constructor.
     *
     * @param  tag  DOCUMENT ME!
     */
    public Tag(final Tag tag) {
        this();
        this.id = tag.id;
        this.name = tag.name;
        this.description = tag.description;
        this.taggroup = taggroup;
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public int compareTo(final Tag tag) {
        return this.getName().compareTo(tag.getName());
    }

    @Override
    public String toString() {
        return this.getName();
    }

    @Override
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (!this.getClass().isAssignableFrom(obj.getClass())) {
            return false;
        }
        final Tag other = (Tag)obj;

        if (!Objects.equals(this.id, other.id)) {
            return false;
        }

        if (!Objects.equals(this.taggroup, other.taggroup)) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = (29 * hash) + Objects.hashCode(this.id);
        hash = (29 * hash) + Objects.hashCode(this.name);
        hash = (29 * hash) + this.taggroup.hashCode();
        return hash;
    }

    @Override
    public Tag clone() throws CloneNotSupportedException {
        return new Tag(this);
    }
}
