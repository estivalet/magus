package general.server;

import javax.servlet.ServletContext;

public class ServletWebContext implements IContext {

	private ServletContext context;

	public ServletWebContext(ServletContext context) {
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
