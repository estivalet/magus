package org.luisoft.magus.mapper;

import general.db.mapper.Mapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.FieldOption;
import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.ApplicationDatabase;
import org.luisoft.magus.domain.Database;
import org.luisoft.magus.domain.MagusConfig;

import dbreveng.DBReader;

/**
 * @author lestivalet
 * 
 */
public class ApplicationMapper extends Mapper {

    /**
     * Create new application.
     * 
     * @param id
     * @return
     */
    public Application create(Application app) {
        String sql = "insert into mw_application(name, short_name, description, path, template, architecture) values (?,?,?,?,?,?)";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, app.getName());
            ps.setString(2, app.getShortName());
            ps.setString(3, app.getDescription());
            ps.setString(4, app.getPath());
            ps.setString(5, app.getTemplate());
            ps.setString(6, app.getArchitecture());
            ps.execute();

            return fetchByName(app.getName());
        } catch (Exception e) {
            e.printStackTrace();
            super.setErrorMessage(e.getMessage());
            return null;
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
    }

    /**
     * Create new application.
     * 
     * @param id
     * @return
     */
    public String createApplicationDatabase(Long appId, ApplicationDatabase appdb) {
        String sql = "insert into mw_application_database(app_id, db_type, data_source, driver, connection_string, connection_impl, username, password) values (?, ?, ?, ?, ?, ?, ?, ?)";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, appId);
            ps.setString(2, appdb.getDb().getType());
            ps.setString(3, "ds");
            ps.setString(4, "driver");
            ps.setString(5, appdb.getConnectionString());
            ps.setString(6, "connimpl");
            ps.setString(7, appdb.getUsername());
            ps.setString(8, appdb.getPassword());
            ps.execute();

            return "OK";
        } catch (Exception e) {
            e.printStackTrace();
            super.setErrorMessage(e.getMessage());
            return null;
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
    }

    /**
     * Fetch an application byt its name. Still does not have the information about database being used.
     * 
     * @param name
     * @return
     */
    public Application fetchByName(String name) {
        String sql = "select app.id, app.short_name, app.name, app.path, app.template, app.architecture from mw_application app where app.name = ?";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            Application app = new Application();
            if (rs.next()) {
                app.setId(rs.getLong("id"));
                app.setShortName(rs.getString("short_name"));
                app.setName(rs.getString("name"));
                app.setPath(rs.getString("path"));
                app.setTemplate(rs.getString("template"));
                app.setArchitecture(rs.getString("architecture"));
            }
            return app;
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
     * Fetch an application by its id. Retrieve also database being used by the application.
     * 
     * @param id
     * @return
     */
    public Application fetchByPrimaryKey(Long id) {
        String sql = "select app.short_name, app.name, app.path, app.template, app.architecture, appdb.db_type, appdb.connection_string, appdb.username, appdb.password from mw_application app,mw_application_database appdb where appdb.app_id = app.id and app.id=?";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            int paramCount = 1;
            if (id == null) {
                return null;
            }
            ps.setLong(paramCount++, id);
            rs = ps.executeQuery();
            Application app = new Application();
            if (rs.next()) {
                app.setId(id);
                app.setShortName(rs.getString("short_name"));
                app.setName(rs.getString("name"));
                app.setPath(rs.getString("path"));
                app.setTemplate(rs.getString("template"));
                app.setArchitecture(rs.getString("architecture"));

                MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
                Database db = mc.getDatabase(rs.getString("db_type"));

                ApplicationDatabase ad = new ApplicationDatabase();
                ad.setDb(db);
                ad.setApp(app);
                ad.setConnectionString(rs.getString("connection_string"));
                ad.setUsername(rs.getString("username"));
                ad.setPassword(rs.getString("password"));
                app.setApplicationDatabase(ad);

                // Retrieve tables.
                String sql2 = "SELECT ID,APP_ID,CATALOG,SCHEMA,NAME,ALIAS,LABEL,ORDERBY,EXPORT_KEYS FROM mw_table where app_id = ?";
                PreparedStatement ps2 = con.prepareStatement(sql2);
                ps2.setLong(1, id);
                ResultSet rs2 = ps2.executeQuery();

                while (rs2.next()) {
                    DBReader dbr = new DBReader();
                    dbr.setDbConnectionImplementation(db.getConnectionImpl());
                    dbr.readDatabase(db.getDriver(), ad.getConnectionString(), ad.getUsername(), ad.getPassword());
                    context.setAttribute(MagusServlet.DATABASE, dbr);

                    dbr.getDatabase().setCurrentSchema(rs2.getString("SCHEMA"));
                    dbr.getDatabase().setCurrentCatalog(rs2.getString("CATALOG"));
                    TableWrapper tw = new TableWrapper(dbr.getTable(rs2.getString("NAME")));
                    tw.setAlias(rs2.getString("NAME"));

                    app.addTable(tw);
                }
                try {
                    if (rs2 != null) {
                        rs2.close();
                    }
                    ps2.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }
            return app;
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
     * Return all created applications.
     * 
     * @return
     */
    public List<Application> fetchAll() {
        List<Application> apps = new ArrayList<Application>();

        String sql = "select * from mw_application app, mw_application_database appdb where appdb.app_id = app.id";
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getLong("id"));
                app.setShortName(rs.getString("short_name"));
                app.setName(rs.getString("name"));
                app.setPath(rs.getString("path"));

                ApplicationDatabase ad = new ApplicationDatabase();
                // ad.setDb(db);
                ad.setApp(app);
                ad.setConnectionString(rs.getString("connection_string"));
                ad.setUsername(rs.getString("username"));
                ad.setPassword(rs.getString("password"));
                app.setApplicationDatabase(ad);

                apps.add(app);

            }
            return apps;
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

    // public List<Database> fetchAllDatabases() {
    // List<Database> dbs = new ArrayList<Database>();
    //
    // String sql = "select * from mw_database";
    // ResultSet rs = null;
    // PreparedStatement ps = null;
    // Connection con = null;
    // try {
    // con = getConnection();
    // ps = con.prepareStatement(sql);
    // rs = ps.executeQuery();
    //
    // while (rs.next()) {
    // Database db = new Database();
    // db.setId(rs.getLong("id"));
    // db.setType(rs.getString("name"));
    //
    // dbs.add(db);
    //
    // }
    // return dbs;
    // } catch (Exception e) {
    // e.printStackTrace();
    // } finally {
    // try {
    // if (rs != null) {
    // rs.close();
    // }
    // ps.close();
    // con.close();
    // } catch (SQLException e) {
    // e.printStackTrace();
    // }
    // }
    // return null;
    // }

    /**
     * @param appId
     * @param schemaName
     * @param tableName
     * @return
     */
    private Long fetchApplicationTableId(Long appId, String schemaName, String tableName) {
        String sql = "select * from mw_table where app_id=? and schema=? and name=?";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, appId);
            ps.setString(2, schemaName);
            ps.setString(3, tableName);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getLong("id");
            }
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
     * @param tableId
     * @param columnName
     * @return
     */
    private Long fetchApplicationTableColumnId(Long tableId, String columnName) {
        String sql = "select * from mw_field where table_id=? and name=? order by display_order";

        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, tableId);
            ps.setString(2, columnName);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getLong("id");
            }
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

    public void saveColumnOptions(Long appId, String schemaName, String tableName, String columnName, List<FieldOption> options) {
        PreparedStatement ps = null;
        Connection con = null;

        try {
            Long tableId = fetchApplicationTableId(appId, schemaName, tableName);
            Long columnId = fetchApplicationTableColumnId(tableId, columnName);

            String sql = "delete from mw_field_option where field_id = ?";
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, columnId);
            ps.executeUpdate();

            for (FieldOption fo : options) {
                sql = "insert into mw_field_option(field_id, value, text, display_order) values (?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setLong(1, columnId);
                ps.setString(2, fo.getValue());
                ps.setString(3, fo.getText());
                ps.setInt(4, fo.getDisplayOrder());
                ps.executeUpdate();
            }
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
    }

    public void deleteAllColumnOptions(Long appId, String schemaName, String tableName, String columnName) {
        PreparedStatement ps = null;
        Connection con = null;

        try {
            Long tableId = fetchApplicationTableId(appId, schemaName, tableName);
            Long columnId = fetchApplicationTableColumnId(tableId, columnName);

            String sql = "delete from mw_field_option where field_id = ?";
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, columnId);
            ps.executeUpdate();
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
    }

    /**
     * @param tableId
     * @param c
     */
    private void saveColumnMapping(Long tableId, ColumnWrapper c) {
        PreparedStatement ps = null;
        Connection con = null;
        Long columnId = fetchApplicationTableColumnId(tableId, c.getName());

        try {
            con = getConnection();

            // If column already exists performs an update, otherwise insert a new row.
            if (columnId == null) {
                String sql = "insert into mw_field(table_id, name, label, display_order, type, comment, mask, filter, visible) values(?,?,?,?,?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setLong(1, tableId);
                ps.setString(2, c.getName());
                ps.setString(3, c.getLabel());
                ps.setInt(4, c.getDisplayOrder());
                ps.setInt(5, c.getCustomFieldType());
                ps.setString(6, c.getComment());
                ps.setString(7, c.getInputMask());
                ps.setString(8, c.getFilter());
                ps.setString(9, c.getVisible());
                ps.executeUpdate();

            } else {
                String sql = "update mw_field set label=?, display_order=?, type=?, comment=?, mask=?, filter=?, visible=? where id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, c.getLabel());
                ps.setInt(2, c.getDisplayOrder());
                ps.setInt(3, c.getCustomFieldType());
                ps.setString(4, c.getComment());
                ps.setString(5, c.getInputMask());
                ps.setString(6, c.getFilter());
                ps.setString(7, c.getVisible());
                ps.setLong(8, columnId);
                ps.executeUpdate();

            }
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

    }

    /**
     * @param appId
     * @param tableWrapper
     * @param c
     */
    public void saveColumnMapping(Long appId, TableWrapper tableWrapper, ColumnWrapper c) {
        PreparedStatement ps = null;
        Connection con = null;
        Long tableId = fetchApplicationTableId(appId, tableWrapper.getTable().getSchema().getName(), tableWrapper.getName());
        try {
            // If table already in MW_TABLE.
            if (tableId != null) {
                saveColumnMapping(tableId, c);
            } else {
                // If table not in MW_TABLE insert it.
                String sql = "insert into mw_table(app_id, catalog, schema, name) values(?,?,?,?)";
                con = getConnection();
                ps = con.prepareStatement(sql);
                ps.setLong(1, appId);
                ps.setString(2, tableWrapper.getTable().getSchema().getCatalogName());
                ps.setString(3, tableWrapper.getTable().getSchema().getName());
                ps.setString(4, tableWrapper.getName());
                ps.executeUpdate();

                tableId = fetchApplicationTableId(appId, tableWrapper.getTable().getSchema().getName(), tableWrapper.getName());
                saveColumnMapping(tableId, c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * @param appId
     * @param tw
     * @return
     */
    public TableWrapper fetchApplicationTable(Long appId, TableWrapper tw) {
        String sql = "select * from mw_table where app_id=? and schema=? and name=?";

        ResultSet rs = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        Connection con = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, appId);
            ps.setString(2, tw.getTable().getSchema().getName());
            ps.setString(3, tw.getTable().getName());
            rs = ps.executeQuery();

            // Look for table metadata information.
            if (rs.next()) {
                tw.setLabel(rs.getString("label"));
                tw.setAlias(rs.getString("alias"));
                tw.setOrderBy(rs.getString("orderby"));

                Long tableId = rs.getLong("id");
                sql = "select * from mw_field where table_id = ? order by display_order";
                ps2 = con.prepareStatement(sql);
                ps2.setLong(1, tableId);
                rs2 = ps2.executeQuery();
                // Look for columns metadata information.
                while (rs2.next()) {
                    ColumnWrapper cw = new ColumnWrapper(tw.getTable().getColumn(rs2.getString("name")));
                    cw.setLabel(rs2.getString("label"));
                    cw.setDisplayOrder(rs2.getInt("display_order"));
                    cw.setCustomFieldType(rs2.getInt("type"));
                    cw.setInputMask(rs2.getString("mask"));
                    cw.setComment(rs2.getString("comment"));
                    cw.setFilter(rs2.getString("filter"));
                    cw.setVisible(rs2.getString("visible"));

                    // Look for columns options metadata information.
                    sql = "select * from mw_field_option where field_id = ? order by text";
                    ps3 = con.prepareStatement(sql);
                    ps3.setLong(1, rs2.getLong("id"));
                    rs3 = ps3.executeQuery();
                    while (rs3.next()) {
                        String value = rs3.getString("value");
                        String text = rs3.getString("text");
                        Integer displayOrder = rs3.getInt("display_order");
                        cw.addOption(value, text, displayOrder);
                    }

                    tw.addColumn(cw);
                }
            } else {
                return null;
            }
            return tw;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (rs3 != null) {
                    rs3.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;

    }

    public Map<String, TableWrapper> fetchApplicationTables(Long appId) {
        String sql = "select * from mw_table where app_id = ?";

        ResultSet rs = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        Connection con = null;
        Map<String, TableWrapper> tables = new HashMap<String, TableWrapper>();

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, appId);
            rs = ps.executeQuery();

            // Look for table metadata information.
            while (rs.next()) {

                DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
                dbr.getDatabase().setCurrentSchema(rs.getString("schema"));
                TableWrapper tw = new TableWrapper(dbr.getTable(rs.getString("name")));
                tw.setOrderBy(rs.getString("orderby"));

                Long tableId = rs.getLong("id");
                sql = "select * from mw_field where table_id = ? order by display_order";
                ps2 = con.prepareStatement(sql);
                ps2.setLong(1, tableId);
                rs2 = ps2.executeQuery();
                // Look for columns metadata information.
                while (rs2.next()) {
                    ColumnWrapper cw = new ColumnWrapper(tw.getTable().getColumn(rs2.getString("name")));
                    cw.setLabel(rs2.getString("label"));
                    cw.setDisplayOrder(rs2.getInt("display_order"));
                    cw.setCustomFieldType(rs2.getInt("type"));
                    cw.setInputMask(rs2.getString("mask"));

                    // Look for columns options metadata information.
                    sql = "select * from mw_field_option where field_id = ? order by display_order";
                    ps3 = con.prepareStatement(sql);
                    ps3.setLong(1, rs2.getLong("id"));
                    rs3 = ps3.executeQuery();
                    while (rs3.next()) {
                        String value = rs3.getString("value");
                        String text = rs3.getString("text");
                        Integer displayOrder = rs3.getInt("display_order");
                        cw.addOption(value, text, displayOrder);
                    }

                    tw.addColumn(cw);
                }

                tables.put(tw.getName(), tw);
            }
            return tables;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (rs3 != null) {
                    rs3.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;

    }

    public TableWrapper fetchApplicationTable(Long appId, String tableName) {
        String sql = "select * from mw_table where app_id = ? and name = ?";

        ResultSet rs = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        Connection con = null;
        TableWrapper tw = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, appId);
            ps.setString(2, tableName);
            rs = ps.executeQuery();

            // Look for table metadata information.
            while (rs.next()) {

                DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
                dbr.getDatabase().setCurrentSchema(rs.getString("schema"));
                tw = new TableWrapper(dbr.getTable(rs.getString("name")));

                Long tableId = rs.getLong("id");
                sql = "select * from mw_field where table_id = ? order by display_order";
                ps2 = con.prepareStatement(sql);
                ps2.setLong(1, tableId);
                rs2 = ps2.executeQuery();
                // Look for columns metadata information.
                while (rs2.next()) {
                    ColumnWrapper cw = new ColumnWrapper(tw.getTable().getColumn(rs2.getString("name")));
                    cw.setLabel(rs2.getString("label"));
                    cw.setDisplayOrder(rs2.getInt("display_order"));
                    cw.setCustomFieldType(rs2.getInt("type"));
                    cw.setInputMask(rs2.getString("mask"));

                    // Look for columns options metadata information.
                    sql = "select * from mw_field_option where field_id = ? order by display_order";
                    ps3 = con.prepareStatement(sql);
                    ps3.setLong(1, rs2.getLong("id"));
                    rs3 = ps3.executeQuery();
                    while (rs3.next()) {
                        String value = rs3.getString("value");
                        String text = rs3.getString("text");
                        Integer displayOrder = rs3.getInt("display_order");
                        cw.addOption(value, text, displayOrder);
                    }

                    tw.addColumn(cw);
                }

            }
            return tw;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (rs3 != null) {
                    rs3.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;

    }

}
