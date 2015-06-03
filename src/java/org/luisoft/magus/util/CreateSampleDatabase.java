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
 * Creates a demo database.
 * 
 * @author 88758559000
 * 
 */
public class CreateSampleDatabase {

	private static final String DB_DRIVER = "org.postgresql.Driver";
	private static final String DB_URL = "jdbc:postgresql://localhost/postgres";
	private static final String DB_URL_COMPANY = "jdbc:postgresql://localhost/company";
	private static final String DB_USERNAME = "postgres";
	private static final String DB_PASSWORD = "postgres";
	private static final String DB_SCRIPT = "/sample_employee_simple.sql";
	private static final String DB_GET_CURRENT_DATE = "select now()";

	public static void setupSchema(InputStream is) throws Exception {
		Connection conn = getConnection();
		conn.createStatement().execute("DROP DATABASE IF EXISTS company");
		conn.createStatement().execute("CREATE DATABASE company");

		conn = getConnectionCompany();
		Statement statement = conn.createStatement();
		try {
			BufferedReader d = new BufferedReader(new InputStreamReader(is));
			String sql = "";
			String line = "";
			while ((line = d.readLine()) != null) {
				System.out.println(line);
				// Skip comments and empty lines
				if (line.length() > 0 && line.charAt(0) == '-'
						|| line.length() == 0) {
					continue;
				}
				sql = sql + line;
				// If one command complete.
				if (sql.charAt(sql.length() - 1) == ';') {
					// Remove the ; since jdbc complains
					sql = sql.replace(';', ' ');
					System.out.println(sql);
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
			System.out.println("POSTGRESQL Current Date:" + rs.getString(1));
		}
		rs.close();
		st.close();
		conn.close();

	}

	private static Connection getConnection() throws Exception {
		Class.forName(DB_DRIVER);
		return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
	}

	private static Connection getConnectionCompany() throws Exception {
		Class.forName(DB_DRIVER);
		return DriverManager.getConnection(DB_URL_COMPANY, DB_USERNAME,
				DB_PASSWORD);
	}

	public static void main(String[] args) throws Exception {
		setupSchema(CreateSampleDatabase.class.getResourceAsStream(DB_SCRIPT));
		test();
	}

}
