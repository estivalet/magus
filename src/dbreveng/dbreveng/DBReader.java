package dbreveng;

import general.util.PropertyLoader;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import dbreveng.database.DatabaseConnection;
import dbreveng.database.meta.Catalog;
import dbreveng.database.meta.Column;
import dbreveng.database.meta.Database;
import dbreveng.database.meta.DatabaseDriver;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.PrimaryKey;
import dbreveng.database.meta.Schema;
import dbreveng.database.meta.Table;
import dbreveng.database.meta.UniqueKey;

/**
 * @author luisoft
 * 
 */
public class DBReader {

    /** */
    private String dbShortName;

    private String dbFactoryName;

    private String dbConnectionImplementation;

    private String dbTestScript;

    // //////////////////////////////

    // private Connection connection;

    private DatabaseMetaData md;

    private Database db;

    /** Holds only the selected tables to work on. */
    // private Set<MappedTable> tables;

    private static final String CONFIG_FILE = "config.properties";

    public static final String DB_DRIVER_CONFIG = "db.driver.config";

    public static final String DB_FACTORY = "db.factory";

    public static final String DB_IMPLEMENTATION = "db.implementation";

    public static final String DB_DRIVER = "db.driver";

    public static final String DB_URL = "db.url";

    public static final String DB_USER = "db.user";

    public static final String DB_PASSWORD = "db.password";

    public static final String DB_TEST_SCRIPT = "db.test.script";

    private String workingCatalog;
    private String workingSchema;

    public static PropertyLoader config;
    static {
        try {
            // File f = new File(CONFIG_FILE);
            // if (f.exists()) {
            config = new PropertyLoader(CONFIG_FILE);
            if (config.getProperty(DB_DRIVER_CONFIG) != null) {
                config.addProperties(config.getProperty(DB_DRIVER_CONFIG));
            }
            // } else {
            // System.out.println("[DBReader] WARNING: " + CONFIG_FILE
            // + " not found!");
            // }
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    public void readDatabase(String driver, String url, String user, String pass) throws Exception {
        System.out.println("****************************************READING DATABASE!!!!!!!!!!!!!!!!!!!!!!!");
        DatabaseConnection.create(this.dbConnectionImplementation);
        DatabaseConnection.get().setDriver(driver);
        DatabaseConnection.get().setUrl(url);
        DatabaseConnection.get().setUser(user);
        DatabaseConnection.get().setPassword(pass);
        DatabaseConnection.get().init();
        md = DatabaseConnection.get().getConnection().getMetaData();
        retrieveDatabase();
    }

    public Connection getConnection() throws Exception {
        return DatabaseConnection.get().getConnection();
    }

    // public void setWorkingSchema(String schema) {
    // this.db.setCurrentSchema(schema);
    // }
    //
    // public void setWorkingCatalog(String catalog) {
    // this.db.setCurrentCatalog(catalog);
    // }

    /**
     * @param tables
     */
    // public void setWorkingTables(Set<MappedTable> tables) {
    // this.tables = tables;
    // }

    public Table getTable(String tableName) {
        return db.getTable(tableName);
    }

    /**
     * @return Current Database.
     */
    public Database getDatabase() {
        return this.db;
    }

    /**
     * @return All tables from current Database.
     */
    public Collection<Table> getTables() {
        return this.db.getTables();
    }

    /**
     * Important notice about Oracle and MySQL:
     * 
     * Oracle treats schema as a database name, while MySQL treats catalog as a database name. So, to get the name of databases from Oracle, you must use getSchemas(); to get the name of databases
     * from MySQL,you must use getCatalogs()
     * 
     * @return
     * @throws Exception
     */
    private Database retrieveDatabase() throws Exception {
        db = new Database();

        System.out.println("[DBReader] INFO: Database type " + md.getDatabaseProductName());
        db.setProductName(md.getDatabaseProductName());
        db.setProductVersion(md.getDatabaseProductVersion());
        db.setMajorVersion(md.getDatabaseMajorVersion());
        db.setMinorVersion(md.getDatabaseMinorVersion());

        DatabaseDriver dbDriver = new DatabaseDriver();
        dbDriver.setName(md.getDriverName());
        dbDriver.setVersion(md.getDriverVersion());
        dbDriver.setMajorVersion(md.getDriverMajorVersion());
        dbDriver.setMajorVersion(md.getDriverMinorVersion());
        dbDriver.setJdbcMajorVersion(md.getJDBCMajorVersion());
        dbDriver.setJdbcMinorVersion(md.getJDBCMinorVersion());
        dbDriver.setSupportCatalogs(md.supportsCatalogsInTableDefinitions());
        dbDriver.setSupportSchemas(md.supportsSchemasInTableDefinitions());
        db.setDatabaseDriver(dbDriver);

        // Adding database catalogs.
        db.addCatalog(retrieveCatalogs());
        // Some databases does not support catalogs, so we create a default one.
        if (db.getCatalogs().keySet().isEmpty() && !dbDriver.hasSupportCatalogs()) {
            // When this happens we add a default one.
            Catalog defaultCatalog = new Catalog("DBREADER_CATALOG");
            db.addCatalog(defaultCatalog);
            System.out.println("adding default catalog");
        }

        // If database does not support schemas, then copy the catalog names to
        // the schemas. In this case we will end up with duplicate names of
        // catalog and schemas but this is done in this way because in my model,
        // a database has catalogs that has schemas that has tables.
        if (!dbDriver.hasSupportSchemas()) {
            Iterator<String> catalogs = db.getCatalogs().keySet().iterator();
            while (catalogs.hasNext()) {
                String catalogName = catalogs.next();
                Schema s = new Schema(catalogName);
                s.setCatalogName(catalogName);
                db.addSchema(catalogName, s);
            }
        } else {
            // Adding database schemas.
            db.addSchema(retrieveSchemas());
        }

        Iterator<String> catalogs = db.getCatalogs().keySet().iterator();
        while (catalogs.hasNext()) {
            db.setCurrentCatalog(catalogs.next());
            Iterator<String> schemas = db.getCurrentCatalog().getSchemas().keySet().iterator();
            while (schemas.hasNext()) {
                db.setCurrentSchema(schemas.next());
                // If catalog is set DBREADER_CATALOG it means that the database
                // does not support catalogs and so we need to pass "null" in
                // order to get the tables. Otherwise pass current catalog name
                // to get tables in it.
                System.out.println("[DBReader] INFO: Looking for tables for " + db.getCurrentSchema().getName());
                String catalog = db.getCurrentCatalog().getName().equals("DBREADER_CATALOG") ? null : db.getCurrentCatalog().getName();
                List<Table> tables = retrieveTables(catalog, db.getCurrentSchema());
                db.addTable(tables);
                retrieveFKs(catalog, db.getCurrentSchema(), tables);
            }
        }

        // System.out.println(db);

        return db;
    }

    private List<Catalog> retrieveCatalogs() throws Exception {
        List<Catalog> list = new ArrayList<Catalog>();
        ResultSet rsCat = md.getCatalogs();
        while (rsCat.next()) {
            Catalog catalog = new Catalog(rsCat.getString("TABLE_CAT"));
            System.out.println("[DBReader] INFO: Found Catalog " + catalog.getName());
            if (this.workingCatalog != null) {
                if (catalog.getName().equals(workingCatalog)) {
                    list.add(catalog);
                }
            } else {
                list.add(catalog);
            }
        }
        if (list.isEmpty()) {
            System.out.println("[DBReader] WARNING: No Catalog found. Using default ");// + db.getCurrentCatalog().getName());
        }
        rsCat.close();
        return list;
    }

    private List<Schema> retrieveSchemas() throws Exception {
        List<Schema> list = new ArrayList<Schema>();
        ResultSet rsSchem = md.getSchemas();
        while (rsSchem.next()) {
            Schema schema = new Schema(rsSchem.getString("TABLE_SCHEM"));
            System.out.println("[DBReader] INFO: Found Schema " + schema.getName());
            try {
                schema.setCatalogName(rsSchem.getString("TABLE_CATALOG") == null ? "DBREADER_CATALOG" : rsSchem.getString("TABLE_CATALOG"));
            } catch (SQLException sqle) {
                // PostgreSQL does not have "TABLE_CATALOG" column so Iam
                // setting it to the current catalog in the database, it may be
                // dangerous, need to test with other databases.
                schema.setCatalogName(db.getCurrentCatalog().getName());
            }
            if (this.workingSchema != null) {
                if (schema.getName().equals(this.workingSchema)) {
                    list.add(schema);
                }
            } else {
                list.add(schema);
            }
        }
        rsSchem.close();
        return list;
    }

    private List<Table> retrieveTables(String catalogName, Schema schema) throws Exception {
        List<Table> list = new ArrayList<Table>();
        ResultSet rsTable = md.getTables(catalogName, schema.getName(), null, new String[] { "TABLE" });
        while (rsTable.next()) {

            Table t = new Table();
            t.setName(rsTable.getString("TABLE_NAME"));
            System.out.println("[DBReader] INFO: Found MappedTable " + t.getName());
            t.setDatabaseName(this.dbShortName);
            t.setCatalogName(catalogName);
            t.setSchema(schema);
            t.addColumn(retrieveColumns(catalogName, schema.getName(), t));
            t.addPrimaryKey(retrievePKs(catalogName, schema.getName(), t));
            t.addUniqueKey(retriveUniqueKeys(catalogName, schema.getName(), t));
            list.add(t);
        }
        rsTable.close();

        return list;
    }

    private void retrieveFKs(String catalogName, Schema schema, List<Table> tables) throws Exception {
        for (Table t : tables) {
            t.addImportedForeignKey(retrieveImportedKeys(catalogName, schema.getName(), t));
            t.addExportedForeignKey(retrieveExportedKeys(catalogName, schema.getName(), t));
        }
    }

    private List<Column> retrieveColumns(String catalogName, String schemaName, Table t) throws Exception {
        List<Column> list = new ArrayList<Column>();
        ResultSet rs = md.getColumns(catalogName, schemaName, t.getName(), null);
        while (rs.next()) {

            Column c = new Column();
            c.setTable(t);
            c.setName(rs.getString("COLUMN_NAME"));
            c.setDataType(rs.getInt("DATA_TYPE"));
            c.setTypeName(rs.getString("TYPE_NAME"));
            c.setSize(rs.getInt("COLUMN_SIZE"));
            c.setDecimalDigits(rs.getInt("DECIMAL_DIGITS"));
            c.setNullable(rs.getInt("NULLABLE") == DatabaseMetaData.columnNullable);
            c.setOrdinalPosition(rs.getInt("ORDINAL_POSITION"));
            list.add(c);
        }
        rs.close();
        return list;
    }

    private List<UniqueKey> retriveUniqueKeys(String catalogName, String schemaName, Table t) throws Exception {
        List<UniqueKey> list = new ArrayList<UniqueKey>();
        ResultSet rs = md.getIndexInfo(catalogName, schemaName, t.getName(), true, true);
        while (rs.next()) {
            UniqueKey uk = new UniqueKey();
            String indexName = rs.getString("INDEX_NAME");
            String table = rs.getString("TABLE_NAME");
            String schema = rs.getString("TABLE_SCHEM");
            String columnName = rs.getString("COLUMN_NAME");
            if (indexName != null) {
                Column c = t.getColumn(rs.getString("COLUMN_NAME"));
                uk.setColumn(c);
                t.addUniqueKey(uk);
                list.add(uk);
            }
        }
        rs.close();
        return list;
    }

    private List<PrimaryKey> retrievePKs(String catalogName, String schemaName, Table t) throws Exception {
        List<PrimaryKey> list = new ArrayList<PrimaryKey>();
        ResultSet rs = md.getPrimaryKeys(catalogName, schemaName, t.getName());
        while (rs.next()) {
            PrimaryKey pk = new PrimaryKey();
            // pk.setColumnName(rs.getString("COLUMN_NAME"));
            pk.setSequence(rs.getShort("KEY_SEQ"));
            pk.setName(rs.getString("PK_NAME"));

            Column c = t.getColumn(rs.getString("COLUMN_NAME"));
            pk.setColumn(c);

            t.addPrimaryKey(pk);
            list.add(pk);
        }
        rs.close();
        return list;
    }

    private List<ForeignKey> retrieveExportedKeys(String catalogName, String schemaName, Table t) throws Exception {

        List<ForeignKey> list = new ArrayList<ForeignKey>();
        ResultSet rs = md.getExportedKeys(catalogName, schemaName, t.getName());
        while (rs.next()) {
            ForeignKey fk = new ForeignKey();
            fk.setExported(true);
            fk.setPkTableName(rs.getString("PKTABLE_NAME"));
            fk.setPkColumnName(rs.getString("PKCOLUMN_NAME"));
            fk.setFkTableName(rs.getString("FKTABLE_NAME"));
            fk.setFkColumnName(rs.getString("FKCOLUMN_NAME"));
            fk.setSequence(rs.getShort("KEY_SEQ"));

            fk.setPkTable(this.getTable(fk.getPkTableName()));
            fk.setFkTable(this.getTable(fk.getFkTableName()));

            // t.addExportedForeginKey(fk);
            list.add(fk);
        }
        rs.close();
        return list;
    }

    private List<ForeignKey> retrieveImportedKeys(String catalogName, String schemaName, Table t) throws Exception {

        List<ForeignKey> list = new ArrayList<ForeignKey>();
        ResultSet rs = md.getImportedKeys(catalogName, schemaName, t.getName());
        while (rs.next()) {
            ForeignKey fk = new ForeignKey();
            fk.setExported(false);
            fk.setPkTableName(rs.getString("PKTABLE_NAME"));
            fk.setPkColumnName(rs.getString("PKCOLUMN_NAME"));
            fk.setFkTableName(rs.getString("FKTABLE_NAME"));
            fk.setFkColumnName(rs.getString("FKCOLUMN_NAME"));
            fk.setSequence(rs.getShort("KEY_SEQ"));

            // if ("userRole".equals(t.getCamelCaseName())) {
            // System.out.println("**********************IMPORTED KEYS FOR " + t.getCamelCaseName() + " " + fk.getPkTableName() + " ");
            // System.out.println(this.getTables().size());
            // for (Table x : this.getTables()) {
            // System.out.println(x.getName());
            // }
            // }
            fk.setPkTable(this.getTable(fk.getPkTableName()));
            fk.setFkTable(this.getTable(fk.getFkTableName()));

            t.addImportedForeginKey(fk);
            list.add(fk);
        }
        rs.close();
        return list;

    }

    /**
     * @return the tables
     */
    // public Set<MappedTable> getTables() {
    // return tables;
    // }

    /**
     * @return the dbShortName
     */
    public String getDbShortName() {
        return dbShortName;
    }

    /**
     * @param dbShortName
     *            the dbShortName to set
     */
    public void setDbShortName(String dbShortName) {
        this.dbShortName = dbShortName;
    }

    /**
     * @return the dbFactoryName
     */
    public String getDbFactoryName() {
        return dbFactoryName;
    }

    /**
     * @param dbFactoryName
     *            the dbFactoryName to set
     */
    public void setDbFactoryName(String dbFactoryName) {
        this.dbFactoryName = dbFactoryName;
    }

    /**
     * @return the dbConnectionImplementation
     */
    public String getDbConnectionImplementation() {
        return dbConnectionImplementation;
    }

    /**
     * @param dbConnectionImplementation
     *            the dbConnectionImplementation to set
     */
    public void setDbConnectionImplementation(String dbConnectionImplementation) {
        this.dbConnectionImplementation = dbConnectionImplementation;
    }

    /**
     * @return the dbTestScript
     */
    public String getDbTestScript() {
        return dbTestScript;
    }

    /**
     * @param dbTestScript
     *            the dbTestScript to set
     */
    public void setDbTestScript(String dbTestScript) {
        this.dbTestScript = dbTestScript;
    }

    /**
     * @param workingCatalog
     *            the workingCatalog to set
     */
    public void setWorkingCatalog(String workingCatalog) {
        this.workingCatalog = workingCatalog;
    }

    /**
     * @param workingSchema
     *            the workingSchema to set
     */
    public void setWorkingSchema(String workingSchema) {
        this.workingSchema = workingSchema;
    }

    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        DBReader dbr = new DBReader();
        dbr.setDbConnectionImplementation(config.getProperty(DB_IMPLEMENTATION));

        System.out.println(config.getProperty(DB_IMPLEMENTATION));

        // dbr.setWorkingCatalog("livrariadb");
        // dbr.setWorkingSchema("livrariadb");

        dbr.setWorkingCatalog("PUBLIC");
        dbr.setWorkingSchema("RECIPE");

        dbr.readDatabase(config.getProperty(DB_DRIVER), config.getProperty(DB_URL), config.getProperty(DB_USER), config.getProperty(DB_PASSWORD));

        // dbr.getDatabase().setCurrentCatalog("livrariadb");
        // dbr.getDatabase().setCurrentSchema("livrariadb");

        System.out.println(dbr.getDatabase());

        System.out.println("-----------------");

        Collection<Table> tables = dbr.getDatabase().getTables();
        for (Table t : tables) {
            System.out.println(t.getName());
        }
    }
}
