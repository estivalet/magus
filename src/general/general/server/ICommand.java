package general.server;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ICommand {
	public Object execute(HttpServletRequest request,
			HttpServletResponse response, IContext context) throws Exception;

	public String dispatch();
}
