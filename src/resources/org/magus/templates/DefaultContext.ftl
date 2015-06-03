<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.core;

import javax.servlet.ServletContext;

public class DefaultContext implements IContext {

	private ServletContext context;

	public DefaultContext(ServletContext context) {
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
