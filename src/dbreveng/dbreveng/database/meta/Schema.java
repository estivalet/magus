package dbreveng.database.meta;

import java.util.Collection;
import java.util.Formatter;
import java.util.TreeMap;

public class Schema {

    private String name;

    private String catalogName;

    private TreeMap<String, Table> tables = new TreeMap<String, Table>();

    public Schema(String name) {
        this.name = name;
    }

    public void addTable(Table t) {
        this.tables.put(t.getName(), t);
    }

    public Table getTable(String tableName) {
        return this.tables.get(tableName);
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
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
     * @return the tables
     */
    public Collection<Table> getTables() {
        return tables.values();
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
        fmt.format("%nSchema: %s%n", this.name);

        return sb.toString();
    }
}
