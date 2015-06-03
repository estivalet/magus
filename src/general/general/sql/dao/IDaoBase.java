package general.sql.dao;

import general.sql.criteria.Criteria;

import java.io.Serializable;
import java.util.List;

/**
 * http://java.dzone.com/articles/dao-layer-generics-rescue
 * 
 * @author 88758559000
 * 
 * @param <T>
 */
public interface IDaoBase<T> {
	public List<T> loadAll();

	public void save(T domain);

	public void update(T domain);

	public void delete(T domain);

	public T get(Serializable id);

	public List<T> getListByCriteria(Criteria criteria);
}
