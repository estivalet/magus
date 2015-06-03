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
 * Created on Jul 25, 2009 at 2:04:53 PM by luisoft
 */
package dbreveng.database.impl.hsqldb;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dbreveng.database.DatabaseConnection;
import dbreveng.database.SimpleConnection;

/**
 * To start the database follow steps below:
 * 
 * <pre>
 * 1. Go to data folder
 * 2. Execute the command:
 *    java -cp ./hsqldb.jar org.hsqldb.Server -database.0 file:mydb -dbname.0 xdb
 * </pre>
 * 
 * @author luisoft
 * 
 */
public class HSQLDBDatabaseConnection extends SimpleConnection {

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
			// This is something stupid in my opinion. You must select
			// current date based an a pre-existent table.
			rs = st.executeQuery("SELECT TOP 1 current_timestamp FROM INFORMATION_SCHEMA.SYSTEM_TABLES");
			if (rs.next()) {
				System.out.println("HSQLDB Current Date:" + rs.getString(1));
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
