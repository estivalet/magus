package dbreveng.database.meta;

import general.util.StringUtils;

public class Column extends NamedObject implements Comparable<Column> {

    /** Bidirectional access... */
    private Table table;

    /** Type from java.sql.Types. */
    private Integer dataType;

    private Integer size;

    private String typeName;

    private Integer decimalDigits;

    private Boolean nullable;

    private Boolean unique;

    private String defaultValue = "";

    private Integer ordinalPosition;

    private String comment;

    public String nullableAsString() {
        return nullable ? "NULL" : "NOT NULL";
    }

    /**
     * @return the size
     */
    public Integer getSize() {
        return size;
    }

    /**
     * @param size
     *            the size to set
     */
    public void setSize(Integer size) {
        this.size = size;
    }

    /**
     * @return the typeName
     */
    public String getTypeName() {
        return typeName;
    }

    /**
     * @param typeName
     *            the typeName to set
     */
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    /**
     * @return the decimalDigits
     */
    public Integer getDecimalDigits() {
        return decimalDigits;
    }

    /**
     * @param decimalDigits
     *            the decimalDigits to set
     */
    public void setDecimalDigits(Integer decimalDigits) {
        this.decimalDigits = decimalDigits;
    }

    /**
     * @return the nullable
     */
    public Boolean getNullable() {
        return nullable;
    }

    /**
     * @param nullable
     *            the nullable to set
     */
    public void setNullable(Boolean nullable) {
        this.nullable = nullable;
    }

    /**
     * @return the unique
     */
    public Boolean getUnique() {
        return unique;
    }

    /**
     * @param unique
     *            the unique to set
     */
    public void setUnique(Boolean unique) {
        this.unique = unique;
    }

    /**
     * @return the dataType
     */
    public Integer getDataType() {
        return dataType;
    }

    /**
     * TODO Shouldnt be here, because it is view specific...REVIEW!
     * 
     * @return
     */
    public Integer getInputSize() {
        if (this.getSize() == 0) {
            return JdbcTypeMapper.getJavaTypeSize(this.getDataType());
        }
        return this.getSize();
    }

    public String getJdbcDataType() {
        return JdbcTypeMapper.getJavaType(this.dataType);
    }

    public String getPSJavaMethod() {
        return JdbcTypeMapper.getPSJavaMethod(this.dataType);
    }

    /**
     * @param dataType
     *            the dataType to set
     */
    public void setDataType(Integer dataType) {
        this.dataType = dataType;
    }

    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("    \n");
        sb.append("     MappedColumn:" + this.name + (table.isColumnInPrimaryKey(this.name) ? " (PK)" : "") + (table.isColumnInForeignKey(this.name) ? " (FK)" + " [" + table.getForeignKey(this.name) + "]" : ""));
        sb.append("    \n");
        sb.append("     Type  :" + this.typeName);
        sb.append("    \n");
        sb.append("     Size  :" + this.size);
        sb.append("    \n");
        sb.append("     Digits:" + this.decimalDigits);
        sb.append("    \n");
        sb.append("     Null  :" + this.nullable);
        sb.append("    \n");

        return sb.toString();
    }

    /**
     * @return the table
     */
    public Table getTable() {
        return table;
    }

    /**
     * @param table
     *            the table to set
     */
    public void setTable(Table table) {
        this.table = table;
    }

    /**
     * @return the defaultValue
     */
    public String getDefaultValue() {
        return defaultValue;
    }

    /**
     * @param defaultValue
     *            the defaultValue to set
     */
    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    /**
     * @return the comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * @param comment
     *            the comment to set
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    public Boolean isColumnInPrimaryKey() {
        return this.getTable().isColumnInPrimaryKey(this.name);
    }

    public Boolean isColumnInForeignKey() {
        return this.getTable().isColumnInForeignKey(this.name);
    }

    public String getForeignColumn() {
        return this.getForeignColumn(false);
    }

    public String getForeignColumn(boolean capitalize) {
        ForeignKey fk = this.getTable().getForeignKey(this.name);
        if (capitalize) {
            return StringUtils.capitalize(fk.getPkColumnName().toLowerCase());
        }
        return fk.getPkColumnName();
    }

    public String getForeignTableColumn() {
        return this.getForeignTableColumn(false);
    }

    public String getForeignTableColumnCamelCase() {
        return StringUtils.toCamelCase(this.getForeignTableColumn(false));
    }

    public String getForeignTableColumn(boolean capitalize) {
        ForeignKey fk = this.getTable().getForeignKey(this.name);
        return fk.getPkTableName() + "." + fk.getPkColumnName();
    }

    public String getForeignTable() {
        return getForeignTable(false);
    }

    public String getForeignTableCamelCase() {
        return StringUtils.toCamelCase(getForeignTable(false));
    }

    public String getForeignTable(boolean capitalize) {
        ForeignKey fk = this.getTable().getForeignKey(this.name);
        if (capitalize) {
            return StringUtils.capitalize(fk.getPkTableName().toLowerCase());
        }
        return fk.getPkTableName();
    }

    /**
     * @return the ordinalPosition
     */
    public Integer getOrdinalPosition() {
        return ordinalPosition;
    }

    /**
     * @param ordinalPosition
     *            the ordinalPosition to set
     */
    public void setOrdinalPosition(Integer ordinalPosition) {
        this.ordinalPosition = ordinalPosition;
    }

    public String sqlValue(Object value) {
        // TODO need to return a SQL string according to the SQL type. For
        // example, you don't need apostrophe for numeric columns. Refactor this
        // code and remove this comment.
        return "'" + value + "'";
    }

    @Override
    public int compareTo(Column o) {
        int a = o.ordinalPosition;
        int b = ordinalPosition;

        return a > b ? -1 : a < b ? 1 : 0;
    }

}
