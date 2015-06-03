<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ${clazz.getAlias(true)}PK implements Serializable {
    
    <#list attributeList as attribute><#t>
    /** comment here. */
    private ${attribute.getTypeName()} ${attribute.getCamelCaseName()};
    
    </#list>

    <#list attributeList as attribute><#t>
    /**
     * @param ${attribute.getCamelCaseName()}
     *            the ${attribute.getCamelCaseName()} to set.
     */
    public void set${attribute.getCamelCaseName(true)}(${attribute.getTypeName()} ${attribute.getCamelCaseName()}) {
        this.${attribute.getCamelCaseName()} = ${attribute.getCamelCaseName()};
    }

    /**
     * @return the ${attribute.getCamelCaseName()}
     */
    public ${attribute.getTypeName()} get${attribute.getCamelCaseName(true)}() {
        return this.${attribute.getCamelCaseName()};
    }
    </#list>
       
    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        <#list attributeList as attribute><#t>
        result = prime * result + ((${attribute.getCamelCaseName()} == null) ? 0 : ${attribute.getCamelCaseName()}.hashCode());
        </#list>
        return result;
    }
    
    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (!(obj instanceof ${clazz.getAlias(true)}))
            return false;
        ${clazz.getAlias(true)}PK other = (${clazz.getAlias(true)}PK) obj;
        <#list attributeList as attribute><#t>
        if (${attribute.getCamelCaseName()} == null) {
            if (other.${attribute.getCamelCaseName()} != null)
                return false;
        } else if (!${attribute.getCamelCaseName()}.equals(other.${attribute.getCamelCaseName()}))
            return false;
        </#list>
        return true;
    }
}