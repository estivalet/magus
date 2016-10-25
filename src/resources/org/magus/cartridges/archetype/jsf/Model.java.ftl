<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ${clazz.getAlias(true)} implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    <#list allColumns as column><#t>
    <#if (column.isColumnInPrimaryKey())>
    @Id
    @GeneratedValue
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    <#else>
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    </#if>
    </#list>
    
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
    public ${column.getTypeName()} get${column.getAlias()?cap_first}() {
        return this.${column.getAlias()};
    }
    </#list>
}