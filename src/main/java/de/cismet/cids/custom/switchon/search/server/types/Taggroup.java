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
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
public class Taggroup implements Serializable, Cloneable, Comparable<Taggroup> {

    //~ Instance fields --------------------------------------------------------

    @JacksonXmlProperty private int id;

    @JacksonXmlProperty private String description;

    @JacksonXmlProperty private String name;

    //~ Constructors -----------------------------------------------------------

    /**
     * Copy-Constructor.
     *
     * @param  taggroup  tag DOCUMENT ME!
     */
    public Taggroup(final Taggroup taggroup) {
        this();
        this.id = taggroup.id;
        this.name = taggroup.name;
        this.description = taggroup.description;
    }

    //~ Methods ----------------------------------------------------------------

    @Override
    public int compareTo(final Taggroup taggroup) {
        return this.getName().compareTo(taggroup.getName());
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
        final Taggroup other = (Taggroup)obj;

        if (!Objects.equals(this.id, other.id)) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = (29 * hash) + Objects.hashCode(this.id);
        hash = (29 * hash) + Objects.hashCode(this.name);
        return hash;
    }

    @Override
    public Taggroup clone() throws CloneNotSupportedException {
        return new Taggroup(this);
    }
}
