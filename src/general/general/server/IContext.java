package general.server;

public interface IContext {

	void setAttribute(String key, Object value);

	Object getAttribute(String key);
}
