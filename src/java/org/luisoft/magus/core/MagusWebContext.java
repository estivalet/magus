package org.luisoft.magus.core;

import javax.servlet.ServletContext;

public class MagusWebContext implements IContext {

	private ServletContext context;

	public MagusWebContext(ServletContext context) {
		this.context = context;
	}

	@Override
	public void setAttribute(String key, Object value) {
		this.context.setAttribute(key, value);
	}

	@Override
	public Object getAttribute(String key) {
		return this.context.getAttribute(key);
	}

}
