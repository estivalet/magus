<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.package}.mapper;

import org.luisoft.commons.sql.criteria.Criteria;

import ${app.package}.domain.*;
import ${app.package}.model.*;
import java.util.*;
import java.sql.*;

/**
 * Performs the mapping between database and ${clazzName} object.
 * 
 * @author ${app.user}
 */
public class ${clazzName} extends Mapper {

    /**
     * <#list pkColumns as column>
     * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search for.
	 * </#list>
	 * @return ${clazzDomainName} from the database.
	 */
	public ${clazzDomainName} fetchByPrimaryKey(<#list pkColumns as column>${column.getJdbcDataType()} ${column.getCamelCaseName()}</#list>) {
		String sql = "${clazz.getSQLSelectByPK()}";
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
		String sql = "${clazz.getSQLSelect()}";
		ResultSet rs = null;
		Connection con = null;
		try {
		    sql += " ORDER BY ${clazz.getOrderByColumn()}";
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
			sql = "${clazz.getSQLSelectCount()}";
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
	
    public ${clazzArray} fetch(${clazzDomainName} domain) {
        String sql = "${clazz.getSQLSelect()} WHERE 1=1 ";
        ResultSet rs = null;
        Connection con = null;
        int contador = 1;
        try {
            <#list columnsMinusPk as column>
            <#if (column.getPSJavaMethod() != "Bytes" && !column.isColumnInForeignKey())>
            if(domain.get${column.getCamelCaseName(true)}() != null) {
                sql += "AND ${column.getName()} LIKE ?"; 
            }
            </#if>
            </#list>
            
            sql += " ORDER BY ${clazz.getOrderByColumn()}";
            // For pagination purposes.
            if (limit != null && limit.intValue() > 0) {
                sql += " LIMIT " + limit;
            }
            if (offset != null && offset.intValue() > 0) {
                sql += " OFFSET " + offset;
            }
            con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            <#list columns as column>
            <#if (column.getPSJavaMethod() != "Bytes" && !column.isColumnInForeignKey())>
            if(domain.get${column.getCamelCaseName(true)}() != null) {
            <#if (column.getPSJavaMethod() = 'String')>
                ps.set${column.getPSJavaMethod()}(contador++, "%" + domain.get${column.getCamelCaseName(true)}() + "%");
            <#else>
                ps.set${column.getPSJavaMethod()}(contador++, domain.get${column.getCamelCaseName(true)}());
            </#if>
            }
            </#if>
            </#list>
            rs = ps.executeQuery();
            ${clazzArray} result = fetchMultipleResults(rs);
            
            // For pagination.
            sql = "${clazz.getSQLSelectCount()}";
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
        String sql = "${clazz.getSQLFKsSelect()} ";
        ResultSet rs = null;
        Connection con = null;

        for (Criteria c : criteria) {
            sql += " AND " + c.sqlString();
        }

        try {
            sql += " ORDER BY ${clazz.getOrderByColumn()}";
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
	
	
    <#list columnsMinusPk as column>
    <#if (column.getPSJavaMethod() != "Bytes")>
	/**
	 * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search.
	 * @return List of all ${clazzName} matching the ${column.getCamelCaseName()}.
	 */
	public ${clazzArray} fetchBy${column.getCamelCaseName(true)}(${column.getJdbcDataType()} ${column.getCamelCaseName()}) {
		String sql = "${clazz.getSQLSelect()} WHERE ${column.getName()} LIKE ?";
		ResultSet rs = null;
		Connection con = null;
		try {
		    sql += " ORDER BY ${clazz.getOrderByColumn()}";
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
	</#if>
	</#list>	
	
	/**
	 * Insert ${clazzDomainName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzDomainName} object to be inserted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean insert(${clazzDomainName} domain) {
		String sql = "${clazz.getSQLInsert()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
            con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list columnsMinusPk as column>
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
            int n = ps.executeUpdate();
            super.message = "No rows create!";
            if (n > 0) {
                super.message = "Created successfully " + n + " row(s)!";
            }
            return true;
		} catch (Exception e) {
		    super.message = e.getMessage();
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
	 * Update ${clazzDomainName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzDomainName} object to be updated.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean update(${clazzDomainName} domain) {
		String sql = "${clazz.getSQLUpdate()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
            con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list columnsMinusPk as column>
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
            int n = ps.executeUpdate();
            super.message = "No rows updated!";
            if (n > 0) {
                super.message = "Updated successfully " + n + " row(s)!";
            }
			return true;
		} catch (Exception e) {
		    super.message = e.getMessage();
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
	 * Delete ${clazzDomainName} object from database.
	 * 
	 * @param domain 
	 *            ${clazzDomainName} object to be deleted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
    public boolean delete(${clazzDomainName} domain) {
		String sql = "${clazz.getSQLDelete()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
		    con = getConnection();
			ps = con.prepareStatement(sql);
            int paramCount = 1;
            <#list pkColumns as column>
            ps.set${column.getPSJavaMethod()}(paramCount++, domain.get${column.getCamelCaseName(true)}());
            </#list>
            int n = ps.executeUpdate();
            super.message = "No rows deleted!";
            if (n > 0) {
                super.message = "Deleted successfully " + n + " row(s)!";
            }
			return true;
		} catch (Exception e) {
		    super.message = e.getMessage();
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
	private ${clazzDomainName} fetchSingleResult(ResultSet rs) throws Exception {
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
	 * @return Populate ${clazzDomainName} object based on the result set.
	 * @throws Exception
	 */
	private ${clazzDomainName} populate(ResultSet rs) throws Exception {
		${clazzDomainName} domain = new ${clazzDomainName}();
		<#list columns as column>
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