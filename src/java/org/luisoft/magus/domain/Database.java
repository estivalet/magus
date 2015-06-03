package org.luisoft.magus.domain;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;

@MappedTable(name = "MW_DATABASE")
public class Database {

	@MappedColumn(name = "id")
	private Long id;

	@MappedColumn(name = "name")
	private String type;

	private String connectionImpl;

	private String driver;

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the connectionImpl
	 */
	public String getConnectionImpl() {
		return connectionImpl;
	}

	/**
	 * @param connectionImpl
	 *            the connectionImpl to set
	 */
	public void setConnectionImpl(String connectionImpl) {
		this.connectionImpl = connectionImpl;
	}

	/**
	 * @return the driver
	 */
	public String getDriver() {
		return driver;
	}

	/**
	 * @param driver
	 *            the driver to set
	 */
	public void setDriver(String driver) {
		this.driver = driver;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

}
