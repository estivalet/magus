package dbreveng.database.meta;

import general.util.StringUtils;

public class ForeignKey {

    private Boolean exported;

    private String pkTableName;

    private String pkColumnName;

    private String fkTableName;

    private String fkColumnName;

    private Short sequence;

    private Table fkTable;

    private Table pkTable;

    public String getFkCamelCaseName() {
        return getFkCamelCaseName(false);
    }

    public String getFkCamelCaseName(Boolean capitalize) {
        return StringUtils.toCamelCase(this.fkTableName, capitalize);
    }

    public String getPkCamelCaseName() {
        return getPkCamelCaseName(false);
    }

    public String getPkCamelCaseName(Boolean capitalize) {
        return StringUtils.toCamelCase(this.pkTableName, capitalize);
    }

    /**
     * @return the pkTableName
     */
    public String getPkTableName() {
        return pkTableName;
    }

    /**
     * @param pkTableName
     *            the pkTableName to set
     */
    public void setPkTableName(String pkTableName) {
        this.pkTableName = pkTableName;
    }

    /**
     * @return the pkColumnName
     */
    public String getPkColumnName() {
        return pkColumnName;
    }

    /**
     * @param pkColumnName
     *            the pkColumnName to set
     */
    public void setPkColumnName(String pkColumnName) {
        this.pkColumnName = pkColumnName;
    }

    /**
     * @return the fkTableName
     */
    public String getFkTableName() {
        return fkTableName;
    }

    /**
     * @param fkTableName
     *            the fkTableName to set
     */
    public void setFkTableName(String fkTableName) {
        this.fkTableName = fkTableName;
    }

    /**
     * @return the fkColumnName
     */
    public String getFkColumnName() {
        return fkColumnName;
    }

    public String getFkColumnCamelCase(Boolean capitalize) {
        return StringUtils.toCamelCase(this.fkColumnName, capitalize);
    }

    /**
     * @param fkColumnName
     *            the fkColumnName to set
     */
    public void setFkColumnName(String fkColumnName) {
        this.fkColumnName = fkColumnName;
    }

    /**
     * @return the sequence
     */
    public Short getSequence() {
        return sequence;
    }

    /**
     * @param sequence
     *            the sequence to set
     */
    public void setSequence(Short sequence) {
        this.sequence = sequence;
    }

    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        if (exported) {
            sb.append(this.sequence + ". " + this.pkTableName + "." + this.pkColumnName + "->" + this.fkTableName + "." + this.fkColumnName);
        } else {
            sb.append(this.sequence + ". " + this.fkTableName + "." + this.fkColumnName + "->" + this.pkTableName + "." + this.pkColumnName);
        }
        return sb.toString();
    }

    /**
     * @return the exported
     */
    public Boolean getExported() {
        return exported;
    }

    /**
     * @param exported
     *            the exported to set
     */
    public void setExported(Boolean exported) {
        this.exported = exported;
    }

    public void setPkTable(Table table) {
        this.pkTable = table;
    }

    public void setFkTable(Table table) {
        this.fkTable = table;
    }

    /**
     * @return the fkTable
     */
    public Table getFkTable() {
        return fkTable;
    }

    /**
     * @return the pkTable
     */
    public Table getPkTable() {
        return pkTable;
    }

}
