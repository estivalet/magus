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
public class RESTv2Generator {

    private IContext context;

    /**
     * @param context
     * @throws Exception
     */
    public RESTv2Generator(IContext context) throws Exception {
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
        File src = new File(appPath + "/" + mc.getParameter("archetype.files.path") + "rest2/" + template);
        File dest = new File(((Application) context.getAttribute("app")).getPath());
        IOUtil.copyFiles(src, dest, false);
    }

    /**
     * @throws Exception
     */
    private void generateCode() throws Exception {
        Application app = (Application) context.getAttribute("app");
        String tplPath = "archetype/rest2/" + app.getTemplate();
        String javaPath = "/src/main/java/" + app.getShortName();

        System.out.println("\nDecorating pom.xml");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/pom.xml.ftl", "/pom.xml"));
        System.out.println("\nDecorating .classpath");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/classpath.ftl", "/.classpath"));
        System.out.println("\nDecorating .project");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/project.ftl", "/.project"));
        System.out.println("\nDecorating server.xml");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/server.xml.ftl", "/server.xml"));
        System.out.println("\nDecorating DomainServlet.java");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/DomainServlet.java.ftl", javaPath + "/server/" + StringUtils.capitalize(app.getShortName()) + "Servlet.java"));
        System.out.println("\nDecorating web.xml");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/web.xml.ftl", "/WebContent/WEB-INF/web.xml"));
        System.out.println("\nDecorating header.jsp");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/header.jsp.ftl", "/WebContent/WEB-INF/jsp/header.jsp"));
        System.out.println("\nDecorating footer.jsp");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/footer.jsp.ftl", "/WebContent/WEB-INF/jsp/footer.jsp"));
        System.out.println("\nDecorating index.jsp.java");
        executeDecorator(new RESTDecorator(app, context, tplPath + "/index.jsp.ftl", "/WebContent/WEB-INF/jsp/index.jsp"));

        System.out.println("\nTOTAL TABLES--->" + app.getTables().size());
        for (TableWrapper table : app.getTables()) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(app.getId(), table);
            System.out.println("\nTABLE: " + table.getName());
            System.out.println("\nDecorating Domain.java");
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/Domain.java.ftl", javaPath + "/domain/" + table.getCamelCaseName(true) + ".java"));
            System.out.println("\nDecorating DomainModel");
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainModel.java.ftl", javaPath + "/model/" + table.getCamelCaseName(true) + "Model.java"));
            System.out.println("\nDecorating DomainResource");
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainResource.java.ftl", javaPath + "/resource/" + table.getCamelCaseName(true) + "Resource.java"));
            System.out.println("\nDecorating DomainMapper");
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/DomainMapper.java.ftl", javaPath + "/mapper/" + table.getCamelCaseName(true) + "Mapper.java"));
            System.out.println("\nDecorating ActionCommand");
            executeDecorator(new RESTDecorator(app, table, context, tplPath + "/ActionCommand.java.ftl", javaPath + "/server/commands/" + table.getCamelCaseName(true) + "ActionCommand.java"));
            System.out.println("\nDecorating index2.jsp");
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
