package org.luisoft.magus.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import general.server.IContext;
import general.util.DateUtils;
import general.util.StringUtils;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.Table;

public class Decorator {

    private String path;

    private Application app;

    private TableWrapper table;

    private IContext context;

    private Map<String, Object> model;

    private String templateFileName;

    private String destFileName;

    public Decorator(Application app, IContext context, String templateFileName, String path, String destFileName) {
        this.app = app;
        this.context = context;
        this.model = new HashMap<String, Object>();
        this.destFileName = destFileName;
        this.path = app.getFullPath() + this.destFileName;
        if (path != null) {
            this.path = path + destFileName;
        }
        this.templateFileName = templateFileName;
        this.setUpTemplateVariables();
    }

    public Decorator(Application app, TableWrapper table, IContext context, String templateFileName, String path, String destFileName) {
        this(app, context, templateFileName, path, destFileName);
        this.table = table;
        this.setUpTemplateVariables2();
    }

    private void setUpTemplateVariables() {
        model.put("date", DateUtils.getToday(getParameter("date.format")));
        model.put("app", app);
        model.put("classpath", getParameter("class.path").split(","));
    }

    private void setUpTemplateVariables2() {
        model.put("collection", getParameter("collection"));
        model.put("recordsPerPage", getParameter("records.per.page"));
        model.put("clazzArray", getParameter("collection.interface").replace("?", this.table.getAlias(true)));
        model.put("clazzImplementation", getParameter("collection.implementation").replace("?", this.table.getAlias(true)));

        model.put("clazzName", destFileName.substring(destFileName.lastIndexOf("/") + 1, destFileName.lastIndexOf(".")));
        model.put("clazz", this.table);
        model.put("clazzDomainName", this.table.getAlias(true));

        // Collections.sort(this.table.getColumnsWrapper(), new Comparator<ColumnWrapper>() {
        // public int compare(ColumnWrapper o1, ColumnWrapper o2) {
        // return o1.getDisplayOrder() - o2.getDisplayOrder();
        // }
        // });
        // model.put("columns", this.table.getColumnsWrapper());
        model.put("columns", this.table.getOrderedColumnsWrapper(true));

        // TODO Warning! Getting only the first PK, need to check what to do if a table has more than one PK.
        model.put("pks", this.table.getPrimaryKeyColumns().iterator().next());
        model.put("fks", this.table.getWrappedFks());
        model.put("pkColumns", this.table.getPrimaryKeyColumns());
        model.put("columnsMinusPk", this.table.getOrderedColumnsWrapper(false));
        // TODO Warning getting only the first exported key.
        if (this.table.hasExportedKeys()) {
            // ForeignKey fk = (ForeignKey) this.table.getFks().values().iterator().next();
            ForeignKey fk = (ForeignKey) this.table.getExportedForeignKey().iterator().next();
            model.put("fk", fk);

            ApplicationMapper am = new ApplicationMapper();
            TableWrapper fktable = new TableWrapper(fk.getFkTable());
            fktable = am.fetchApplicationTable(app.getId(), fktable);

            System.out.println("TABLE-->" + this.table.getAlias() + " " + fk.getFkTable().getName());

            // model.put("fkTableColumns", fktable.getOrderedColumnsWrapper());
            model.put("fkTableColumns", fktable.getColumnsWrapper());
        }
        //

        for (ColumnWrapper c : this.table.getColumnsWrapper()) {
            if (!c.isColumnInPrimaryKey()) {
                // If a column is in a foreign key to other table then we need to
                // add a special key in the template to build a combo box for
                // listing foreign table column values.
                if (c.isColumnInForeignKey()) {
                    // Load foreign table.
                    ApplicationMapper am = new ApplicationMapper();
                    am.setContext(context);
                    TableWrapper foreignTable = am.fetchApplicationTable(app.getId(), c.getForeignTable());

                    String key = c.getCamelCaseName() + "_fk_display";
                    String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn());
                    model.put(key, value);

                    key = c.getCamelCaseName() + "_fk_id";
                    value = StringUtils.toCamelCase(foreignTable.listPKsAsCommaSeparated());
                    model.put(key, value);

                }
            }
        }

        //
        //
        ArrayList<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
        for (Column c : this.table.getColumns().values()) {
            ColumnWrapper column = new ColumnWrapper(c);
            column.setAlias(StringUtils.toCamelCase(c.getName()));
            column.setTypeName(c.getJdbcDataType());
            column.setTable(this.table.getTable());

            // Do not add primary key again.
            if (this.table.hasCompositePK() && !this.table.isColumnInPrimaryKey(c.getName()) && this.table.getForeignKey(c.getName()) == null) {
                columns.add(column);
            } else {
                if (this.table.getForeignKey(c.getName()) != null) {
                    if (this.table.getForeignKey(c.getName()).getExported()) {
                        columns.add(column);
                    }
                } else {
                    columns.add(column);
                }
            }

            if (this.table.getForeignKey(c.getName()) != null) {
                Table fktbl = new Table();
                fktbl.setName(this.table.getForeignKey(c.getName()).getFkTableName());
                TableWrapper fkat = new TableWrapper(fktbl);
                String name = fkat.getAlias();

                // Check if we want to generate field for exported keys.
                boolean exportKeys = false;
                Boolean value = this.table.getExportedKeys(this.table.getName());
                if (value != null) {
                    exportKeys = this.table.getExportedKeys(this.table.getName());
                }

                if (exportKeys) {
                    String iface = getParameter("collection.interface");
                    String impl = getParameter("collection.implementation");
                    if (this.table.getForeignKey(c.getName()).getExported()) {
                        // Set plural since we have an array of objects.
                        column = new ColumnWrapper(c);
                        column.setAlias(name + "s");
                        column.setTypeName(iface.replace("?", StringUtils.capitalize(name)));
                        column.setDefaultValue(" = new " + impl.replace("?", StringUtils.capitalize(name)) + "(0)");
                        column.setTable(this.table.getTable());
                    } else {
                        ForeignKey fk = this.table.getForeignKey(c.getName());
                        Table pktbl = new Table();
                        pktbl.setName(fk.getPkTableName());
                        TableWrapper pkat = new TableWrapper(pktbl);
                        name = pkat.getAlias();

                        column.setAlias(name);
                        column.setTypeName(StringUtils.capitalize(name));
                    }
                    columns.add(column);
                }
            }

            if (c.isColumnInForeignKey()) {
                // Load foreign table.
                ApplicationMapper am = new ApplicationMapper();
                am.setContext(context);
                TableWrapper foreignTable = am.fetchApplicationTable(app.getId(), c.getForeignTable());

                String key = c.getCamelCaseName() + "_fk_display";
                // String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn(), true);
                String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn(), false);
                model.put(key, value);

            }

        }
        model.put("allColumns", columns);

    }

    public String decorate() throws Exception {
        Configuration cfg = (Configuration) context.getAttribute(MagusServlet.FREEMARKER_CONFIG);
        Template temp = cfg.getTemplate(templateFileName);
        StringWriter out = new StringWriter();
        temp.process(model, out);
        out.flush();

        return out.toString();
    }

    private String getParameter(String parameterName) {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        return mc.getParameter(parameterName);
    }

    /**
     * @return the path
     */
    public String getPath() {
        return path;
    }

}
