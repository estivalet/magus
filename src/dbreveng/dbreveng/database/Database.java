/*
 * DBRevEng - Digital Howler Entertainment Copyright (C) 2008 L.F.Estivalet
 * <luizfernando_estivalet@yahoo.com>
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/*
 * Created on Jul 14, 2009 at 6:56:27 PM by luisoft
 */
package dbreveng.database;

import dbreveng.database.impl.generic.GenericDatabaseFactory;
import dbreveng.database.impl.hsqldb.HSQLDBDatabaseFactory;
import dbreveng.database.impl.mysql.MySQLDatabaseFactory;
import dbreveng.database.impl.oracle.OracleDatabaseFactory;
import dbreveng.database.impl.postgresql.PostgreSQLDatabaseFactory;

/**
 * 
 * @author luisoft
 * 
 */
public enum Database {
	HSQLDB(HSQLDBDatabaseFactory.class), POSTGRESQL(
			PostgreSQLDatabaseFactory.class), MYSQL(MySQLDatabaseFactory.class), ORACLE(
			OracleDatabaseFactory.class);

	public Class<? extends GenericDatabaseFactory> database;

	private Database(Class<? extends GenericDatabaseFactory> database) {
		this.database = database;
	}

}
