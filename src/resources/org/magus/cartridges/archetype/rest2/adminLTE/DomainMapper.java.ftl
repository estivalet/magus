<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.mapper;

import org.luisoft.commons.core.Mapper;
import org.luisoft.commons.sql.criteria.Criteria;

import ${app.shortName}.domain.*;
import ${app.shortName}.model.*;
import java.util.*;
import java.sql.*;

import ${app.shortName}.server.${app.getShortName(true)}Servlet;

/**
 * Performs the mapping between database and ${clazz.getAlias(true)} object.
 * 
 * @author ${app.user}
 */
public class ${clazz.getAlias(true)}Mapper extends Mapper {

    <#list clazz.getColumns(true) as column>
    <#if column.isColumnInExportedKey()>
    public List<${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}> get${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}s(${column.getJdbcDataType()} ${column.getColumnInExportedKey(true)}) {
        String sql = "${clazz.getSQLMxN(column.getExportedTable(), column.getColumnInExportedKey())}";
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
            ps = con.prepareStatement(sql);
            ps.set${column.getPSJavaMethod()}(1, ${column.getColumnInExportedKey(true)});
            rs = ps.executeQuery();
            List<${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}> result = fetch${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}MultipleResults(rs);
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
    </#if>
    </#list>

    /**
     * <#list pkColumns as column>
     * @param ${column.getCamelCaseName()}
	 *            ${column.getCamelCaseName()} to search for.
	 * </#list>
	 * @return ${clazz.getAlias(true)} from the database.
	 */
	public ${clazz.getAlias(true)} fetchByPrimaryKey(<#list pkColumns as column>${column.getJdbcDataType()} ${column.getCamelCaseName()}</#list>) {
		String sql = "${clazz.getSQLSelectByPK()}";
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection con = null;
		try {
		    con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	 * @return All ${clazz.getAlias(true)} objects from the database.
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
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	
    public ${clazzArray} fetch(${clazz.getAlias(true)} domain) {
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
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
            PreparedStatement ps = con.prepareStatement(sql);
            <#list columnsMinusPk as column>
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
            
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	 * @return List of all ${clazz.getAlias(true)} matching the ${column.getCamelCaseName()}.
	 */
	public ${clazzArray} fetchBy${column.getCamelCaseName(true)}(${column.getJdbcDataType()} ${column.getCamelCaseName()}) {
		String sql = "${clazz.getSQLSelect()} WHERE ${column.getName()} LIKE ?";
		ResultSet rs = null;
		Connection con = null;
		try {
		    sql += " ORDER BY ${clazz.getOrderByColumn()}";
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	
	
    <#list clazz.getColumns(true) as column>
    <#if column.isColumnInExportedKey()>
    public boolean insert${column.getExportedTable().getCamelCaseName(true)}(${clazz.getAlias(true)} domain, List<${column.getJdbcDataType()}> ${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}s) {
        String sql = "${column.getExportedTable().getSQLInsert(false)}";
        
        insert(domain);
        
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
            for (${column.getJdbcDataType()} id : ${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}s) {
                ps = con.prepareStatement(sql);
                int paramCount = 1;
                <#list column.getExportedTable().getColumns(false) as c2>
                <#if column.getColumnInExportedKey() == c2.getName()>
                ps.set${c2.getPSJavaMethod()}(paramCount++, id);
                <#else>
                ps.set${c2.getPSJavaMethod()}(paramCount++, domain.get${c2.getCamelCaseName(true)}());
                </#if>
                </#list>
                ps.executeUpdate();
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
    </#if>
    </#list>
	
	/**
	 * Insert ${clazz.getAlias(true)} object from database.
	 * 
	 * @param domain 
	 *            ${clazz.getAlias(true)} object to be inserted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean insert(${clazz.getAlias(true)} domain) {
		String sql = "${clazz.getSQLInsert()}";
		PreparedStatement ps = null;
		Connection con = null;
		Integer id = 0;
		try {
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
            super.message = "No rows created!";
            if (n > 0) {
                // WARNING FOR HSQLDB ONLY!!!!
                PreparedStatement psIdentity = con.prepareStatement("CALL IDENTITY()");
                ResultSet result = psIdentity.executeQuery();
                result.next();
                id = result.getInt(1);
                domain.setId(id);
                result.close();
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
	 * Update ${clazz.getAlias(true)} object from database.
	 * 
	 * @param domain 
	 *            ${clazz.getAlias(true)} object to be updated.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
	public boolean update(${clazz.getAlias(true)} domain) {
		String sql = "${clazz.getSQLUpdate()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
            con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	 * Delete ${clazz.getAlias(true)} object from database.
	 * 
	 * @param domain 
	 *            ${clazz.getAlias(true)} object to be deleted.
	 * @return <code>true</code> if success, <code>false</code> otherwise.
	 */
    public boolean delete(${clazz.getAlias(true)} domain) {
		String sql = "${clazz.getSQLDelete()}";
		PreparedStatement ps = null;
		Connection con = null;
		try {
		    con = getConnection(${app.getShortName(true)}Servlet.DSN);
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
	private ${clazz.getAlias(true)} fetchSingleResult(ResultSet rs) throws Exception {
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
	 * @return Populate ${clazz.getAlias(true)} object based on the result set.
	 * @throws Exception
	 */
	private ${clazz.getAlias(true)} populate(ResultSet rs) throws Exception {
		${clazz.getAlias(true)} domain = new ${clazz.getAlias(true)}();
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
	
    <#list clazz.getColumns(true) as column>
    <#if column.isColumnInExportedKey()>
    public List<${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}> fetch${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}MultipleResults(ResultSet rs) throws Exception {
        List<${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}> results = new ArrayList<${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}>();
        while (rs.next()) {
            results.add(populate${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}(rs));
        }
        this.totalRecords = results.size();
        return results;
    }
    
    private ${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())} populate${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}(ResultSet rs) throws Exception {
        ${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())} domain = new ${clazz.getImportedTableOfExportedTableAsString(column.getExportedTable(), column.getColumnInExportedKey())}();
        <#list clazz.getImportedTableOfExportedTable(column.getExportedTable(), column.getColumnInExportedKey()).getColumns(true) as column>
        domain.set${column.getCamelCaseName(true)}(rs.get${column.getPSJavaMethod()}("${column.name}"));
        </#list>
        
        return domain;
    }    
    </#if>
    </#list>
	
}