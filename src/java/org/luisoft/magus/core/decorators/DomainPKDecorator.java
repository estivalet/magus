package org.luisoft.magus.core.decorators;

import java.util.ArrayList;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import dbreveng.database.meta.Column;
import dbreveng.database.meta.PrimaryKey;

/**
 * Will only generate a PK class if the table has more than one column as
 * primary key.
 * 
 * @author luisoft
 * 
 */
public class DomainPKDecorator extends FreemarkerDecorator {

	/** Wrapper object around table object to generate the create page. */
	private TableWrapper at;

	public DomainPKDecorator(Application app, TableWrapper table,
			IContext context) {
		super(app, context);
		this.at = table;
	}

	@Override
	public String getFullPath() {
		if (at.getPks().values().size() > 1) {
			String pkg = super.getFullPath() + ".domain.";
			return pkg.replace(".", "/") + at.getAlias(true) + "PK.java";
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.luisoft.magus.core.FreemarkerDecorator#getTemplate()
	 */
	@Override
	protected String getTemplate() {
		return "DomainPK.ftl";
	}

	public void decorateIt() {
		// Will only create a class for primary key if there are more than one
		// column in tables's PK.
		if (at.getPks().values().size() > 1) {
			model.put("clazz", at);
			// Get only columns that should be in DTOPK object.
			ArrayList<Column> columns = new ArrayList<Column>();
			for (PrimaryKey pk : at.getPks().values()) {
				Column c = new Column();
				c.setName(pk.getColumn().getName());
				c.setTypeName(pk.getColumn().getJdbcDataType());
				columns.add(c);
			}
			model.put("attributeList", columns);
		}
	}

}
