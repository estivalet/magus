<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.package}.core;

public interface IContext {

	void setAttribute(String key, Object value);

	Object getAttribute(String key);
}
