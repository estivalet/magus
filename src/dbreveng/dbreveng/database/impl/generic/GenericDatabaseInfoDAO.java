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
 * Created on Jul 14, 2009 at 7:34:23 PM by luisoft
 */
package dbreveng.database.impl.generic;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

import dbreveng.database.DatabaseConnection;
import dbreveng.database.DatabaseInfoDAO;

/**
 * @author luisoft
 * 
 */
public class GenericDatabaseInfoDAO implements DatabaseInfoDAO {

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseInfoDAO#getProductName()
	 */
	@Override
	public String getProductName() throws Exception {
		Connection conn = DatabaseConnection.get().getConnection();
		DatabaseMetaData md = conn.getMetaData();
		return md.getDatabaseProductName();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseInfoDAO#getMajorVersion()
	 */
	@Override
	public Integer getMajorVersion() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseInfoDAO#getMinorVersion()
	 */
	@Override
	public Integer getMinorVersion() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseInfoDAO#getProductVersion()
	 */
	@Override
	public String getProductVersion() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
