package org.luisoft.magus.generator;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.decorator.RESTDecorator;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

import freemarker.template.TemplateException;
import general.server.IContext;
import general.util.IOUtil;
import general.util.StringUtils;

/**
 * Generator for JSP_Servlet archetype.
 * 
 * @author lestivalet
 * 
 */
public class RESTGenerator {

    private IContext context;

    /**
     * @param context
     * @throws Exception
     */
    public RESTGenerator(IContext context) throws Exception {
        this.context = context;

        this.generate();
    }

    /**
     * @throws Exception
     */
    private void generate() throws Exception {
        this.createWebFolderStructure();
        this.copyFiles();
        this.generateCode();
    }

    /**
     * @throws Exception
     */
    private void createWebFolderStructure() throws Exception {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        IOUtil.createDir(((Application) context.getAttribute("app")).getPath(), true);
        for (String dir : mc.getParameter("folders.path").split(",")) {
            IOUtil.createDir(((Application) context.getAttribute("app")) + "/" + dir);
        }
    }

    /**
     * @throws IOException
     */
    private void copyFiles() throws IOException {
        // Get Magus current execution folder.
        String appPath = ((HttpServletRequest) context.getAttribute("request")).getServletContext().getRealPath(".");
        appPath = appPath.substring(0, appPath.lastIndexOf("/"));
        // Get template used by the application.
        String template = ((Application) context.getAttribute("app")).getTemplate();

        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);

        // Copy template files for the archetype to destination folder of the application being generated.
        File src = new File(appPath + "/" + mc.getParameter("archetype.files.path") + "rest/" + template);
        File dest = new File(((Application) context.getAttribute("app")).getPath());
        IOUtil.copyFiles(src, dest, false);
    }

    /**
     * @throws Exception
     */
    private void generateCode() throws Exception {
        Application app = (Application) context.getAttribute("app");
        String tplPath = "archetype/rest/" + app.getTemplate();
        String javaPath = "/src/main/java/" + app.getShortName();

        executeDecorator(new RESTDecorator(app, context, tplPath + "/pom.xml.ftl", "/pom.xml"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/classpath.ftl", "/.classpath"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/project.ftl", "/.project"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/server.xml.ftl", "/server.xml"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/DomainServlet.java.ftl", javaPath + "/server/" + StringUtils.capitalize(app.getShortName()) + "Servlet.java"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/web.xml.ftl", "/WebContent/WEB-INF/web.xml"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/header.jsp.ftl", "/WebContent/WEB-INF/jsp/header.jsp"));
        executeDecorator(new RESTDecorator(app, context, tplPath + "/index.jsp.ftl", "/WebContent/WEB-INF/jsp/index.jsp"));

        for (TableWrapper table : app.getTables()) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(app.getId(), table);
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/Domain.java.ftl", javaPath + "/domain/" + table.getCamelCaseName(true) + ".java"));
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainModel.java.ftl", javaPath + "/model/" + table.getCamelCaseName(true) + "Model.java"));
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainResource.java.ftl", javaPath + "/resource/" + table.getCamelCaseName(true) + "Resource.java"));
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainMapper.java.ftl", javaPath + "/mapper/" + table.getCamelCaseName(true) + "Mapper.java"));
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/ActionCommand.java.ftl", javaPath + "/server/" + table.getCamelCaseName() + "/commands/" + table.getCamelCaseName(true) + "ActionCommand.java"));
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/index2.jsp.ftl", "/WebContent/WEB-INF/jsp/" + table.getAlias() + "/index.jsp"));
        }

    }

    /**
     * @param d
     * @throws IOException
     * @throws TemplateException
     */
    private void executeDecorator(RESTDecorator d) throws Exception {
        IOUtil.write(d.getPath(), d.decorate());
    }
}
