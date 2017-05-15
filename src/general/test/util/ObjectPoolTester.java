/*
 * General Tools - Digital Howler Entertainment
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
 * Created on 04/08/2009 at 16:17:36 by 88758559000
 */
package test.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import general.util.ObjectPool;

/**
 * @author 88758559000
 * 
 */
public class ObjectPoolTester extends ObjectPool<Connection> {

	private String dsn, usr, pwd;

	public ObjectPoolTester(String driver, String dsn, String usr, String pwd) {
		super();
		try {
			Class.forName(driver).newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.dsn = dsn;
		this.usr = usr;
		this.pwd = pwd;
	}

	/* (non-Javadoc)
	 * @see general.util.ObjectPool#create()
	 */
	@Override
	protected Connection create() {
		try {
			return (DriverManager.getConnection(dsn, usr, pwd));
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

	}

	/* (non-Javadoc)
	 * @see general.util.ObjectPool#expire(java.lang.Object)
	 */
	@Override
	public void expire(Connection o) {
		try {
			o.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/* (non-Javadoc)
	 * @see general.util.ObjectPool#validate(java.lang.Object)
	 */
	@Override
	public boolean validate(Connection o) {
		try {
			return !o.isClosed();
		} catch (SQLException e) {
			e.printStackTrace();
			return (false);
		}

	}

	public static void main(String args[]) {
		// Do something...

		// Create the ConnectionPool:
		ObjectPoolTester pool = new ObjectPoolTester("org.hsqldb.jdbcDriver",
				"jdbc:hsqldb://localhost/mydb", "sa", "secret");

		// Get a connection:
		Connection con = pool.checkOut();

		// Use the connection

		// Return the connection:
		pool.checkIn(con);

	}
}
