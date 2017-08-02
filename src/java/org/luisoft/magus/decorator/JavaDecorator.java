package org.luisoft.magus.decorator;

import java.util.ArrayList;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.Table;
import general.server.IContext;
import general.util.StringUtils;

public class JavaDecorator extends BaseDecorator {

    public JavaDecorator(Application app, IContext context, String templateFileName, String destFileName) {
        super(app, context, templateFileName, destFileName);
    }

    protected ArrayList<ColumnWrapper> getTableColumns(Long appId, IContext context, TableWrapper table) {
        ArrayList<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
        for (Column c : table.getColumns().values()) {
            System.out.println("Decorating column " + c.getName() + " from table " + table.getName());
            ColumnWrapper column = table.getColumnWrapper(c.getName());
            column.setAlias(StringUtils.toCamelCase(c.getName()));
            column.setTypeName(c.getJdbcDataType());
            column.setTable(table.getTable());

            // Do not add primary key again.
            if (table.hasCompositePK() && !table.isColumnInPrimaryKey(c.getName()) && table.getForeignKey(c.getName()) == null) {
                columns.add(column);
            } else {
                if (table.getForeignKey(c.getName()) != null) {
                    if (table.getForeignKey(c.getName()).getExported()) {
                        columns.add(column);
                    }
                } else {
                    columns.add(column);
                }
            }

            if (table.getForeignKey(c.getName()) != null) {
                Table fktbl = new Table();
                fktbl.setName(table.getForeignKey(c.getName()).getFkTableName());
                TableWrapper fkat = new TableWrapper(fktbl);
                String name = fkat.getAlias();

                // Check if we want to generate field for exported keys.
                boolean exportKeys = false;
                Boolean value = table.getExportedKeys(table.getName());
                if (value != null) {
                    exportKeys = table.getExportedKeys(table.getName());
                }

                if (exportKeys) {
                    String iface = getParameter("collection.interface");
                    String impl = getParameter("collection.implementation");
                    if (table.getForeignKey(c.getName()).getExported()) {
                        // Set plural since we have an array of objects.
                        column = new ColumnWrapper(c);
                        column.setAlias(name + "s");
                        column.setTypeName(iface.replace("?", StringUtils.capitalize(name)));
                        column.setDefaultValue(" = new " + impl.replace("?", StringUtils.capitalize(name)) + "(0)");
                        column.setTable(table.getTable());
                    } else {
                        ForeignKey fk = table.getForeignKey(c.getName());
                        Table pktbl = new Table();
                        pktbl.setName(fk.getPkTableName());
                        TableWrapper pkat = new TableWrapper(pktbl);
                        name = pkat.getAlias();

                        column.setAlias(name);
                        column.setTypeName(StringUtils.capitalize(name));
                    }
                    System.out.println("Adding exported key " + column.getName() + " from table " + table.getName());
                    columns.add(column);
                }
            }

            if (c.isColumnInForeignKey()) {
                // Load foreign table.
                ApplicationMapper am = new ApplicationMapper();
                am.setContext(context);
                TableWrapper foreignTable = am.fetchApplicationTable(appId, c.getForeignTable());

                String key = c.getCamelCaseName() + "_fk_display";
                String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn(), false);
                super.addTemplateVariable(key, value);

                key = c.getCamelCaseName() + "_fk_id";
                value = StringUtils.toCamelCase(foreignTable.listPKsAsCommaSeparated());
                super.addTemplateVariable(key, value);

                System.out.println("Adding column foregin key _fk_id " + key + " = " + value);

            }

            if (c.isColumnInExportedKey()) {
                // Load foreign table.
                ApplicationMapper am = new ApplicationMapper();
                am.setContext(context);

                TableWrapper foreignTable = am.fetchApplicationTable(appId, c.getTable().getImportedTableOfExportedTable(c.getExportedTable(), c.getColumnInExportedKey()).getName());

                String key = foreignTable.getCamelCaseName() + c.getCamelCaseName() + "_efk_display";
                String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn(), false);
                System.out.println("Foreign table " + foreignTable.getName() + " Adding column exported key _efk_display " + key + " = " + value);
                super.addTemplateVariable(key, value);

                key = c.getCamelCaseName() + "_efk_id";
                value = StringUtils.toCamelCase(foreignTable.listPKsAsCommaSeparated());
                super.addTemplateVariable(key, value);

                System.out.println("Foreign table " + foreignTable.getName() + " Adding column exported key _efk_id " + key + " = " + value);

            }

        }
        return columns;
    }

    protected void getFKColumns(Long appId, IContext context, TableWrapper table) {
        // TODO Warning getting only the first exported key.
        if (table.hasExportedKeys()) {
            ForeignKey fk = (ForeignKey) table.getExportedForeignKey().iterator().next();
            super.addTemplateVariable("fk", fk);

            ApplicationMapper am = new ApplicationMapper();
            TableWrapper fktable = new TableWrapper(fk.getFkTable());
            fktable = am.fetchApplicationTable(appId, fktable);

            super.addTemplateVariable("fkTableColumns", fktable.getColumnsWrapper());
        }
    }

}
