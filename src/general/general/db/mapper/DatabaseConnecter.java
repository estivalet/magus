package general.db.mapper;

import java.sql.Connection;
import java.sql.SQLException;

public interface DatabaseConnecter {

	/**
	 * Establishes a new connection to the database
	 * 
	 * @return A new connection to the database
	 * @throws SQLException
	 * @throws Exception
	 */
	public Connection createConnection() throws SQLException;

}