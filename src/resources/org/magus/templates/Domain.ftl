<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

<#list columnList as column><#t>
<#if column.getTypeName() = 'java.sql.Date'>
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.luisoft.commons.xml.SqlDateAdapter;
<#break>
</#if>
</#list>

@SuppressWarnings("serial")
@XmlRootElement
public class ${clazz} implements Serializable, Cloneable {
    
    <#list columnList as column><#t>
    /** comment here. */
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    
    </#list>

    <#list columnList as column><#t>
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
        <#list columnList as column><#t>
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
        if (!(obj instanceof ${clazz})) {
            return false;
        }
        ${clazz} other = (${clazz}) obj;
        <#list columnList as column><#t>
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
        String xml = "<${clazz?uncap_first}>";
        <#list columnList as column><#t>
        <#if (column.isColumnInForeignKey())>
        <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
        xml += "<${column.getAlias()}><![CDATA[" + ${column.getForeignTableAlias()}.get${.vars[fkDisplay]}() + "]]></${column.getAlias()}>";
        <#else>
        <#if (column.isColumnInPrimaryKey())>
        xml += "<${column.getAlias()} pk=\"true\"><![CDATA[" + ${column.getAlias()} + "]]></${column.getAlias()}>";
        <#else>
        xml += "<${column.getAlias()}><![CDATA[" + ((${column.getAlias()} == null) ? "" : ${column.getAlias()}) + "]]></${column.getAlias()}>";
        </#if>
        </#if>
        </#list>
        xml += "</${clazz?uncap_first}>";
        
        return xml;
    }
}