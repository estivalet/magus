package org.luisoft.magus.core;

public interface IContext {

	void setAttribute(String key, Object value);

	Object getAttribute(String key);
}
