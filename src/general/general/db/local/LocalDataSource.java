package general.db.local;

import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

import javax.sql.DataSource;

/**
 * http://penguindreams.org/blog/running-beans-that-use-application-server- datasources-locally/
 * 
 * Example:
 * 
 * <pre>
 * LocalContext ctx = LocalContextFactory.createLocalContext(&quot;org.hsqldb.jdbcDriver&quot;);
 * ctx.addDataSource(&quot;java:/comp/env/jdbc/MagusDB&quot;, &quot;jdbc:hsqldb:hsql://localhost/magusdb&quot;, &quot;sa&quot;, &quot;&quot;);
 * 
 * DataSource ds = (DataSource) new InitialContext().lookup(&quot;java:/comp/env/jdbc/MagusDB&quot;);
 * Connection con = ds.getConnection();
 * 
 * String sql = &quot;SELECT * FROM MW_PARAMETER&quot;;
 * ResultSet rs = null;
 * Statement statement = con.createStatement();
 * rs = statement.executeQuery(sql);
 * 
 * while (rs.next()) {
 *     System.out.println(rs.getString(2));
 * }
 * 
 * rs.close();
 * con.close();
 * 
 * 
 * </pre>
 * 
 * @author 88758559000
 * 
 */
@SuppressWarnings("serial")
class LocalDataSource implements DataSource, Serializable {

    private String connectionString;
    private String username;
    private String password;

    LocalDataSource(String connectionString, String username, String password) {
        this.connectionString = connectionString;
        this.username = username;
        this.password = password;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(connectionString, username, password);
    }

    public Connection getConnection(String username, String password) throws SQLException {
        return null;
    }

    public PrintWriter getLogWriter() throws SQLException {
        return null;
    }

    public int getLoginTimeout() throws SQLException {
        return 0;
    }

    public void setLogWriter(PrintWriter out) throws SQLException {
    }

    public void setLoginTimeout(int seconds) throws SQLException {
    }

    @Override
    public boolean isWrapperFor(Class<?> iface) throws SQLException {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public <T> T unwrap(Class<T> iface) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Logger getParentLogger() throws SQLFeatureNotSupportedException {
        // TODO Auto-generated method stub
        return null;
    }
}