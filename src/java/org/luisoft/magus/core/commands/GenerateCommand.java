package org.luisoft.magus.core.commands;

import freemarker.template.TemplateException;
import general.server.ICommand;
import general.server.IContext;
import general.util.IOUtil;
import general.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.magus.core.Decorator;
import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

public class GenerateCommand implements ICommand {

    private IContext context;
    private Application app = new Application();

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        this.context = context;

        Long appId = Long.parseLong(request.getParameter("project"));

        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);
        app = am.fetchByPrimaryKey(appId);
        Map<String, TableWrapper> tables = am.fetchApplicationTables(appId);

        createWebFolderStructure(true);
        copyFiles(request);

        generateCode(appId, tables.values());

        return null;
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

    private void copyFiles(HttpServletRequest request) throws IOException {
        String appPath = request.getServletContext().getRealPath("..");
        String template = app.getTemplate();

        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        String path = appPath + "/" + mc.getParameter("common.files.path");

        File src = new File(path);
        File dest = new File(app.getPath());
        IOUtil.copyFiles(src, dest, false);

        path = appPath + "/" + mc.getParameter("template.files.path") + template + "/";

        src = new File(path);
        IOUtil.copyFiles(src, dest, false);

    }

    /**
     * @param deleteContents
     * @throws Exception
     */
    private void createWebFolderStructure(boolean deleteContents) throws Exception {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        IOUtil.createDir(app.getPath(), deleteContents);
        for (String dir : mc.getParameter("folders.path").split(",")) {
            IOUtil.createDir(app.getPath() + "/" + dir);
        }
    }

    /**
     * @param tables
     * @throws Exception
     */
    private void generateCode(Long appId, Collection<TableWrapper> tables) throws Exception {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);

        executeDecorator(new Decorator(app, context, "server/servlet/config/pom.ftl", app.getPath(), "/pom.xml"));
        executeDecorator(new Decorator(app, context, "server/servlet/config/webclasspath.ftl", app.getPath(), "/.classpath"));
        executeDecorator(new Decorator(app, context, "server/servlet/config/webproject.ftl", app.getPath(), "/.project"));
        executeDecorator(new Decorator(app, context, "server/servlet/config/tomcatserverxml.ftl", app.getPath(), "/server.xml"));
        executeDecorator(new Decorator(app, context, "server/servlet/DomainServlet.ftl", null, "/server/" + StringUtils.capitalize(app.getShortName()) + "Servlet.java"));
        executeDecorator(new Decorator(app, context, "server/servlet/config/webxml.ftl", app.getPath() + "/WebContent/WEB-INF/", "web.xml"));
        executeDecorator(new Decorator(app, context, "server/model/Mapper.ftl", null, "/mapper/Mapper.java"));
        executeDecorator(new Decorator(app, context, "server/servlet/ICommand.ftl", null, "/core/ICommand.java"));
        executeDecorator(new Decorator(app, context, "server/servlet/IContext.ftl", null, "/core/IContext.java"));
        executeDecorator(new Decorator(app, context, "server/servlet/DefaultContext.ftl", null, "/core/DefaultContext.java"));
        executeDecorator(new Decorator(app, context, "client/web/template/" + app.getTemplate() + "/pages/header.ftl", app.getPath() + "/WebContent/WEB-INF/jsp/", "header.jsp"));
        executeDecorator(new Decorator(app, context, "client/web/template/" + app.getTemplate() + "/pages/index.ftl", app.getPath() + "/WebContent/WEB-INF/jsp/", "index.jsp"));

        for (TableWrapper table : tables) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(appId, table);
            executeDecorator(new Decorator(app, table, context, "server/model/Domain.ftl", null, "/domain/" + table.getCamelCaseName(true) + ".java"));
            executeDecorator(new Decorator(app, table, context, "server/model/DomainModel.ftl", null, "/model/" + table.getCamelCaseName(true) + "Model.java"));
            executeDecorator(new Decorator(app, table, context, "server/rest/DomainResource.ftl", null, "/resource/" + table.getCamelCaseName(true) + "Resource.java"));
            executeDecorator(new Decorator(app, table, context, "server/model/DomainMapper.ftl", null, "/mapper/" + table.getCamelCaseName(true) + "Mapper.java"));
            executeDecorator(new Decorator(app, table, context, "server/servlet/ActionCommand.ftl", null, "/server/" + table.getCamelCaseName() + "/commands/" + table.getCamelCaseName(true) + "ActionCommand.java"));
            if ("JSP_Servlet".equals(app.getArchitecture())) {
                executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/create.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" + table.getAlias() + "/create.jsp"));
                executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/update.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" + table.getAlias() + "/update.jsp"));
                executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/search.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" + table.getAlias() + "/search.jsp"));
                executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/search_js.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" + table.getAlias() + "/search.js"));
            } else if ("REST".equals(app.getArchitecture())) {
                executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/index2.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" + table.getAlias() + "/index.jsp"));
            }
            // executeDecorator(new Decorator(app, table, context, "client/web/template/" + app.getTemplate() + "/pages/index_js.ftl", app.getPath() + mc.getParameter("jsp.path"), "/" +
            // table.getAlias() + "/index.js"));
        }
    }

    /**
     * @param d
     * @throws IOException
     * @throws TemplateException
     */
    private void executeDecorator(Decorator d) throws Exception {
        IOUtil.write(d.getPath(), d.decorate());
    }
}
