package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import java.util.ArrayList;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.Table;

public class DomainDecorator extends TableDecorator {

    /**
     * @param app
     * @param table
     * @param context
     */
    public DomainDecorator(Application app, TableWrapper table, IContext context) {
        super(app, context, "domain", "Domain", table, "");
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
     */
    public void decorateIt() {

        // Get only columns that should be in DTO object.
        ArrayList<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
        ColumnWrapper column = null;
        String clazzPK = "";
        String pkParameters = "";

        // TODO Need to work on tables with composite primary key.
        if (t.hasCompositePK()) {
            // String type = t.getAlias(true) + getParameter("pk.suffix");
            // column = new ColumnWrapper();
            // column.setName(StringUtils.toCamelCase(t.getAlias()));
            // column.setTypeName(type);
            // columns.add(column);
            // clazzPK = type;
            // pkParameters = type + " pk";
        } else {
            clazzPK = t.getPKJdbcType();
            pkParameters = clazzPK + " pk";
        }

        // Get other columns besides primary key.
        for (Column c : t.getColumns().values()) {
            column = new ColumnWrapper(c);
            column.setAlias(StringUtils.toCamelCase(c.getName()));
            column.setTypeName(c.getJdbcDataType());
            column.setTable(t.getTable());

            // Do not add primary key again.
            if (t.hasCompositePK() && !t.isColumnInPrimaryKey(c.getName()) && t.getForeignKey(c.getName()) == null) {
                columns.add(column);
            } else {
                if (t.getForeignKey(c.getName()) != null) {
                    if (t.getForeignKey(c.getName()).getExported()) {
                        columns.add(column);
                    }
                } else {
                    columns.add(column);
                }
            }

            if (t.getForeignKey(c.getName()) != null) {
                Table fktbl = new Table();
                fktbl.setName(t.getForeignKey(c.getName()).getFkTableName());
                TableWrapper fkat = new TableWrapper(fktbl);
                String name = fkat.getAlias();

                // Check if we want to generate field for exported keys.
                boolean exportKeys = false;
                Boolean value = t.getExportedKeys(t.getName());
                if (value != null) {
                    exportKeys = t.getExportedKeys(t.getName());
                }

                if (exportKeys) {
                    String iface = getParameter("collection.interface");
                    String impl = getParameter("collection.implementation");
                    if (t.getForeignKey(c.getName()).getExported()) {
                        // Set plural since we have an array of objects.
                        column = new ColumnWrapper(c);
                        column.setAlias(name + "s");
                        column.setTypeName(iface.replace("?", StringUtils.capitalize(name)));
                        column.setDefaultValue(" = new " + impl.replace("?", StringUtils.capitalize(name)) + "(0)");
                        column.setTable(t.getTable());
                    } else {
                        ForeignKey fk = t.getForeignKey(c.getName());
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
                String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn(), true);
                model.put(key, value);

            }

        }

        model.put("clazz", t.getAlias(true));
        model.put("clazzPK", clazzPK);
        model.put("pkParameters", pkParameters);
        model.put("columnList", columns);
    }
}
