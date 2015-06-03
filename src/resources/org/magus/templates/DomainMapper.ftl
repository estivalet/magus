<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.mapper;

import org.luisoft.commons.sql.criteria.Criteria;

import ${package}.domain.*;
import ${package}.model.*;
import java.util.*;
import java.sql.*;

/**
 * Performs the mapping between database and ${clazzName} object.
 * 
 * @author ${user}
 */
public class ${clazzName}Mapper extends Mapper {

    /**
     * <#list pkColumns as column>
     * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search for.
	 * </#list>
	 * @return ${clazzName} from the database.
	 */
	public ${clazzName} fetchByPrimaryKey(<#list pkColumns as column>${column.getJdbcDataType()} ${column.getCamelCaseName()}</#list>) {
		String sql = "${table.getSQLSelectByPK()}";
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection con = null;
		try {
		    con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list pkColumns as column>
            if(${column.getCamelCaseName()} == null) {
            	return null;
            }
            ps.set${column.getPSJavaMethod()}(paramCount++, ${column.getCamelCaseName()});
            </#list>
			rs = ps.executeQuery();
			return fetchSingleResult(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * @return All ${clazzName} objects from the database.
	 */
	public ${clazzArray} fetchAll() {
		String sql = "${table.getSQLSelect()}";
		ResultSet rs = null;
		Connection con = null;
		try {
		    sql += " ORDER BY ${table.getOrderByColumn()}";
		    // For pagination purposes.
            if (limit != null && limit.intValue() > 0) {
                sql += " LIMIT " + limit;
            }
            if (offset != null && offset.intValue() > 0) {
                sql += " OFFSET " + offset;
            }
            con = getConnection();
			Statement statement = con.createStatement();
			rs = statement.executeQuery(sql);
			${clazzArray} result = fetchMultipleResults(rs);
			
			// For pagination.
			sql = "${table.getSQLSelectCount()}";
			Statement st = con.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			this.totalRecords = rs.getInt(1);
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.getStatement().close();
				rs.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
    /**
     * @param criteria
     * @return
     */
    public ${clazzArray} fetchByCriteria(List<Criteria> criteria) {
        String sql = "${table.getSQLFKsSelect()} ";
        ResultSet rs = null;
        Connection con = null;

        for (Criteria c : criteria) {
            sql += " AND " + c.sqlString();
        }

        try {
            sql += " ORDER BY ${table.getOrderByColumn()}";
            // For pagination purposes.
            if (limit != null && limit.intValue() > 0) {
                sql += " LIMIT " + limit;
            }
            if (offset != null && offset.intValue() > 0) {
                sql += " OFFSET " + offset;
            }
            
            con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            return fetchMultipleResults(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.getStatement().close();
                rs.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
	
	
    <#list columns as column>
	/**
	 * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search.
	 * @return List of all ${clazzName} matching the ${column.getCamelCaseName()}.
	 */
	public ${clazzArray} fetchBy${column.getCamelCaseName(true)}(${column.getJdbcDataType()} ${column.getCamelCaseName()}) {
		String sql = "${table.getSQLSelect()} WHERE ${column.getName()} LIKE ?";
		ResultSet rs = null;
		Connection con = null;
		try {
		    sql += " ORDER BY ${table.getOrderByColumn()}";
            con = getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			<#if (column.getPSJavaMethod() = 'String')>
			ps.set${column.getPSJavaMethod()}(1, "%" + ${column.getCamelCaseName()} + "%");
			<#else>
			ps.set${column.getPSJavaMethod()}(1, ${column.getCamelCaseName()});
			</#if>
			rs = ps.executeQuery();
			return fetchMultipleResults(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.getStatement().close();
				rs.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	</#list>	
	
	/**
	 * Insert ${clazzName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzName} object to be inserted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean insert(${clazzName} domain) {
		String sql = "${table.getSQLInsert()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
            con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list columns as column>
            <#if (column.isColumnInForeignKey())>
            if(domain.get${column.getForeignTableAlias(true)}() == null) {
            	ps.setNull(paramCount++, Types.NULL);
            } else {
            	ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getForeignTableAlias(true)}().get${column.getForeignColumn(true)}());
            }
            <#else>
            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getCamelCaseName(true)}());
            </#if>
            </#list>
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	/**
	 * Update ${clazzName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzName} object to be updated.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean update(${clazzName} domain) {
		String sql = "${table.getSQLUpdate()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
            con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list columns as column>
            <#if (column.isColumnInForeignKey())>
            if(domain.get${column.getForeignTableAlias(true)}() == null) {
            	ps.setNull(paramCount++, Types.NULL);
            } else {
	            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getForeignTableAlias(true)}().get${column.getForeignColumn(true)}());
	        }
            <#else>
            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getCamelCaseName(true)}());
            </#if>
            </#list>
            <#list pkColumns as column>
            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getCamelCaseName(true)}());
            </#list>
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
			    if(ps != null) {
				    ps.close();
				}
				if(con != null) {
				    con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	
	/**
	 * Delete ${clazzName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzName} object to be deleted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
    public boolean delete(${clazzName} domain) {
		String sql = "${table.getSQLDelete()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
		    con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list pkColumns as column>
            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getCamelCaseName(true)}());
            </#list>
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}	

	/**
	 * @param rs
	 *            ResultSet of the query.
	 * @return Just the first line of result set.
	 * @throws Exception
	 */
	private ${clazzName} fetchSingleResult(ResultSet rs) throws Exception {
		if (rs.next()) {
			return populate(rs);
		}
		return null;
	}

	/**
	 * @param rs
	 *            ResultSet of the query.
	 * @return All lines of the result set.
	 * @throws Exception
	 */
	private ${clazzArray} fetchMultipleResults(ResultSet rs) throws Exception {
		${clazzArray} results = new ${clazzImplementation}();
		while (rs.next()) {
			results.add(populate(rs));
		}
		this.totalRecords = results.size();
		return results;
	}

	/**
	 * @param rs
	 *            ResultSet of the query.
	 * @return Populate ${clazzName} object based on the result set.
	 * @throws Exception
	 */
	private ${clazzName} populate(ResultSet rs) throws Exception {
		${clazzName} domain = new ${clazzName}();
		<#list allColumns as column>
        <#if (column.isColumnInForeignKey())>
        if (rs.getString("${column.name}") != null) {
	        ${column.getForeignTableAlias(true)}Model model = new ${column.getForeignTableAlias(true)}Model(rs.get${column.getPSJavaMethod()}("${column.name}"));
	        domain.set${column.getForeignTableAlias(true)}(model);
	    }
        <#else>
		domain.set${column.getCamelCaseName(true)}(rs.get${column.getPSJavaMethod()}("${column.name}"));
        </#if>
		</#list>

		return domain;
	}
}