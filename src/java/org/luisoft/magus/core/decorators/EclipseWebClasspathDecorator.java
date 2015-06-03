package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.domain.Application;

public class EclipseWebClasspathDecorator extends FreemarkerDecorator {

	/**
	 * @param app
	 * @param context
	 */
	public EclipseWebClasspathDecorator(Application app, IContext context) {
		super(app, context);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.luisoft.magus.core.FreemarkerDecorator#getTemplate()
	 */
	@Override
	protected String getTemplate() {
		return "webclasspath.ftl";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
	 */
	@Override
	public String getFullPath() {
		return app.getPath() + "/.classpath";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
	 */
	public void decorateIt() {
		model.put("classpath", getParameter("class.path").split(","));
	}

}
