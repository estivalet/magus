package org.luisoft.magus.core;

import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.MagusConfigMapper;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;

/**
 * Magus main controller.
 * 
 * @author 88758559000
 */
@SuppressWarnings("serial")
public class MagusServlet extends HttpServlet {

    /** Magus parameters stored in context. */
    public static final String MAGUS_CONFIG = "magus_config";

    /** Freemarker config. */
    public static final String FREEMARKER_CONFIG = "freemarker_config";

    /** Application database meta data being generated stored in context. */
    public static final String DATABASE = "database";

    /** Servlet context. */
    private IContext context;

    /** Data source to connect to Magus database (Tomcat's server.xml). */
    public static final String DSN = "java:/comp/env/jdbc/MagusDB";

    /*
     * (non-Javadoc)
     * 
     * @see javax.servlet.GenericServlet#init()
     */
    @Override
    public void init() throws ServletException {
        super.init();

        MagusConfigMapper mapper = new MagusConfigMapper();
        MagusConfig magusConfig = mapper.fetch();

        // Freemarker configuration.
        Configuration cfg = new Configuration();
        cfg.setObjectWrapper(new DefaultObjectWrapper());
        cfg.setClassForTemplateLoading(MagusServlet.class, magusConfig.getParameter("template.path"));

        context = new MagusWebContext(this.getServletContext());
        context.setAttribute(MAGUS_CONFIG, magusConfig);
        context.setAttribute(FREEMARKER_CONFIG, cfg);

        try {
            // Get data source configuration from Tomcat's server.xml file.
            DataSource ds = (DataSource) new InitialContext().lookup(DSN);
            Mapper.setDataSource(ds);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        System.out.println("[MagusServlet] Finished");
    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * @param request
     * @param response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("[MagusServlet] Processing request");
        try {
            // Identify requested command and execute it.
            String command = request.getParameter("command");
            if (command == null) {
                command = "Index";
            }
            String pkg = this.getClass().getPackage().getName() + ".commands.";
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
    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws Exception {
        System.out.println("[MagusServlet] Dispatching to " + page);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/jsp/" + page);
        dispatcher.forward(request, response);
    }
}
