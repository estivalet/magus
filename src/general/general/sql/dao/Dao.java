package general.sql.dao;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;
import general.db.mapper.DatabaseConnecter;
import general.sql.criteria.Criteria;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Dao<T> implements IDaoBase<T> {

	private DatabaseConnecter databaseConnecter;
	private Class<T> type;

	protected Dao(Class<T> type, DatabaseConnecter databaseConnecter) {
		this.databaseConnecter = databaseConnecter;
		this.type = type;
	}

	@Override
	public List<T> loadAll() {
		// Build SELECT query.
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT ");
		sb.append(DaoUtil.getColumns(type, false));
		sb.append(" FROM ");
		sb.append(type.getAnnotation(MappedTable.class).name());

		return executeQuery(sb.toString());
	}

	@Override
	public List<T> getListByCriteria(Criteria criteria) {
		// Build SELECT query.
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT ");
		sb.append(DaoUtil.getColumns(type, false));
		sb.append(" FROM ");
		sb.append(type.getAnnotation(MappedTable.class).name());
		sb.append(" WHERE ");
		sb.append(criteria.sqlString());

		return executeQuery(sb.toString());
	}

	@Override
	public void save(T domain) {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(T domain) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(T domain) {
		// TODO Auto-generated method stub

	}

	@Override
	public T get(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<T> executeQuery(String query) {
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = databaseConnecter.createConnection();
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
					if (field.getAnnotation(MappedColumn.class) != null) {
						Object value = resultSet.getObject(field.getAnnotation(MappedColumn.class).name());

						if (field.getType().isAssignableFrom(Long.class)) {
							value = new Long(value.toString());
						}

						PropertyDescriptor propertyDescriptor = new PropertyDescriptor(field.getName(), type);
						Method method = propertyDescriptor.getWriteMethod();
						method.invoke(instance, value);
					}
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
