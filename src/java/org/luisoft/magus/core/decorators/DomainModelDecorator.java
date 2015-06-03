package org.luisoft.magus.core.decorators;

import java.util.ArrayList;
import java.util.List;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import dbreveng.database.meta.Column;

public class DomainModelDecorator extends TableDecorator {

	/**
	 * @param app
	 * @param table
	 * @param context
	 */
	public DomainModelDecorator(Application app, TableWrapper table,
			IContext context) {
		super(app, context, "model", "DomainModel", table, "Model");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
	 */
	@Override
	protected void decorateIt() {
		String tbl = t.getAlias(true);
		String iface = getParameter("collection.interface");
		List<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
		for (Column c : t.getColumns(false)) {
			ColumnWrapper cw = new ColumnWrapper(c);
			columns.add(cw);
		}
		List<ColumnWrapper> allColumns = new ArrayList<ColumnWrapper>();
		for (Column c : t.getColumns(true)) {
			ColumnWrapper cw = new ColumnWrapper(c);
			allColumns.add(cw);
		}

		model.put("table", t);
		model.put("pkColumns", t.getPrimaryKeyColumns());
		model.put("columns", columns);
		model.put("allColumns", allColumns);
		model.put("clazzName", tbl);
		model.put("clazzArray", iface.replace("?", t.getAlias(true)));
		model.put("recordsPerPage", getParameter("records.per.page"));
	}

}
