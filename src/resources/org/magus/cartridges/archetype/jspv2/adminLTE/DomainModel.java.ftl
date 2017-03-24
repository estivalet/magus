<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.model;

import org.luisoft.commons.sql.criteria.Criteria;

import ${app.shortName}.domain.*;
import ${app.shortName}.mapper.${clazz.getAlias(true)}Mapper;
import java.util.*;

/**
 * Business class for ${clazz.getAlias(true)} object.
 * 
 * @author ${app.user}
 */
@SuppressWarnings("serial")
public class ${clazz.getAlias(true)}Model extends ${clazz.getAlias(true)} {

    /** Mapper for ${clazz.getAlias(true)} object. */
	private ${clazz.getAlias(true)}Mapper mapper = new ${clazz.getAlias(true)}Mapper();

    /**
     * Default constructor.
     */
    public ${clazz.getAlias(true)}Model() { }

	/**
     * <#list pkColumns as column>
     * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search for.
	 * </#list>
	 */
	public ${clazz.getAlias(true)}Model(<#list pkColumns as column>${column.getJdbcDataType()} ${column.getCamelCaseName()}</#list>) {
		${clazz.getAlias(true)} domain = mapper.fetchByPrimaryKey(<#list pkColumns as column>${column.getCamelCaseName()}</#list>);
		<#list allColumns as column>
        <#if (column.isColumnInForeignKey())>
        this.set${column.getForeignTableAlias(true)}(domain.get${column.getForeignTableAlias(true)}());
        <#else>
		this.set${column.getCamelCaseName(true)}(domain.get${column.getCamelCaseName(true)}());
        </#if>
		</#list>
	}

	/**
	 * @return All ${clazz.getAlias(true)} objects from database.
	 */
	public ${clazzArray} listAll(Integer pageNum) {
		if (pageNum != null) {
			mapper.setLimit(${recordsPerPage});
			mapper.setOffset((pageNum - 1) * ${recordsPerPage});
		}
	
		return mapper.fetchAll();
	}

	/**
	 * @return All ${clazz.getAlias(true)} objects from database.
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
	
	
	<#list columnsMinusPk as column>
    <#if (column.getPSJavaMethod() != "Bytes")>
	/**
	 * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName(true)} to search for.
	 * @return All ${clazz.getAlias(true)} objects matching name parameter.
	 */
	public ${clazzArray} listBy${column.getCamelCaseName(true)}(${column.getJdbcDataType()} ${column.getCamelCaseName()}) {
		return mapper.fetchBy${column.getCamelCaseName(true)}(${column.getCamelCaseName()});
	}
    </#if>	
	</#list>
	
	/**
	 * Save the ${clazz.getAlias(true)} object in database if it does not exists yet. 
	 * If object is already in the database then perform an update on its data.
	 */
	public boolean save() {
		${clazz.getAlias(true)} domain = mapper.fetchByPrimaryKey(<#list pkColumns as column>this.get${column.getCamelCaseName(true)}()</#list>);
		if (domain == null) {
			return mapper.insert(this);
		} else {
			return mapper.update(this);
		}
	}

	/**
	 * Delete the ${clazz.getAlias(true)} object from database.
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
