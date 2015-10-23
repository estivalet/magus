package org.luisoft.magus.core.commands;

import general.server.ICommand;
import general.server.IContext;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.ApplicationDatabase;
import org.luisoft.magus.domain.Database;
import org.luisoft.magus.mapper.ApplicationMapper;

/**
 * @author 88758559000
 * 
 */
public class ProjectCommand implements ICommand {

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        String action = request.getParameter("action");

        if ("load".equals(action)) {
            loadProject(request, response, context);
        } else if ("new".equals(action)) {
            newProject(request, response, context);
        } else if ("save".equals(action)) {
            saveProject(request, response, context);
        }

        return null;
    }

    private void newProject(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        String projectName = request.getParameter("projectName");
        String shortName = request.getParameter("shortName");
        String description = request.getParameter("description");
        String path = request.getParameter("path");
        String template = request.getParameter("template");

        Application app = new Application();
        app.setName(projectName);
        app.setShortName(shortName);
        app.setDescription(description);
        app.setPath(path);
        app.setTemplate(template);

        System.out.println("[Project] Creating new project " + projectName);

        // Set response properties.
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);
        message.append(am.create(app));
        message.append("</request>");

        System.out.println(message.toString());
        response.getWriter().write(message.toString());

    }

    private void saveProject(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String database = request.getParameter("database");
        String dbURL = request.getParameter("dbURL");
        String dbUser = request.getParameter("dbUser");
        String dbPass = request.getParameter("dbPass");

        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);

        Database db = new Database();
        db.setType(database);

        ApplicationDatabase appdb = new ApplicationDatabase();
        appdb.setDb(db);
        appdb.setUsername(dbUser);
        appdb.setPassword(dbPass);
        appdb.setConnectionString(dbURL);

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        am.setContext(context);
        am.createApplicationDatabase(id, appdb);
        Application app = am.fetchByPrimaryKey(id);

        message.append(app);
        message.append("</request>");

        System.out.println(message.toString());
        response.getWriter().write(message.toString());

    }

    private void loadProject(HttpServletRequest request, HttpServletResponse response, IContext context) throws IOException {
        String project = request.getParameter("project");
        System.out.println("[LoadProject] Loading project " + project);

        // Set response properties.
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");

        // Prepare XML response.
        StringBuffer message = new StringBuffer();
        message.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        message.append("<request status=\"OK\">");

        // InputStream in = request.getServletContext().getResourceAsStream("/WEB-INF/projects/" + projectToLoad);
        // ApplicationMapper am = new ApplicationMapper();
        // am.setContext(context);
        // Application app = am.fetch(in);

        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);
        Application app = am.fetchByPrimaryKey(new Long(project));

        System.out.println(app.getName());

        message.append(app);
        message.append("</request>");

        System.out.println(message.toString());
        response.getWriter().write(message.toString());

    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#dispatch()
     */
    @Override
    public String dispatch() {
        return null;
    }

}
