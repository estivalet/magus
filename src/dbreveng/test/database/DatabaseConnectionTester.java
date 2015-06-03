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
 * Created on Jul 5, 2009 at 3:27:42 PM by luisoft
 */
package test.database;

import dbreveng.DBReader;
import dbreveng.database.DatabaseConnection;

/**
 * Edit config.properties file to change database to test.
 * 
 * @author luisoft
 */
public class DatabaseConnectionTester {

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

		DatabaseConnection.create(impl);
		DatabaseConnection.get().setDriver(driver);
		DatabaseConnection.get().setUrl(url);
		DatabaseConnection.get().setUser(user);
		DatabaseConnection.get().setPassword(pass);
		DatabaseConnection.get().init();
		DatabaseConnection.get().testConnection();
	}

}
