/*
 * DBRevEng - Digital Howler Entertainment
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 */

/*
 * Created on Jul 5, 2009 at 1:53:37 PM by luisoft
 */
package dbreveng.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @author luisoft
 */
public abstract class DatabaseConnection {

	/** Indicate database status. */
	protected boolean isDatabaseUp;

	/** Single database instance. */
	private static DatabaseConnection instance;

	protected String driver;

	protected String url;

	protected String user;

	protected String password;

	/**
	 * Creates an instance of some <code>DatabaseConnection </code>
	 * implementation.
	 * 
	 * @return <code>true</code> if the instance was successfully created, or
	 *         <code>false</code> if some exception was thrown.
	 */
	public static final boolean create(String dbConnectionImplementation) {
		try {
			System.out.println(dbConnectionImplementation);
			instance = (DatabaseConnection) Class.forName(dbConnectionImplementation).newInstance();
			// instance.init();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * Gets the current <code>DatabaseConnection</code> implementation's
	 * instance
	 * 
	 * @return
	 */
	public static DatabaseConnection get() {
		return instance;
	}

	/**
	 * Utility method for closing result set and statement.
	 * 
	 * @param rs
	 *            Result set to be closed.
	 * @param st
	 *            Statement to be closed.
	 */
	public abstract void close(ResultSet rs, Statement st);

	/**
	 * Utility method for closing result set.
	 * 
	 * @param rs
	 *            Result set to be closed.
	 */
	public abstract void close(ResultSet rs);

	/**
	 * Utility method for closing statement.
	 * 
	 * @param st
	 *            Statement to be closed.
	 */
	public abstract void close(Statement st);

	/**
	 * Checks if database connection is up.
	 * 
	 * @return <code>true</code> if a connection to the database was
	 *         successfully created, or <code>false</code> if not.
	 */
	public boolean isDatabaseUp() {
		return this.isDatabaseUp;
	}

	/**
	 * Init the implementation. Connection pools may use this method to init the
	 * connections from the database, while non-pooled implementation can
	 * provide an empty method block if no other initialization is necessary. <br>
	 * Please note that this method will be called just once, at system startup.
	 * 
	 * @throws Exception
	 *             If any problem happens during database initialization.
	 */
	public abstract void init() throws Exception;

	/**
	 * Gets a connection. Connection pools' normal behavior will be to once
	 * connection from the pool, while non-pooled implementations will want to
	 * go to the database and get the connection in time the method is called.
	 * 
	 * @return Connection from database.
	 * @throws Exception
	 *             If any problem happens while accessing database.
	 */
	public abstract Connection getConnection() throws Exception;

	/**
	 * Releases a connection. Connection pools will want to put the connection
	 * back to the pool list, while non-pooled implementations should call
	 * <code>close()</code> directly in the connection object.
	 * 
	 * @param conn
	 *            The connection to release.
	 * @throws Exception
	 *             Problem accessing database.
	 */
	public abstract void releaseConnection(Connection conn);

	/**
	 * Close all open connections.
	 * 
	 * @throws Exception
	 *             Problem accessing database.
	 */
	public abstract void realReleaseAllConnections() throws Exception;

	/**
	 * Utility method to test database connection. Could be something like
	 * getting the current date and time from database.
	 * 
	 * @return <code>true</code> if connection was successful,
	 *         <code>false</code> if not.
	 * @throws Exception
	 */
	public abstract boolean testConnection() throws Exception;

	/**
	 * @return the driver
	 */
	public String getDriver() {
		return driver;
	}

	/**
	 * @param driver
	 *            the driver to set
	 */
	public void setDriver(String driver) {
		this.driver = driver;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url
	 *            the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the user
	 */
	public String getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(String user) {
		this.user = user;
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

}
