package general.db.local;

import general.server.IContext;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.naming.spi.InitialContextFactory;
import javax.naming.spi.InitialContextFactoryBuilder;

/**
 * Got from http://penguindreams.org/blog/running-beans-that-use-application-server -datasources-locally/
 * 
 * @author 88758559000
 * 
 */
public class LocalContext extends InitialContext implements InitialContextFactoryBuilder, InitialContextFactory, IContext {

    Map<Object, Object> dataSources;
    Map<String, Object> attributes;

    public LocalContext() throws NamingException {
        super();
        dataSources = new HashMap<Object, Object>();
        attributes = new HashMap<String, Object>();
    }

    public void addDataSource(String name, String connectionString, String username, String password) {
        this.dataSources.put(name, new LocalDataSource(connectionString, username, password));
    }

    public InitialContextFactory createInitialContextFactory(Hashtable<?, ?> hsh) throws NamingException {
        dataSources.putAll(hsh);
        return this;
    }

    public Context getInitialContext(Hashtable<?, ?> arg0) throws NamingException {
        return this;
    }

    @Override
    public Object lookup(String name) throws NamingException {
        Object ret = dataSources.get(name);
        return (ret != null) ? ret : super.lookup(name);
    }

    @Override
    public void setAttribute(String key, Object value) {
        this.attributes.put(key, value);

    }

    @Override
    public Object getAttribute(String key) {
        return this.attributes.get(key);
    }
}
