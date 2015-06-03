package test.db.local;

import general.db.local.LocalContext;
import general.db.local.LocalContextFactory;
import general.db.mapper.DatabaseConnecter;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * This class is used to connect a stand alone program to a data source running
 * in a web server.
 * 
 * @author 88758559000
 * 
 */
public class HSQLDBDatabaseConnecter implements DatabaseConnecter {

	@Override
	public Connection createConnection() throws SQLException {
		LocalContext ctx = null;
		try {
			ctx = LocalContextFactory.createLocalContext("org.hsqldb.jdbcDriver");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ctx.addDataSource("java:/comp/env/jdbc/MagusDB", "jdbc:hsqldb:hsql://localhost/magusdb", "sa", "");

		DataSource ds = null;
		try {
			ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/MagusDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ds.getConnection();
	}

}
