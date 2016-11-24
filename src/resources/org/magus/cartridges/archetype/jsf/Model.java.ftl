<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class ${clazz.getAlias(true)} implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    <#list allColumns as column><#t>
    <#if (column.isColumnInPrimaryKey())>
    @Id
    @GeneratedValue
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    <#else>
    <#-- Hibernate works better with Calendar -->
    <#if (column.getTypeName() == 'java.sql.Timestamp')>
    @Temporal(TemporalType.DATE)
    private java.util.Calendar ${column.getAlias()} = Calendar.getInstance();
    <#else>
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    </#if>
    </#if>
    </#list>
    
    <#list allColumns as column><#t>
    /**
     * @param ${column.getCamelCaseName()}
     *            the ${column.getCamelCaseName()} to set.
     */
    <#if (column.getTypeName() == 'java.sql.Timestamp')>
    public void set${column.getAlias()?cap_first}(Calendar ${column.getCamelCaseName()}) {
    <#else>
    </#if>
    public void set${column.getAlias()?cap_first}(${column.getTypeName()} ${column.getCamelCaseName()}) {
        this.${column.getAlias()} = ${column.getCamelCaseName()};
    }

    /**
     * @return the ${column.getCamelCaseName()}
     */
    <#if (column.getTypeName() == 'java.sql.Timestamp')>
    public Calendar get${column.getAlias()?cap_first}() {
    <#else>
    </#if>
    public ${column.getTypeName()} get${column.getAlias()?cap_first}() {
        return this.${column.getAlias()};
    }
    </#list>
}