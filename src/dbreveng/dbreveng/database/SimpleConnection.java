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
 * Created on Jul 5, 2009 at 1:59:38 PM by luisoft
 */
package dbreveng.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Non-pooled connection implementation. This class will ask a new connection to
 * the database on every <code>getConnection()</code> class. Uses of this class
 * include systems where a connection pool is not permitted or the connections'
 * life time is too short, not justifying to have a connection pool.
 * 
 * @author luisoft
 */
public class SimpleConnection extends DatabaseConnection {

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#close(java.sql.ResultSet,
	 * java.sql.Statement)
	 */
	@Override
	public void close(ResultSet rs, Statement st) {
		close(rs);
		close(st);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#close(java.sql.ResultSet)
	 */
	@Override
	public void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#close(java.sql.Statement)
	 */
	@Override
	public void close(Statement st) {
		if (st != null) {
			try {
				st.clearWarnings();
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#getConnection()
	 */
	@Override
	public Connection getConnection() throws Exception {
		try {
			return DriverManager.getConnection(super.url, super.user, super.password);
		} catch (Exception e) {
			throw e;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#init()
	 */
	@Override
	public void init() throws Exception {
		try {
			Class.forName(super.driver);

			// Try to validate the connection URL.
			Connection conn = this.getConnection();

			if (conn != null) {
				this.releaseConnection(conn);
			}

			this.isDatabaseUp = true;
		} catch (Exception e) {
			this.isDatabaseUp = false;
			throw e;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#realReleaseAllConnections()
	 */
	@Override
	public void realReleaseAllConnections() throws Exception {
		// NOT IMPLEMENTED.
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * dbreveng.database.DatabaseConnection#releaseConnection(java.sql.Connection
	 * )
	 */
	@Override
	public void releaseConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see dbreveng.database.DatabaseConnection#testConnection()
	 */
	@Override
	public boolean testConnection() throws Exception {
		// NOT IMPLEMENTED.
		return false;
	}

}
