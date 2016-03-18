/*
 * MagusRAD - Digital Howler Entertainment
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 * Created on 30/08/2011 at 15:50:55 by 88758559000
 */
package org.luisoft.magus.core;

import general.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.Table;

public class ColumnWrapper implements Comparable<ColumnWrapper> {

    private Column column;

    /**
     * Custom field to be displayed in the screen like: text box, combo box, file, link, etc.
     */
    private Integer customFieldType = 0;
    private Integer displayOrder = 0;
    private String label = "";
    private String filter = "N";
    private String visible = "Y";
    private String inputMask = "";
    private String alias = "";

    private Map<String, FieldOption> options = new HashMap<String, FieldOption>();
    private boolean allowMultipleOptions = false;

    public ColumnWrapper(Column column) {
        this.column = column;
    }

    public Table getTable() {
        return this.column.getTable();
    }

    public void setTable(Table table) {
        this.column.setTable(table);

    }

    public TableWrapper getApplicationTable() {
        return new TableWrapper(this.column.getTable());
    }

    public String getTypeName() {
        return column.getTypeName();
    }

    public String getDefaultValue() {
        return column.getDefaultValue();
    }

    /**
     * Used to store options for those columns that are checkbox, radio, select.
     * 
     * @param value
     * @param text
     */
    public void addOption(String value, String text, int displayOrder) {
        FieldOption fo = new FieldOption(value, text, displayOrder);
        options.put(value, fo);
    }

    public Map<String, FieldOption> getOptions() {
        return this.options;
    }

    /**
     * If set to <code>true</code> user can check multiple checkboxes for example.
     * 
     * @param b
     */
    public void setAllowMultipleOptions(boolean b) {
        this.allowMultipleOptions = b;
    }

    /**
     * @return the customFieldType
     */
    public Integer getCustomFieldType() {
        return customFieldType;
    }

    /**
     * @param customFieldType
     *            the customFieldType to set
     */
    public void setCustomFieldType(Integer customFieldType) {
        this.customFieldType = customFieldType;
    }

    /** Wrapper methods for MappedColumn class. */

    public String getCamelCaseName() {
        return this.column.getCamelCaseName();
    }

    public String getCamelCaseName(Boolean capitalize) {
        return this.column.getCamelCaseName(capitalize);
    }

    public Boolean getNullable() {
        return this.column.getNullable();
    }

    public Integer getInputSize() {
        return this.column.getInputSize();
    }

    public Boolean isColumnInForeignKey() {
        return this.column.isColumnInForeignKey();
    }

    public String getForeignTableCamelCase() {
        return this.column.getForeignTableCamelCase();
    }

    public String getForeignTableAlias() {
        return getForeignTableAlias(false);
    }

    public String getForeignTableAlias(Boolean capitalize) {
        Table tmp = new Table();
        tmp.setName(this.column.getForeignTable());
        TableWrapper at = new TableWrapper(tmp);
        return at.getAlias(capitalize);
    }

    public String getForeignTableColumnCamelCase() {
        return this.column.getForeignTableColumnCamelCase();
    }

    public String getForeignTableColumnAlias() {

        ForeignKey fk = this.column.getTable().getForeignKey(this.column.getName());

        Table tmp = new Table();
        tmp.setName(fk.getPkTableName());
        TableWrapper at = new TableWrapper(tmp);

        return StringUtils.toCamelCase(at.getAlias() + "." + fk.getPkColumnName());
    }

    public String getForeignTableColumnPkAlias() {

        ForeignKey fk = this.column.getTable().getForeignKey(this.column.getName());

        Table tmp = new Table();
        tmp.setName(fk.getPkTableName());
        TableWrapper at = new TableWrapper(tmp);

        return StringUtils.toCamelCase(fk.getPkColumnName());
    }

    public String getForeignTable() {
        return this.column.getForeignTable();
    }

    public String getForeignTable(boolean capitalize) {
        return this.column.getForeignTable(capitalize);
    }

    public String getForeignTableColumn() {
        return this.column.getForeignTableColumn();
    }

    public String getJdbcDataType() {
        return this.column.getJdbcDataType();
    }

    public String getPSJavaMethod() {
        return this.column.getPSJavaMethod();
    }

    public String getName() {
        return this.column.getName();
    }

    public String getForeignColumn() {
        return this.column.getForeignColumn();
    }

    public String getForeignColumn(boolean capitalize) {
        return this.column.getForeignColumn(capitalize);
    }

    public Boolean isColumnInPrimaryKey() {
        return this.column.isColumnInPrimaryKey();
    }

    public void setComment(String comment) {
        this.column.setComment(comment);
    }

    public String getComment() {
        if (this.column.getComment() == null) {
            return "";
        }
        return this.column.getComment();
    }

    /**
     * @return the displayOrder
     */
    public Integer getDisplayOrder() {
        if (displayOrder == 0) {
            return column.getOrdinalPosition();
        }
        return displayOrder;
    }

    /**
     * @param displayOrder
     *            the displayOrder to set
     */
    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    /**
     * If no label was set return the default one.
     * 
     * @return the label
     */
    public String getLabel() {
        if ("".equals(label)) {
            return this.getCamelCaseName();
        }
        return label;
    }

    /**
     * @param label
     *            the label to set
     */
    public void setLabel(String label) {
        this.label = label;
    }

    public Boolean isRequired() {
        return !this.column.getNullable();
    }

    /**
     * @return the filter
     */
    public String getFilter() {
        return filter;
    }

    /**
     * @param filter
     *            the filter to set
     */
    public void setFilter(String filter) {
        this.filter = filter;
    }

    /**
     * @return the visible
     */
    public String getVisible() {
        return visible;
    }

    /**
     * @param visible
     *            the visible to set
     */
    public void setVisible(String visible) {
        this.visible = visible;
    }

    /**
     * @return the allowMultipleOptions
     */
    public boolean isAllowMultipleOptions() {
        return allowMultipleOptions;
    }

    @Override
    public int compareTo(ColumnWrapper o) {
        int a = o.getDisplayOrder();
        int b = displayOrder;

        return a > b ? -1 : a < b ? 1 : 0;
    }

    /**
     * @return the inputMask
     */
    public String getInputMask() {
        if (inputMask == null) {
            return "";
        }

        return inputMask;
    }

    /**
     * @param inputMask
     *            the inputMask to set
     */
    public void setInputMask(String inputMask) {
        this.inputMask = inputMask;
    }

    /**
     * @return the alias
     */
    public String getAlias() {
        return alias;
    }

    /**
     * @param alias
     *            the alias to set
     */
    public void setAlias(String alias) {
        this.alias = alias;
    }

    public void setTypeName(String typeName) {
        this.column.setTypeName(typeName);

    }

    public void setDefaultValue(String defaultValue) {
        this.column.setDefaultValue(defaultValue);

    }

}
