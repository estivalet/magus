<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.package}.core;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ICommand {
	public Object execute(HttpServletRequest request,
			HttpServletResponse response, IContext context) throws Exception;

	public String dispatch();
}