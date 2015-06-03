package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.domain.Application;

public class EclipseWebProjectDecorator extends FreemarkerDecorator {

	public EclipseWebProjectDecorator(Application app, IContext context) {
		super(app, context);
	}

	@Override
	protected String getTemplate() {
		return "webproject.ftl";
	}

	@Override
	public String getFullPath() {
		return app.getPath() + "/.project";
	}

	public void decorateIt() {
		model.put("appShortName", app.getShortName());

	}
}
