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
 * Created on Jul 5, 2009 at 2:14:11 PM by luisoft
 */
package dbreveng.database.impl.oracle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dbreveng.database.DatabaseConnection;
import dbreveng.database.SimpleConnection;

/**
 * @author luisoft
 */
public class OracleDatabaseConnection extends SimpleConnection {

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.SimpleConnection#testConnection()
	 */
	@Override
	public boolean testConnection() throws Exception {
		Connection conn = DatabaseConnection.get().getConnection();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery("select sysdate from dual");
			if (rs.next()) {
				// System.out.println("ORACLE Current Date:" + rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			super.close(rs, st);
			super.releaseConnection(conn);
		}

		return true;
	}
}
