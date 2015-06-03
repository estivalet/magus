<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.server;

import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.luisoft.commons.utils.StringUtils;

import ${package}.core.*;
import ${package}.mapper.*;

/**
 * ${clazzName} main controller.
 * 
 * @author ${user}
 */
@SuppressWarnings("serial")
public class ${clazzName}Servlet extends HttpServlet {

	/** Data source to connect to Magus database (Tomcat's server.xml). */
	public static final String DSN = "java:/comp/env/${dsn}";

	/** Servlet context. */
	private IContext context;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.GenericServlet#init()
	 */
	@Override
	public void init() throws ServletException {
		super.init();
		try {
			// Get data source configuration from Tomcat's server.xml file.
			DataSource ds = (DataSource) new InitialContext().lookup(DSN);
			Mapper.setDataSource(ds);
			
			context = new DefaultContext(this.getServletContext());
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @param request
	 * @param response
	 */
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			// Identify requested command and execute it.
            String command = request.getParameter("command");
            String pkg = this.getClass().getPackage().getName() + "." + StringUtils.uncapitalize(command.replace("Action", "")) + ".commands.";
            String clazz = pkg + command + "Command";
			
			ICommand iCommand = (ICommand) Class.forName(clazz).newInstance();
			iCommand.execute(request, response, context);
			if (iCommand.dispatch() != null) {
				dispatch(request, response, iCommand.dispatch());
			}
		} catch (Exception e) {
			System.out.println("Problem with your request");
			e.printStackTrace();
		}
	}

	/**
	 * @param request
	 * @param response
	 * @param page
	 * @throws Exception
	 */
	protected void dispatch(HttpServletRequest request,
			HttpServletResponse response, String page) throws Exception {
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher("/WEB-INF/jsp/" + page);
		dispatcher.forward(request, response);
	}
}
