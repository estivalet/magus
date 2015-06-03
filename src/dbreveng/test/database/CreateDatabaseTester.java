/*
 * DBRevEng - Digital Howler Entertainment
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
 * Created on Jul 25, 2009 at 2:00:28 PM by luisoft
 */
package test.database;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import dbreveng.DBReader;
import dbreveng.database.DatabaseConnection;

/**
 * Create a test database for testing purposes.
 * 
 * @author luisoft
 * 
 */
public class CreateDatabaseTester {

	private static final Logger LOGGER = Logger
			.getLogger(CreateDatabaseTester.class.getName());

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		String impl = DBReader.config.getProperty(DBReader.DB_IMPLEMENTATION);
		String driver = DBReader.config.getProperty(DBReader.DB_DRIVER);
		String url = DBReader.config.getProperty(DBReader.DB_URL);
		String user = DBReader.config.getProperty(DBReader.DB_USER);
		String pass = DBReader.config.getProperty(DBReader.DB_PASSWORD);
		String script = DBReader.config.getProperty(DBReader.DB_TEST_SCRIPT);

		DatabaseConnection.create(impl);
		DatabaseConnection.get().setDriver(driver);
		DatabaseConnection.get().setUrl(url);
		DatabaseConnection.get().setUser(user);
		DatabaseConnection.get().setPassword(pass);
		DatabaseConnection.get().init();
		DatabaseConnection.get().testConnection();

		setupSchema(script);
	}

	public static void setupSchema(String testScript) {
		String thisLine, sqlQuery;
		Connection connection = null;
		Statement statement = null;
		try {
			connection = DatabaseConnection.get().getConnection();
			statement = connection.createStatement();

			InputStream is = CreateDatabaseTester.class
					.getResourceAsStream(testScript);
			BufferedReader d = new BufferedReader(new InputStreamReader(is));

			sqlQuery = "";
			while ((thisLine = d.readLine()) != null) {
				// Skip comments and empty lines
				if (thisLine.length() > 0 && thisLine.charAt(0) == '-'
						|| thisLine.length() == 0)
					continue;
				sqlQuery = sqlQuery + " " + thisLine;
				// If one command complete
				if (sqlQuery.charAt(sqlQuery.length() - 1) == ';') {
					sqlQuery = sqlQuery.replace(';', ' '); // Remove the ; since
					// jdbc complains
					try {
						System.out.println(sqlQuery);
						statement.execute(sqlQuery);
					} catch (Exception e) {
						LOGGER.log(Level.WARNING, "", e);
					}
					sqlQuery = "";
				}
			}
		} catch (Exception e) {
			LOGGER.log(Level.WARNING, "", e);
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (final SQLException e) {
					LOGGER.log(Level.WARNING, "", e);
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (final SQLException e) {
					LOGGER.log(Level.WARNING, "", e);
				}
			}
		}
	}

}
