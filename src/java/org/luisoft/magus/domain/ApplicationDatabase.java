package org.luisoft.magus.domain;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;

@MappedTable(name = "MW_APPLICATION_DATABASE")
public class ApplicationDatabase {

    @MappedColumn(name = "id")
    private Long id;

    private Application app;

    private Database db;

    private String dataSource = "jdbc/MagusDB";

    // private String driver;

    private String connectionString;

    // private String connectionImpl;

    private String username;

    private String password;

    /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the app
     */
    public Application getApp() {
        return app;
    }

    /**
     * @param app
     *            the app to set
     */
    public void setApp(Application app) {
        this.app = app;
    }

    /**
     * @return the db
     */
    public Database getDb() {
        return db;
    }

    /**
     * @param db
     *            the db to set
     */
    public void setDb(Database db) {
        this.db = db;
    }

    /**
     * @return the dataSource
     */
    public String getDataSource() {
        return dataSource;
    }

    /**
     * @param dataSource
     *            the dataSource to set
     */
    public void setDataSource(String dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * @return the driver
     */
    // public String getDriver() {
    // return driver;
    // }
    //
    // /**
    // * @param driver
    // * the driver to set
    // */
    // public void setDriver(String driver) {
    // this.driver = driver;
    // }

    /**
     * @return the connectionString
     */
    public String getConnectionString() {
        return connectionString;
    }

    /**
     * @param connectionString
     *            the connectionString to set
     */
    public void setConnectionString(String connectionString) {
        this.connectionString = connectionString;
    }

    /**
     * @return the connectionImpl
     */
    // public String getConnectionImpl() {
    // return connectionImpl;
    // }
    //
    // /**
    // * @param connectionImpl
    // * the connectionImpl to set
    // */
    // public void setConnectionImpl(String connectionImpl) {
    // this.connectionImpl = connectionImpl;
    // }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username
     *            the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password
     *            the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("    <database>\n");
        sb.append("        <type>" + db.getType() + "</type>\n");
        sb.append("        <dataSource>" + dataSource + "</dataSource>\n");
        // sb.append("        <driver>" + driver + "</driver>\n");
        sb.append("        <connectionString>" + connectionString + "</connectionString>\n");
        // sb.append("        <connectionImpl>" + connectionImpl +
        // "</connectionImpl>\n");
        sb.append("        <username>" + username + "</username>\n");
        sb.append("        <password>" + password + "</password>\n");
        sb.append("    </database>\n");

        return sb.toString();

    }

}
