package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.domain.Application;

public class TomcatServerXMLDecorator extends FreemarkerDecorator {

	public TomcatServerXMLDecorator(Application app, IContext context) {
		super(app, context);
	}

	@Override
	protected String getTemplate() {
		return "tomcatserverxml.ftl";
	}

	@Override
	public String getFullPath() {
		return app.getPath() + "/server.xml";
	}

	public void decorateIt() {
		model.put("appShortName", app.getShortName());
		model.put("appPath", app.getPath());
		// TODO review hard-coded params.
		model.put("dbUser", "postgres");
		model.put("dbPass", "postgres");
		model.put("dbDriver", "org.postgresql.Driver");
		model.put("dbUrl", "jdbc:postgresql://localhost:5432/company");
		model.put("dsName", "jdbc/CompanyDB");
	}
}
