package org.luisoft.magus.core;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.PrimaryKey;
import dbreveng.database.meta.Table;
import general.util.StringUtils;

/**
 * Wrapper around MappedTable object to create easier callable methods in the templates.
 * 
 * @author 88758559000
 */
public class TableWrapper {

    /** MappedTable database meta data being wrapped. */
    private Table table;

    private String label;

    private String alias;

    private String orderBy;

    private Boolean exportKeys;

    private Map<String, ColumnWrapper> columns = new HashMap<String, ColumnWrapper>();

    /**
     * @param table
     *            MappedTable database meta data to be wrapped.
     */
    public TableWrapper(Table table) {
        this.table = table;
    }

    public void addColumn(ColumnWrapper column) {
        this.columns.put(column.getName(), column);
    }

    public ColumnWrapper getColumnWrapper(String column) {
        return this.columns.get(column);
    }

    public Collection<ColumnWrapper> getColumnsWrapper() {
        return this.columns.values();
    }

    public Collection<ColumnWrapper> getColumnsWrapper(boolean includePk) {
        List<ColumnWrapper> list = new ArrayList<ColumnWrapper>();

        for (ColumnWrapper cw : this.columns.values()) {
            if (cw.isColumnInPrimaryKey()) {
                if (includePk) {
                    list.add(cw);
                }
            } else {
                list.add(cw);
            }
        }
        return list;
    }

    public List<ColumnWrapper> getOrderedColumnsWrapper(boolean includePk) {
        List<ColumnWrapper> list = new ArrayList<ColumnWrapper>();

        for (ColumnWrapper cw : this.columns.values()) {
            if (cw.isColumnInPrimaryKey()) {
                if (includePk) {
                    list.add(cw);
                }
            } else {
                list.add(cw);
            }
        }

        Collections.sort(list);

        return list;

    }

    public List<ColumnWrapper> getOrderedColumnsWrapper() {
        return getOrderedColumnsWrapper(true);
    }

    public String getAlias() {
        return getAlias(false);
    }

    public String getAlias(Boolean capitalize) {
        String alias = this.table.getCamelCaseName();

        return (capitalize) ? StringUtils.capitalize(alias) : alias;
    }

    public Boolean getExportedKeys(String table) {
        return true;
    }

    /**
     * TODO review.
     * 
     * Check if the column has unique keys. If yes, then return the first unique key besides the primary as the default order by for the table.
     * 
     * @return
     */
    public String getOrderByColumn() {
        if (this.orderBy == null) {
            Collection<Column> uks = this.table.getUniqueKeyColumns();
            for (Column uk : uks) {
                if (!this.table.isColumnInPrimaryKey(uk.getName())) {
                    this.orderBy = uk.getCamelCaseName();
                }
            }
        }
        if (this.orderBy == null) {
            // If not available unique keys try to get the first CHAR column.
            for (Column c : this.table.getColumns(false)) {
                if ("String".equals(c.getJdbcDataType())) {
                    return c.getCamelCaseName();
                }
            }
            return "no_orderby_column_found";
        }

        return this.orderBy;
    }

    /**
     * @return the table
     */
    public Table getTable() {
        return table;
    }

    public Collection<Column> getColumns(boolean includePk) {
        return this.table.getColumns(includePk);
    }

    public String getName() {
        return this.table.getName();
    }

    public TreeMap<String, ForeignKey> getFks() {
        return this.table.getFks();
    }

    public Collection<Column> getPrimaryKeyColumns() {
        return this.table.getPrimaryKeyColumns();
    }

    public TreeMap<String, PrimaryKey> getPks() {
        return this.table.getPks();
    }

    public Boolean hasCompositePK() {
        return this.table.hasCompositePK();
    }

    public String getCamelCaseName() {
        return this.table.getCamelCaseName();
    }

    public String getCamelCaseName(boolean capitalize) {
        return this.table.getCamelCaseName(capitalize);
    }

    public String getPKJdbcType() {
        return this.table.getPKJdbcType();
    }

    public HashMap<String, Column> getColumns() {
        return this.table.getColumns();
    }

    public String listPKsAsCommaSeparated() {
        return this.table.listPKsAsCommaSeparated();
    }

    public String getSQLSelect() {
        return this.table.getSQLSelect();
    }

    public String getSQLFKsSelect() {
        return this.table.getSQLFKsSelect();
    }

    public String getSQLSelectCount() {
        return this.table.getSQLSelectCount();
    }

    public String getSQLSelectByPK() {
        return this.table.getSQLSelectByPK();
    }

    public String getSQLInsert(boolean includePk) {
        return this.table.getSQLInsert(includePk);
    }

    public String getSQLInsert() {
        return this.table.getSQLInsert(false);
    }

    public String getSQLUpdate() {
        return this.table.getSQLUpdate();
    }

    public String getSQLDelete() {
        return this.table.getSQLDelete();
    }

    public Boolean isColumnInPrimaryKey(String name) {
        return this.table.isColumnInPrimaryKey(name);
    }

    public ForeignKey getForeignKey(String name) {
        return this.table.getForeignKey(name);
    }

    /**
     * @return the label
     */
    public String getLabel() {
        return label;
    }

    /**
     * @param label
     *            the label to set
     */
    public void setLabel(String label) {
        this.label = label;
    }

    /**
     * @return the orderBy
     */
    public String getOrderBy() {
        return orderBy;
    }

    /**
     * @param orderBy
     *            the orderBy to set
     */
    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    /**
     * @param alias
     *            the alias to set
     */
    public void setAlias(String alias) {
        this.alias = alias;
    }

    public boolean hasExportedKeys() {
        return this.table.hasExportedKeys();
    }

    public List<TableWrapper> getWrappedFks() {
        ArrayList<TableWrapper> ats = new ArrayList<TableWrapper>();
        for (ForeignKey fk : this.table.getFks().values()) {

            Table tmp = new Table();
            tmp.setName(fk.getPkTableName());
            tmp.setHasExportedKeys(fk.getExported());
            TableWrapper appt = new TableWrapper(tmp);

            ats.add(appt);

        }
        return ats;
    }

    public List<ForeignKey> getExportedForeignKey() {
        return this.table.getExportedForeignKey();
    }

    public Collection<Column> getExportedKeyColumns() {
        return this.table.getExportedKeyColumns();
    }

    public List<ColumnWrapper> getExportedWrappedKeyColumns() {
        List<ColumnWrapper> cols = new ArrayList<ColumnWrapper>();
        for (Column c : this.table.getExportedKeyColumns()) {
            cols.add(new ColumnWrapper(c));
        }
        return cols;
    }

    public String getImportedTableOfExportedTableAsString(Table exportedTable, String columnName) {
        return StringUtils.toCamelCase(this.table.getImportedTableOfExportedTable(exportedTable, columnName).getName(), true);
    }

    public String getImportedTableOfExportedTableAsString(Table exportedTable, String columnName, boolean capitalize) {
        return StringUtils.toCamelCase(this.table.getImportedTableOfExportedTable(exportedTable, columnName).getName(), capitalize);
    }

    public Table getImportedTableOfExportedTable(Table exportedTable, String columnName) {
        return this.table.getImportedTableOfExportedTable(exportedTable, columnName);
    }

    public String getSQLMxN(Table exportedTable, String columnInExportedKey) {
        return this.table.getSQLMxN(exportedTable, columnInExportedKey);
    }

    /**
     * @return the exportKeys
     */
    public Boolean getExportKeys() {
        return exportKeys;
    }

    /**
     * @param exportKeys
     *            the exportKeys to set
     */
    public void setExportKeys(Boolean exportKeys) {
        this.exportKeys = exportKeys;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("       <table name=\"" + this.alias + "\">\n");
        sb.append("           <schema>" + this.getTable().getSchema().getName() + "</schema>\n");
        sb.append("       </table>\n");

        return sb.toString();
    }

}
