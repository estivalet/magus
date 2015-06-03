package org.luisoft.magus.domain;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;

@MappedTable(name = "MW_PARAMETER")
public class Parameter {

	@MappedColumn(name = "value")
	private String value;

	@MappedColumn(name = "id")
	private Integer id;

	@MappedColumn(name = "parameter")
	private String parameter;

	@MappedColumn(name = "description")
	private String description;

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the parameter
	 */
	public String getParameter() {
		return parameter;
	}

	/**
	 * @param parameter
	 *            the parameter to set
	 */
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

}
