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
 * Created on Jul 19, 2009 at 12:23:19 AM by luisoft
 */
package test.database;

import dbreveng.DBReader;
import dbreveng.database.DatabaseConnection;
import dbreveng.database.DatabaseFactory;
import dbreveng.database.DatabaseInfoDAO;

/**
 * @author luisoft
 * 
 */
public class DatabaseFactoryTester {

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		String factory = DBReader.config.getProperty(DBReader.DB_FACTORY);
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

		DatabaseFactory df = DatabaseFactory.getDatabaseFactory(factory);
		DatabaseInfoDAO dbinfo = df.getDatabaseInfoDAO();
		System.out.println(dbinfo.getProductName());

	}
}
