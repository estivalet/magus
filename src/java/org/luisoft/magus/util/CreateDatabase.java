package org.luisoft.magus.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Creates a hsql internal database.
 * 
 * @author 88758559000
 * 
 */
public class CreateDatabase {

    private static final String DB_DRIVER = "org.hsqldb.jdbc.JDBCDriver";
    private static final String DB_URL = "jdbc:hsqldb:hsql://localhost/magusdb";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "";
    private static final String DB_GET_CURRENT_DATE = "CALL current_timestamp";

    public static void setupSchema(InputStream is) throws Exception {
        Connection conn = getConnection();
        Statement statement = conn.createStatement();
        try {
            BufferedReader d = new BufferedReader(new InputStreamReader(is));
            String sql = "";
            String line = "";
            while ((line = d.readLine()) != null) {
                // Skip comments and empty lines
                if (line.length() > 0 && line.charAt(0) == '-' || line.length() == 0) {
                    continue;
                }
                sql = sql + " " + line;
                // If one command complete.
                if (sql.charAt(sql.length() - 1) == ';') {
                    // Remove the ; since jdbc complains
                    sql = sql.replace(';', ' ');
                    statement.execute(sql);
                    sql = "";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (final SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (final SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void test() throws Exception {
        Connection conn = getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(DB_GET_CURRENT_DATE);
        if (rs.next()) {
            System.out.println("HSQLDB Current Date:" + rs.getString(1));
        }
        rs.close();
        st.close();
        conn.close();

    }

    private static Connection getConnection() throws Exception {
        Class.forName(DB_DRIVER);
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }

    public static void main(String[] args) throws Exception {
        setupSchema(CreateDatabase.class.getResourceAsStream("/magus.sql"));
        // setupSchema(CreateDatabase.class.getResourceAsStream("/sample_employee_v1.sql"));
        // setupSchema(CreateDatabase.class.getResourceAsStream("/octupus.sql"));
        // setupSchema(CreateDatabase.class.getResourceAsStream("/rbac.sql"));
        setupSchema(CreateDatabase.class.getResourceAsStream("/recipe.sql"));
        // setupSchema(CreateDatabase.class.getResourceAsStream("/livraria.sql"));

        test();
    }

}
