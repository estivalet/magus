<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

<#list allColumns as column><#t>
<#if column.getTypeName() = 'java.sql.Date'>
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.luisoft.commons.xml.SqlDateAdapter;
<#break>
</#if>
</#list>

@SuppressWarnings("serial")
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class ${clazz.getAlias(true)} implements Serializable, Cloneable {
    
    <#list allColumns as column><#t>
    /** comment here. */
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    
    </#list>
    
    /**
     * Empty constructor needed by JAXB to serialize to XML.
     */
    public ${clazz.getAlias(true)}() {
    
    }

    <#list allColumns as column><#t>
    /**
     * @param ${column.getCamelCaseName()}
     *            the ${column.getCamelCaseName()} to set.
     */
    public void set${column.getAlias()?cap_first}(${column.getTypeName()} ${column.getCamelCaseName()}) {
        this.${column.getAlias()} = ${column.getCamelCaseName()};
    }

    /**
     * @return the ${column.getCamelCaseName()}
     */
    <#if column.getTypeName() = 'java.sql.Date'> 
    @XmlJavaTypeAdapter(SqlDateAdapter.class)
    </#if>
    public ${column.getTypeName()} get${column.getAlias()?cap_first}() {
        return this.${column.getAlias()};
    }
    </#list>
    

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        <#list allColumns as column><#t>
        result = prime * result + ((${column.getAlias()} == null) ? 0 : ${column.getAlias()}.hashCode());
        </#list>
        return result;
    }
    
    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (!(obj instanceof ${clazz.getAlias(true)})) {
            return false;
        }
        ${clazz.getAlias(true)} other = (${clazz.getAlias(true)}) obj;
        <#list allColumns as column><#t>
        if (${column.getAlias()} == null) {
            if (other.${column.getAlias()} != null) {
                return false;
            }
        } else if (!${column.getAlias()}.equals(other.${column.getAlias()})) {
            return false;
        }
        </#list>
        return true;
    }
    
    public String toXML() {
        String xml = "<${clazz.getAlias(true)?uncap_first}>";
        <#list allColumns as column><#t>
        <#if (column.isColumnInForeignKey())>
        <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
        xml += "<${column.getAlias()}><![CDATA[" + ${column.getForeignTableAlias()}.get${.vars[fkDisplay]?cap_first}() + "]]></${column.getAlias()}>";
        <#else>
        <#if (column.isColumnInPrimaryKey())>
        xml += "<${column.getAlias()} pk=\"true\"><![CDATA[" + ${column.getAlias()} + "]]></${column.getAlias()}>";
        <#else>
        xml += "<${column.getAlias()}><![CDATA[" + ((${column.getAlias()} == null) ? "" : ${column.getAlias()}) + "]]></${column.getAlias()}>";
        </#if>
        </#if>
        </#list>
        xml += "</${clazz.getAlias(true)?uncap_first}>";
        
        return xml;
    }
}