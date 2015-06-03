package general.db.mapper;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * Class that creates a list of <T>s filled with values from the corresponding
 * database-table.
 * 
 * @author Tino for http://www.java-blog.com
 * 
 * @param <T>
 */
public class DatabaseSelecter<T> extends AbstractDatabaseHandler<T> {

	public DatabaseSelecter(Class<T> type, DatabaseConnecter databaseConnecter) {
		super(type, databaseConnecter);
	}

	@Override
	protected String createQuery() {

		StringBuilder sb = new StringBuilder();

		sb.append("SELECT ");
		sb.append(super.getColumns(false));
		sb.append(" FROM ");

		sb.append(type.getAnnotation(MappedTable.class).name());

		return sb.toString();
	}

	/**
	 * Creates a list of <T>s filled with values from the corresponding
	 * database-table
	 * 
	 * @return List of <T>s filled with values from the corresponding
	 *         database-table
	 */
	public List<T> selectObjects() {

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			try {
				connection = databaseConnecter.createConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			statement = connection.createStatement();
			resultSet = statement.executeQuery(query);

			return createObjects(resultSet);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();
				statement.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	/**
	 * 
	 * Creates a list of <T>s filled with values from the provided ResultSet
	 * 
	 * @param resultSet
	 *            ResultSet that contains the result of the
	 *            database-select-query
	 * 
	 * @return List of <T>s filled with values from the provided ResultSet
	 */
	private List<T> createObjects(ResultSet resultSet) {

		List<T> list = new ArrayList<T>();

		try {
			while (resultSet.next()) {

				T instance = type.newInstance();

				for (Field field : type.getDeclaredFields()) {
					Object value = resultSet.getObject(field.getAnnotation(MappedColumn.class).name());
					PropertyDescriptor propertyDescriptor = new PropertyDescriptor(field.getName(), type);
					Method method = propertyDescriptor.getWriteMethod();
					method.invoke(instance, value);
				}

				list.add(instance);
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IntrospectionException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return list;
	}
}
