package dbreveng.database.meta;

import general.util.StringUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;

/**
 * @author luisoft
 * 
 */
public class Table extends NamedObject {

    /** MappedTable's catalog. */
    private String catalogName;

    /** MappedTable's schema. */
    // private String schemaName;
    private Schema schema;

    /** MappedTable's database. */
    private String databaseName;

    private Boolean hasExportedKeys = false;

    /** Hash here because we dont need to order the column names. */
    private HashMap<String, Column> columns = new HashMap<String, Column>();

    /** Could be Hash also. */
    private TreeMap<String, PrimaryKey> pks = new TreeMap<String, PrimaryKey>();

    /** Could be Hash also. */
    private TreeMap<String, UniqueKey> uks = new TreeMap<String, UniqueKey>();

    /** Could be Hash also. */
    private TreeMap<String, ForeignKey> fks = new TreeMap<String, ForeignKey>();

    /**
     * When primary key is a single column then this method returns the JDBC data type concatenated with the java attribute name.
     * 
     * @return
     */
    public String getPKJdbcType() {
        if (!this.hasCompositePK() && this.pks != null && this.pks.size() == 1) {
            return this.pks.values().iterator().next().getColumn().getJdbcDataType();
        }
        return null;

    }

    // public String listPKsAsCommaSeparatedJdbc() {
    // StringBuffer sb = new StringBuffer();
    // int i = 0;
    // for (PrimaryKey pk : this.pks.values()) {
    // MappedColumn column = pk.getColumn();
    // String typeAndName = column.getJdbcDataType() + " "
    // + column.getCamelCaseName();
    // sb.append((i > 0) ? ", " + typeAndName : typeAndName);
    // i++;
    // }
    // return sb.toString();
    // }

    /**
     * Creates a SELECT columns FROM table statement to be used in a JDBC prepared statement.
     * 
     * @return
     */
    public String getSQLSelect() {
        StringBuffer sb = new StringBuffer("SELECT ");
        // MySQL should be the database name configured in mysql.properties
        // file.
        if ("MySQL".equals(this.getDatabaseName())) {
            // To allow get total records when using LIMIT (MySQL specific).
            sb.append("SQL_CALC_FOUND_ROWS ");
        }
        sb.append(this.listColumnsAsCommaSeparated(this.columns.values(), false, false));
        sb.append(" FROM " + this.schema.getName() + "." + this.name);
        return sb.toString();
    }

    public String getSQLFKsSelect() {
        StringBuffer sb = new StringBuffer("SELECT ");
        // MySQL should be the database name configured in mysql.properties
        // file.
        if ("MySQL".equals(this.getDatabaseName())) {
            // To allow get total records when using LIMIT (MySQL specific).
            sb.append("SQL_CALC_FOUND_ROWS ");
        }
        sb.append(this.listColumnsAsCommaSeparated(this, this.getName() + "."));
        for (ForeignKey fk : getFks().values()) {
            if (!fk.getFkTable().getName().equals(this.getName())) {
                sb.append(", " + listColumnsAsCommaSeparated(fk.getFkTable(), fk.getFkTable().getName() + "."));
            }
        }
        sb.append(" FROM " + this.schema.getName() + "." + this.name + " " + this.name);
        for (ForeignKey fk : getFks().values()) {
            if (!fk.getFkTable().getName().equals(this.getName())) {
                sb.append("," + this.schema.getName() + "." + fk.getFkTableName() + " " + fk.getFkTableName());
            }
            if (!fk.getPkTableName().equals(this.getName())) {
                sb.append("," + this.schema.getName() + "." + fk.getPkTableName() + " " + fk.getPkTableName());
            }
        }
        sb.append(" WHERE 1=1 ");
        for (ForeignKey fk : getFks().values()) {
            sb.append(" AND " + fk.getFkTableName() + "." + fk.getFkColumnName() + " = " + fk.getPkTableName() + "." + fk.getPkColumnName());
        }

        return sb.toString();
    }

    private String listColumnsAsCommaSeparated(Table table, String prefix) {
        return this.listColumnsAsCommaSeparated(table.getColumns(true), false, false, prefix, true);
    }

    public String getSQLSelectCount() {
        return "SELECT COUNT(*) FROM " + this.schema.getName() + "." + this.name;
    }

    /**
     * Creates a SELECT columns FROM table statement to be used in a JDBC prepared statement.
     * 
     * @return
     */
    public String getSQLSelectByPK() {
        StringBuffer sb = new StringBuffer("SELECT ");
        sb.append(this.listColumnsAsCommaSeparated(this.columns.values(), false, false));
        sb.append(" FROM " + this.schema.getName() + "." + this.name);
        sb.append(" WHERE " + this.listColumnsAsCommaSeparated(this.getPrimaryKeyColumns(), true, false));
        return sb.toString();
    }

    /**
     * Creates a INSERT INTO statement to be used in a JDBC prepared statement.
     * 
     * @param includePk
     *            Option to include or not primary key columns.
     * @return
     */
    public String getSQLInsert(boolean includePk) {
        StringBuffer sb = new StringBuffer("INSERT INTO " + this.schema.getName() + "." + this.name + "(");
        String columns = this.listColumnsAsCommaSeparated(this.getOrderedColumns(includePk), false, false);
        sb.append(columns);
        sb.append(") VALUES (" + StringUtils.repeatChar('?', StringUtils.countChars(columns, ',') + 1, ",") + ")");
        return sb.toString();

    }

    /**
     * Creates a UPDATE statement to be used in a JDBC prepared statement.
     * 
     * @return
     */
    public String getSQLUpdate() {
        StringBuffer sb = new StringBuffer("UPDATE " + this.schema.getName() + "." + this.name + " SET ");
        sb.append(this.listColumnsAsCommaSeparated(this.getOrderedColumns(false), true, false));
        sb.append(" WHERE " + this.listColumnsAsCommaSeparated(this.getPrimaryKeyColumns(), true, false));
        return sb.toString();
    }

    /**
     * Creates a DELETE statement to be used in a JDBC prepared statement.
     * 
     * @return
     */
    public String getSQLDelete() {
        StringBuffer sb = new StringBuffer("DELETE FROM " + this.schema.getName() + "." + this.name);
        sb.append(" WHERE " + this.listColumnsAsCommaSeparated(this.getPrimaryKeyColumns(), true, false));
        return sb.toString();
    }

    /**
     * Return a String of columns.
     * 
     * @param mask
     *            Indicates mask usage for JDBC prepared statements.
     * @param includePk
     *            If <code>true</code> include primary key columns.
     * @return If mask <code>false</code> return the following format: COLUMN_1, COLUMN_2, COLUMN_3, ..., COLUMN_N. If mask <code>true</code> return: COLUMN_1 = ?, COLUMN_2 = ?, COLUMN_3 = ?, ...,
     *         COLUMN_N = ?
     */
    private String listColumnsAsCommaSeparated(Collection<Column> columns, boolean mask, boolean camelCase, String prefix, boolean suffix) {
        StringBuffer sb = new StringBuffer();
        int i = 0;
        for (Column c : columns) {
            String s = ((prefix != null) ? prefix : "") + (camelCase ? c.getCamelCaseName(true) : c.getName()) + ((suffix) ? " " + c.getName() : "") + (mask ? " = ?" : "");
            sb.append((i++ > 0) ? ", " + s : s);
        }
        return sb.toString();
    }

    private String listColumnsAsCommaSeparated(Collection<Column> columns, boolean mask, boolean camelCase) {
        return this.listColumnsAsCommaSeparated(columns, mask, camelCase, null, false);
    }

    /**
     * @return
     */
    public String listPKsAsCommaSeparated(boolean camelCase) {
        return this.listColumnsAsCommaSeparated(this.getPrimaryKeyColumns(), false, camelCase);
    }

    public String listPKsAsCommaSeparated() {
        return this.listColumnsAsCommaSeparated(this.getPrimaryKeyColumns(), false, false);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        Formatter fmt = new Formatter(sb);
        fmt.format("%nTable: %s%n", this.name);
        fmt.format("  * ----------------------------------------------------------------------------%n");
        // The counter (i) was added to avoid printing a blank line after the
        // last column.
        for (Column c : this.columns.values()) {
            fmt.format("  *   MappedColumn: %-20s %-10s %-10s %5s %-10s%n", c.getName(), c.getTypeName(), c.nullableAsString(), c.getSize(), (this.isColumnInPrimaryKey(c.getName()) ? " (PK)" : "")
                    + (this.isColumnInForeignKey(c.getName()) ? " (FK)" + " [" + this.getForeignKey(c.getName()) + "]" : ""));
        }

        return sb.toString();
    }

    /**
     * @param c
     */
    public void addColumn(Column c) {
        this.columns.put(c.getName(), c);
    }

    /**
     * @return
     */
    public Boolean hasCompositePK() {
        return this.pks.size() > 1;
    }

    /**
     * @return the pks
     */
    public TreeMap<String, PrimaryKey> getPks() {
        return pks;
    }

    /**
     * @param columns
     */
    public void addColumn(List<Column> columns) {
        for (Column c : columns) {
            this.addColumn(c);
        }
    }

    /**
     * @param fks
     */
    public void addImportedForeignKey(List<ForeignKey> fks) {
        for (ForeignKey fk : fks) {
            this.addImportedForeginKey(fk);
        }
    }

    /**
     * @param fk
     */
    public void addImportedForeginKey(ForeignKey fk) {
        this.fks.put(fk.getFkColumnName(), fk);
    }

    /**
     * @param fks
     */
    public void addExportedForeignKey(List<ForeignKey> fks) {
        if (!fks.isEmpty()) {
            this.hasExportedKeys = true;
            for (ForeignKey fk : fks) {
                this.addExportedForeginKey(fk);
            }
        }
    }

    public List<ForeignKey> getExportedForeignKey() {
        List<ForeignKey> fks = new ArrayList<ForeignKey>();
        for (ForeignKey fk : this.fks.values()) {
            if (fk.getExported()) {
                fks.add(fk);
            }
        }

        return fks;
    }

    /**
     * @param fk
     */
    private void addExportedForeginKey(ForeignKey fk) {
        // this.hasExportedKeys = true;
        // this.fks.put(fk.getPkColumnName(), fk);
        this.fks.put(fk.getFkTableName(), fk);
    }

    /**
     * @param columnName
     * @return
     */
    public Column getColumn(String columnName) {
        return this.columns.get(columnName);
    }

    /**
     * @param pks
     */
    public void addPrimaryKey(List<PrimaryKey> pks) {
        for (PrimaryKey pk : pks) {
            this.addPrimaryKey(pk);
        }
    }

    public void addUniqueKey(List<UniqueKey> uks) {
        for (UniqueKey uk : uks) {
            this.addUniqueKey(uk);
        }
    }

    /**
     * @param pk
     */
    public void addPrimaryKey(PrimaryKey pk) {
        this.pks.put(pk.getColumn().getName(), pk);
    }

    public void addUniqueKey(UniqueKey uk) {
        this.uks.put(uk.getColumn().getName(), uk);
    }

    /**
     * @param columnName
     * @return
     */
    public Boolean isColumnInPrimaryKey(String columnName) {
        return this.pks.containsKey(columnName);
    }

    /**
     * Get columns that are part of the primary key.
     * 
     * @return
     */
    public Collection<Column> getPrimaryKeyColumns() {
        Collection<Column> columns = new ArrayList<Column>();
        for (PrimaryKey pk : pks.values()) {
            columns.add(pk.getColumn());
        }
        return columns;
    }

    /**
     * Get columns that are declared as unique for the table.
     * 
     * @return
     */
    public Collection<Column> getUniqueKeyColumns() {
        Collection<Column> columns = new ArrayList<Column>();
        for (UniqueKey uk : uks.values()) {
            columns.add(uk.getColumn());
        }
        return columns;
    }

    public Collection<Column> getExportedKeyColumns() {
        Collection<Column> columns = new ArrayList<Column>();
        for (ForeignKey fk : fks.values()) {
            if (fk.getExported()) {
                System.out.println("xxxx " + fk.getFkTableName() + " " + fk.getFkColumnName());
                columns.add(fk.getFkTable().getColumn(fk.getFkColumnName()));
            }
        }
        return columns;
    }

    /**
     * @param columnName
     * @return
     */
    public Boolean isColumnInForeignKey(String columnName) {
        if (!this.fks.containsKey(columnName)) {
            return false;
        }
        return !this.fks.get(columnName).getExported();
    }

    /**
     * @param columnName
     * @return
     */
    public ForeignKey getForeignKey(String columnName) {
        return this.fks.get(columnName);
    }

    /**
     * @return the columns
     */
    public HashMap<String, Column> getColumns() {
        return columns;
    }

    /**
     * Get columns.
     * 
     * @param includePk
     *            Should the result include primary key columns?
     * @return
     */
    public Collection<Column> getColumns(boolean includePk) {
        Collection<Column> columns = new ArrayList<Column>();
        for (Column column : this.columns.values()) {
            boolean include = true;
            if (this.isColumnInPrimaryKey(column.getName()) && !includePk) {
                include = false;
            }
            if (include) {
                columns.add(column);
            }
        }
        return columns;
    }

    private List<Column> getOrderedColumns(boolean includePk) {
        List<Column> columns = new ArrayList<Column>();
        for (Column column : this.columns.values()) {
            boolean include = true;
            if (this.isColumnInPrimaryKey(column.getName()) && !includePk) {
                include = false;
            }
            if (include) {
                columns.add(column);
            }
        }
        Collections.sort(columns);

        return columns;
    }

    /**
     * @return the catalogName
     */
    public String getCatalogName() {
        return catalogName;
    }

    /**
     * @param catalogName
     *            the catalogName to set
     */
    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
    }

    /**
     * @return the schemaName
     */
    public Schema getSchema() {
        return schema;
    }

    /**
     * @param schemaName
     *            the schemaName to set
     */
    public void setSchema(Schema schema) {
        this.schema = schema;
    }

    /**
     * @return the fks
     */
    public TreeMap<String, ForeignKey> getFks() {
        return fks;
    }

    /**
     * @return
     */
    public String getDatabaseName() {
        return databaseName;
    }

    /**
     * @param databaseName
     */
    public void setDatabaseName(String databaseName) {
        this.databaseName = databaseName;
    }

    public Boolean hasExportedKeys() {
        return this.hasExportedKeys;
    }

    public void setHasExportedKeys(Boolean hasExportedKeys) {
        this.hasExportedKeys = hasExportedKeys;
    }
}
