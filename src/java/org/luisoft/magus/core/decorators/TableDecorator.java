package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

public abstract class TableDecorator extends FreemarkerDecorator {

	private String templateName;
	private String pkg;
	private String name;
	/** Wrapper object around table object to generate the create page. */
	protected TableWrapper t;

	public TableDecorator(Application app, IContext context, String pkg,
			String templateName) {
		this(app, context, pkg, templateName, null, "");
	}

	public TableDecorator(Application app, IContext context, String pkg,
			String templateName, TableWrapper table, String name) {
		super(app, context);
		this.templateName = templateName;
		this.pkg = pkg;
		this.t = table;
		this.name = name;
	}

	@Override
	protected String getTemplate() {
		return this.templateName + ".ftl";
	}

	@Override
	public String getFullPath() {
		String path = super.getFullPath();
		String pkg = app.getJavaPackage() + "." + this.pkg + ".";

		return path + pkg.replace(".", "/") + t.getAlias(true) + name + ".java";
	}

	@Override
	protected abstract void decorateIt();
}
