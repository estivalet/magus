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
 * Created on Jul 14, 2009 at 7:03:32 PM by luisoft
 */
package dbreveng.database;

/**
 * @author luisoft
 * 
 */
public abstract class DatabaseFactory {

	public abstract DatabaseInfoDAO getDatabaseInfoDAO();

	public static DatabaseFactory getDatabaseFactory(String dbFactoryName) {
		try {
			// Get factory configured in the config.properties file. The values
			// configured in the config.properties file must match one of the
			// databases in Database class.
			Database db = Enum.valueOf(Database.class, dbFactoryName
					.toUpperCase());
			return db.database.newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
}
