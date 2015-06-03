<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.mapper;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

public class Mapper {
	private static DataSource ds;

	/** Limit number of rows to return in a query. */
	protected Integer limit;

	/** Skip that many rows before beginning to return rows. */
	protected Integer offset;
	
	protected Integer totalRecords;

	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	public static void setDataSource(DataSource dataSource) {
		ds = dataSource;
	}
	
	/**
	 * @return the limit
	 */
	public Integer getLimit() {
		return limit;
	}

	/**
	 * @param limit
	 *            the limit to set
	 */
	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	/**
	 * @return the offset
	 */
	public Integer getOffset() {
		return offset;
	}

	/**
	 * @param offset
	 *            the offset to set
	 */
	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	/**
	 * @return the totalRecords
	 */
	public Integer getTotalRecords() {
		return totalRecords;
	}

	/**
	 * @param offset
	 *            the totalRecords to set
	 */
	public void setTotalRecords(Integer totalRecords) {
		this.totalRecords = totalRecords;
	}
	
}
