<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.model;

import org.luisoft.commons.sql.criteria.Criteria;

import ${package}.domain.*;
import ${package}.mapper.${clazzName}Mapper;
import java.util.*;

/**
 * Business class for ${clazzName} object.
 * 
 * @author ${user}
 */
@SuppressWarnings("serial")
public class ${clazzName}Model extends ${clazzName} {

    /** Mapper for ${clazzName} object. */
	private ${clazzName}Mapper mapper = new ${clazzName}Mapper();

    /**
     * Default constructor.
     */
    public ${clazzName}Model() { }

	/**
     * <#list pkColumns as column>
     * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search for.
	 * </#list>
	 */
	public ${clazzName}Model(<#list pkColumns as column>${column.getJdbcDataType()} ${column.getCamelCaseName()}</#list>) {
		${clazzName} domain = mapper.fetchByPrimaryKey(<#list pkColumns as column>${column.getCamelCaseName()}</#list>);
		<#list allColumns as column>
        <#if (column.isColumnInForeignKey())>
        this.set${column.getForeignTableAlias(true)}(domain.get${column.getForeignTableAlias(true)}());
        <#else>
		this.set${column.getCamelCaseName(true)}(domain.get${column.getCamelCaseName(true)}());
        </#if>
		</#list>
	}

	/**
	 * @return All ${clazzName} objects from database.
	 */
	public ${clazzArray} listAll(Integer pageNum) {
		if (pageNum != null) {
			mapper.setLimit(${recordsPerPage});
			mapper.setOffset((pageNum - 1) * ${recordsPerPage});
		}
	
		return mapper.fetchAll();
	}

	/**
	 * @return All ${clazzName} objects from database.
	 */
	public ${clazzArray} listAll() {
		return listAll(null);
	}
	
    /**
     * @param criteria
     * @return
     */
   public ${clazzArray} listByCriteria(List<Criteria> criteria) {
        return mapper.fetchByCriteria(criteria);
    }
	
	
	<#list columns as column>
    <#if (column.getPSJavaMethod() != "Bytes")>
	/**
	 * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName(true)} to search for.
	 * @return All ${clazzName} objects matching name parameter.
	 */
	public ${clazzArray} listBy${column.getCamelCaseName(true)}(${column.getJdbcDataType()} ${column.getCamelCaseName()}) {
		return mapper.fetchBy${column.getCamelCaseName(true)}(${column.getCamelCaseName()});
	}
    </#if>	
	</#list>
	
	/**
	 * Save the ${clazzName} object in database if it does not exists yet. 
	 * If object is already in the database then perform an update on its data.
	 */
	public boolean save() {
		${clazzName} domain = mapper.fetchByPrimaryKey(<#list pkColumns as column>this.get${column.getCamelCaseName(true)}()</#list>);
		if (domain == null) {
			return mapper.insert(this);
		} else {
			return mapper.update(this);
		}
	}

	/**
	 * Delete the ${clazzName} object from database.
	 */
	public void remove() {
		mapper.delete(this);
	}

	public Integer getTotalRecords() {
		return mapper.getTotalRecords();
	}

    public void setPage(Integer pageNum) {
        mapper.setLimit(5);
        mapper.setOffset((pageNum - 1) * 5);
    }

}
