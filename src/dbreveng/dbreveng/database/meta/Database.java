package dbreveng.database.meta;

import java.util.Collection;
import java.util.List;
import java.util.TreeMap;

public class Database {

    private String productName;

    private String productVersion;

    private Integer majorVersion;

    private Integer minorVersion;

    private DatabaseDriver databaseDriver;

    private TreeMap<String, Catalog> catalogs = new TreeMap<String, Catalog>();

    /** Current working currentCatalog. */
    private String currentCatalog;

    /** Current working currentSchema. */
    private String currentSchema;

    /**
     * Add new currentCatalog to the database.
     * 
     * @param currentCatalog
     *            Catalog to be added.
     */
    public void addCatalog(Catalog catalog) {
        this.catalogs.put(catalog.getName(), catalog);
        this.currentCatalog = catalog.getName();
    }

    public void addCatalog(List<Catalog> catalogs) {
        for (Catalog c : catalogs) {
            this.addCatalog(c);
        }
    }

    public void addSchema(String catalogName, Schema schema) {
        this.catalogs.get(catalogName).addSchema(schema);
        this.currentCatalog = catalogName;
        this.currentSchema = schema.getName();
    }

    public void addSchema(List<Schema> schemas) {
        for (Schema s : schemas) {
            this.addSchema(s.getCatalogName(), s);
        }
    }

    /**
     * Wrapper method for adding a table in current catalog/schema.
     * 
     * @param table
     *            MappedTable to be added.
     */
    public void addTable(Table table) {
        getCurrentSchema().addTable(table);
    }

    public Table getTable(String tableName) {
        return getCurrentSchema().getTable(tableName);
    }

    public void addTable(List<Table> tables) {
        for (Table t : tables) {
            this.addTable(t);
        }
    }

    /**
     * @return Current schema for current catalog.
     */
    public Schema getCurrentSchema() {
        return getCurrentCatalog().getSchema(this.currentSchema);
    }

    public Collection<Table> getTables() {
        return getCurrentSchema().getTables();
    }

    /**
     * @return Current catalog.
     */
    public Catalog getCurrentCatalog() {
        return this.catalogs.get(currentCatalog);
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName
     *            the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the productVersion
     */
    public String getProductVersion() {
        return productVersion;
    }

    /**
     * @param productVersion
     *            the productVersion to set
     */
    public void setProductVersion(String productVersion) {
        this.productVersion = productVersion;
    }

    /**
     * @return the majorVersion
     */
    public Integer getMajorVersion() {
        return majorVersion;
    }

    /**
     * @param majorVersion
     *            the majorVersion to set
     */
    public void setMajorVersion(Integer majorVersion) {
        this.majorVersion = majorVersion;
    }

    /**
     * @return the minorVersion
     */
    public Integer getMinorVersion() {
        return minorVersion;
    }

    /**
     * @param minorVersion
     *            the minorVersion to set
     */
    public void setMinorVersion(Integer minorVersion) {
        this.minorVersion = minorVersion;
    }

    /**
     * @return the databaseDriver
     */
    public DatabaseDriver getDatabaseDriver() {
        return databaseDriver;
    }

    /**
     * @param databaseDriver
     *            the databaseDriver to set
     */
    public void setDatabaseDriver(DatabaseDriver databaseDriver) {
        this.databaseDriver = databaseDriver;
    }

    /**
     * @param currentCatalog
     *            the currentCatalog to set
     */
    public void setCurrentCatalog(String currentCatalog) {
        this.currentCatalog = currentCatalog;
    }

    /**
     * @param currentSchema
     *            the currentSchema to set
     */
    public void setCurrentSchema(String currentSchema) {
        this.currentSchema = currentSchema;
    }

    /**
     * @return the catalogs
     */
    public TreeMap<String, Catalog> getCatalogs() {
        return catalogs;
    }

    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("Database: " + this.productName + " Version: " + this.productVersion + "\n");

        for (Catalog c : this.catalogs.values()) {
            sb.append(c);
            for (Schema s : c.getSchemas().values()) {
                sb.append(s);
                for (Table t : s.getTables()) {
                    sb.append(t);
                }
            }
        }

        return sb.toString();
    }

}
