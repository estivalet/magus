package org.luisoft.magus.core.commands;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.FieldOption;
import org.luisoft.magus.core.FieldType;
import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Database;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.DBReader;
import dbreveng.database.DatabaseConnection;
import dbreveng.database.meta.Column;
import dbreveng.database.meta.Schema;
import dbreveng.database.meta.Table;
import general.server.ICommand;
import general.server.IContext;

public class DatabaseCommand implements ICommand {

    private void debug(HttpServletRequest request) {
        System.out.println("*****************************");
        Map<String, String[]> params = request.getParameterMap();
        Iterator<String> i = params.keySet().iterator();

        while (i.hasNext()) {
            String key = (String) i.next();
            String value = ((String[]) params.get(key))[0];

            System.out.println(key + " " + value);
        }
        System.out.println("*****************************");
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        // Retrieve action.
        String action = request.getParameter("action");

        // Check what action was chosen.
        if ("checkConnection".equals(action)) {
            return checkConnection(request, response, context);
        } else if ("listSchemas".equals(action)) {
            return listSchemas(request, response, context);
        } else if ("listTables".equals(action)) {
            return listTables(request, response, context);
        } else if ("listTableColumns".equals(action)) {
            listTableColumns(request, response, context);
        } else if ("listColumnMapping".equals(action)) {
            listColumnMapping(request, response, context);
        } else if ("saveTableMapping".equals(action)) {
            saveTableMapping(request, response, context);
        } else if ("saveColumnMapping".equals(action)) {
            saveColumnMapping(request, response, context);
        } else if ("saveOneColumnMapping".equals(action)) {
            saveOneColumnMapping(request, response, context);
        } else if ("saveColumnOptions".equals(action)) {
            saveColumnOptions(request, response, context);
        } else if ("listColumnOptions".equals(action)) {
            listColumnOptions(request, response, context);
        }
        return null;
    }

    /**
     * List schemas of the selected database.
     * 
     * @param request
     * @param response
     * @param context
     * @return
     */
    private String listSchemas(HttpServletRequest request, HttpServletResponse response, IContext context) {
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");

        // Retrieve which database type we are working on (HSQLDB, PostgreSQL, Oracle).
        String database = request.getParameter("database");
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        Database db = mc.getDatabase(database);

        String connImpl = db.getConnectionImpl();
        String driver = db.getDriver();
        String url = request.getParameter("url");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            DBReader dbr = new DBReader();
            dbr.setDbConnectionImplementation(connImpl);

            // dbr.setWorkingCatalog(url.substring(url.lastIndexOf("/") + 1));
            // dbr.setWorkingSchema(url.substring(url.lastIndexOf("/") + 1));

            dbr.readDatabase(driver, url, username, password);
            if ("MySQL".equals(database)) {
                String catsche = url.substring(url.lastIndexOf("/") + 1);
                dbr.getDatabase().setCurrentCatalog(catsche);
                dbr.getDatabase().setCurrentSchema(catsche);
            }
            context.setAttribute(MagusServlet.DATABASE, dbr);

            message.append("<schemas>");
            TreeMap<String, Schema> schemas = dbr.getDatabase().getCurrentCatalog().getSchemas();
            for (Entry<String, Schema> s : schemas.entrySet()) {
                message.append("<schema>" + s.getKey() + "</schema>");
            }
            message.append("</schemas>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            message.append("</request>");
            response.getWriter().write(message.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return message.toString();
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws Exception
     */
    private String listTables(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        // Set response properties.
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        // Check if database was already read in servlet context.
        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        if (dbr != null) {
            // Get selected schema.
            String schema = request.getParameter("schema");
            dbr.getDatabase().setCurrentSchema(schema);
            message.append("<tables>");
            // List all tables for selected schema.
            Collection<Table> tables = dbr.getDatabase().getTables();
            for (Table t : tables) {
                message.append("<table>" + t.getName() + "</table>");
            }
            message.append("</tables>");
            message.append("</request>");
            response.getWriter().write(message.toString());
        }

        return message.toString();
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws Exception
     */
    private String listTableColumns(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        // Retrieve selected table and add it to the context.
        String tableName = request.getParameter("table");
        String schema = request.getParameter("schema");
        Long id = Long.parseLong(request.getParameter("id"));

        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);

        TableWrapper tw = new TableWrapper(dbr.getTable(tableName));

        // Check if metadata is already in database.
        ApplicationMapper am = new ApplicationMapper();
        tw = am.fetchApplicationTable(id, tw);
        // If not then insert it with default values.
        if (tw == null) {
            tw = new TableWrapper(dbr.getTable(tableName));

            // List all columns for selected table.
            for (Column c : getColumns(request, context)) {

                System.out.println("ORDINAL--->" + c.getOrdinalPosition());

                ColumnWrapper cw = new ColumnWrapper(c);
                // Default field for foreign key columns is a select box.
                if (c.isColumnInForeignKey()) {
                    cw.setCustomFieldType(FieldType.SELECTBOXFK.ordinal());
                }

                // Default custom field types
                switch (c.getDataType()) {
                case Types.DATE:
                    cw.setCustomFieldType(FieldType.DATEPICKER.ordinal());
                }

                tw.addColumn(cw);

                // Populate metadata tables with default.
                am.saveColumnMapping(id, tw, cw);
            }
        }

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<table>");
        message.append("<name>" + tw.getName() + "</name>");
        message.append("<label>" + tw.getLabel() + "</label>");
        message.append("<orderBy>" + tw.getOrderByColumn() + "</orderBy>");
        message.append("<columns>");
        // For each column in the table.
        for (ColumnWrapper c : tw.getOrderedColumnsWrapper()) {
            message.append("<column name=\"" + c.getName() + "\">");
            message.append("<label>" + c.getLabel() + "</label>");
            message.append("<type>" + c.getCustomFieldType() + "</type>");
            message.append("<displayOrder>" + c.getDisplayOrder() + "</displayOrder>");
            message.append("<mask>" + c.getInputMask() + "</mask>");
            message.append("<visible>" + c.getVisible() + "</visible>");
            message.append("<filter>" + c.getFilter() + "</filter>");
            message.append("<comment>" + c.getComment() + "</comment>");
            message.append("</column>");
        }
        message.append("</columns>");
        message.append("</table>");
        response.getWriter().write(message.toString());

        System.out.println(message.toString());

        return message.toString();
    }

    /**
     * Return the options map in a string format: <value>,<text>
     * 
     * @param options
     * @return
     */
    private String getColumnOptions(Map<String, FieldOption> options) {
        String opts = "";
        for (String key : options.keySet()) {
            FieldOption fo = options.get(key);
            opts += fo.getValue() + "," + fo.getText() + ";";
        }

        return opts;
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws Exception
     */
    private String listColumnMapping(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        // Retrieve selected table and add it to the context.
        String columnName = request.getParameter("column");
        String tableName = request.getParameter("table");
        String schema = request.getParameter("schema");
        Long appId = Long.parseLong(request.getParameter("project"));

        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);

        TableWrapper tw = new TableWrapper(dbr.getTable(tableName));

        // Check if metadata is already in database.
        ApplicationMapper am = new ApplicationMapper();
        tw = am.fetchApplicationTable(appId, tw);
        // If not then insert it with default values.
        if (tw == null) {
            tw = new TableWrapper(dbr.getTable(tableName));

            Column c = getColumn(request, context);
            ColumnWrapper cw = new ColumnWrapper(c);
            // Default field for foreign key columns is a select box.
            if (c.isColumnInForeignKey()) {
                cw.setCustomFieldType(FieldType.SELECTBOXFK.ordinal());
            }
            tw.addColumn(cw);

            // Populate metadata tables with default.
            am.saveColumnMapping(appId, tw, cw);

        }

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        // For each column in the table.
        ColumnWrapper c = tw.getColumnWrapper(columnName);
        message.append("<column name=\"" + c.getName() + "\">");
        message.append("<label>" + c.getLabel() + "</label>");
        message.append("<type>" + c.getCustomFieldType() + "</type>");
        message.append("<displayOrder>" + c.getDisplayOrder() + "</displayOrder>");
        message.append("<options>" + getColumnOptions(c.getOptions()) + "</options>");
        message.append("<comment>" + c.getComment() + "</comment>");
        message.append("<mask>" + c.getInputMask() + "</mask>");
        message.append("<filter>" + c.getFilter() + "</filter>");
        message.append("<visible>" + c.getVisible() + "</visible>");
        message.append("</column>");

        response.getWriter().write(message.toString());

        return message.toString();
    }

    /**
     * List columns of requested schema.table.
     * 
     * @param request
     * @param context
     * @return
     */
    private Collection<Column> getColumns(HttpServletRequest request, IContext context) {
        // Check if database was already read in servlet context.
        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        // Get selected schema and table.
        String schema = request.getParameter("schema");
        String table = request.getParameter("table");
        dbr.getDatabase().setCurrentSchema(schema);

        return dbr.getTable(table).getColumns(true);
    }

    private Column getColumn(HttpServletRequest request, IContext context) {
        // Check if database was already read in servlet context.
        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        // Get selected schema and table.
        String schema = request.getParameter("schema");
        String table = request.getParameter("table");
        String columnName = request.getParameter("column");
        dbr.getDatabase().setCurrentSchema(schema);

        return dbr.getTable(table).getColumn(columnName);
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws IOException
     */
    private String saveTableMapping(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        String tableName = request.getParameter("table");
        String schema = request.getParameter("schema");

        request.setCharacterEncoding("UTF-8");

        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);

        TableWrapper tw = new TableWrapper(dbr.getTable(tableName));
        tw.setAlias(request.getParameter("tableAlias"));
        tw.setLabel(request.getParameter("tableLabel"));
        tw.setOrderBy(request.getParameter("tableOrder"));
        tw.setExportKeys("Y".equals(request.getParameter("tableExport")));
        ApplicationMapper am = new ApplicationMapper();
        am.saveTableMapping(Long.parseLong(request.getParameter("project")), tw);

        return null;
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws IOException
     */
    private String saveColumnMapping(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        // tables = (Map<String, TableWrapper>) context.getAttribute("tables");
        String tableName = request.getParameter("table");
        String schema = request.getParameter("schema");

        request.setCharacterEncoding("UTF-8");
        String queryString = URLDecoder.decode(request.getQueryString(), "ISO-8859-1");

        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);

        // addTableToContext(schema, tableName, request, context);

        // List all columns for selected table.
        TableWrapper tw = new TableWrapper(dbr.getTable(tableName));

        // Get configuration for column tables.
        String[] col = request.getParameterValues("columns");
        String[] label = request.getParameterValues("label");
        String[] type = request.getParameterValues("type");
        String[] order = request.getParameterValues("order");
        String[] comment = request.getParameterValues("comment");
        String[] masked = request.getParameterValues("masked");
        String[] visible = request.getParameterValues("visible");
        String[] filter = request.getParameterValues("filter");
        for (int i = 0; i < col.length; i++) {
            // ColumnWrapper c = tw.getColumnWrapper(col[i]);
            ColumnWrapper cw = new ColumnWrapper(tw.getTable().getColumn(col[i]));
            cw.setLabel(label[i]);
            cw.setCustomFieldType(Integer.parseInt(type[i]));
            cw.setDisplayOrder(Integer.parseInt(order[i]));
            cw.setComment(comment[i]);
            cw.setInputMask(masked[i]);
            cw.setVisible(visible[i]);
            cw.setFilter(filter[i]);
            tw.addColumn(cw);

            ApplicationMapper am = new ApplicationMapper();
            am.saveColumnMapping(Long.parseLong(request.getParameter("project")), tw, cw);
        }

        return null;
    }

    /**
     * @param request
     * @param response
     * @param context
     * @return
     * @throws IOException
     */
    private String saveOneColumnMapping(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        debug(request);

        Long project = Long.parseLong(request.getParameter("project"));
        String schema = request.getParameter("schema");
        String table = request.getParameter("table");
        String column = request.getParameter("column");

        // Get column mapping data.
        String label = request.getParameter("label");
        Integer type = Integer.parseInt(request.getParameter("type"));
        String order = request.getParameter("order");
        String mask = request.getParameter("mask");
        String comment = request.getParameter("comment");
        String options = request.getParameter("options");
        String filter = request.getParameter("filter");
        String visible = request.getParameter("visible");

        // Get column metadata.
        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);
        TableWrapper tw = new TableWrapper(dbr.getTable(table));
        ColumnWrapper cw = new ColumnWrapper(tw.getTable().getColumn(column));

        cw.setLabel(label);
        cw.setCustomFieldType(type);
        cw.setDisplayOrder(Integer.parseInt(order));
        cw.setInputMask(mask);
        cw.setComment(comment);
        cw.setVisible(visible);
        cw.setFilter(filter);
        tw.addColumn(cw);

        ApplicationMapper am = new ApplicationMapper();
        am.saveColumnMapping(project, tw, cw);

        if (options != null && !"".equals(options)) {
            // Options are separated by ;
            String[] opts = options.split(";");
            ArrayList<FieldOption> fops = new ArrayList<FieldOption>();
            for (int i = 0; i < opts.length; i++) {
                // Each option has value-text pair.
                String value = opts[i].split(",")[0];
                String text = opts[i].split(",")[1];
                FieldOption fo = new FieldOption(value, text, 0);
                fops.add(fo);
            }

            if (fops.size() > 0) {
                am.saveColumnOptions(project, schema, table, column, fops);
            }
        }

        return null;
    }

    private void saveColumnOptions(HttpServletRequest request, HttpServletResponse response, IContext context) {
        Long appId = Long.parseLong(request.getParameter("project"));
        String schemaName = request.getParameter("schema");
        String tableName = request.getParameter("table");
        String columnName = request.getParameter("column");
        // Options are received in the following format: <optval1>,<opttxt1>;<optval2>,<opttxt2>;<optval3>,<opttxt3>;
        String colOpts = request.getParameter("colOpts");

        ApplicationMapper am = new ApplicationMapper();
        if (!"".equals(colOpts)) {
            String[] opts = colOpts.split(";");
            ArrayList<FieldOption> fops = new ArrayList<FieldOption>();
            for (int i = 0; i < opts.length; i++) {
                String value = opts[i].split(",")[0];
                String text = opts[i].split(",")[1];
                FieldOption fo = new FieldOption(value, text, 0);
                fops.add(fo);
            }
            am.saveColumnOptions(appId, schemaName, tableName, columnName, fops);
        } else {
            am.deleteAllColumnOptions(appId, schemaName, tableName, columnName);
        }

    }

    private void listColumnOptions(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        Long appId = Long.parseLong(request.getParameter("project"));
        String schema = request.getParameter("schema");
        String tableName = request.getParameter("table");
        String columnName = request.getParameter("column");

        DBReader dbr = (DBReader) context.getAttribute(MagusServlet.DATABASE);
        dbr.getDatabase().setCurrentSchema(schema);

        TableWrapper tw = new TableWrapper(dbr.getTable(tableName));
        ApplicationMapper am = new ApplicationMapper();
        tw = am.fetchApplicationTable(appId, tw);
        ColumnWrapper cw = tw.getColumnWrapper(columnName);
        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<options>");
        for (FieldOption fo : cw.getOptions().values()) {
            message.append("<option>");
            message.append("<value>" + fo.getValue() + "</value>");
            message.append("<text>" + fo.getText() + "</text>");
            message.append("<displayOrder>" + fo.getDisplayOrder() + "</displayOrder>");
            message.append("</option>");
        }
        message.append("</options>");
        response.getWriter().write(message.toString());

    }

    /**
     * Check database connection.
     * 
     * @param request
     * @param response
     * @param context
     * @return
     */
    private String checkConnection(HttpServletRequest request, HttpServletResponse response, IContext context) {
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");

        String database = request.getParameter("database");
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        Database db = mc.getDatabase(database);

        String connImpl = db.getConnectionImpl();
        String driver = db.getDriver();
        String url = request.getParameter("url");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        message.append("<status>");
        DatabaseConnection.create(connImpl);
        DatabaseConnection.get().setDriver(driver);
        DatabaseConnection.get().setUrl(url);
        DatabaseConnection.get().setUser(username);
        DatabaseConnection.get().setPassword(password);
        try {
            DatabaseConnection.get().init();
            message.append("OK");
        } catch (Exception e1) {
            e1.printStackTrace();
            message.append(e1);
        }
        message.append("</status>");
        try {
            message.append("</request>");
            response.getWriter().write(message.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return message.toString();
    }

    @Override
    public String dispatch() {
        // TODO Auto-generated method stub
        return null;
    }

}
