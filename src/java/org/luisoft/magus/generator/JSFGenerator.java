package org.luisoft.magus.generator;

import freemarker.template.TemplateException;
import general.server.IContext;
import general.util.IOUtil;
import general.util.StringUtils;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.decorator.JSPServletDecorator;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

/**
 * Generator for JSP_Servlet archetype.
 * 
 * @author lestivalet
 * 
 */
public class JSFGenerator {

    private IContext context;

    /**
     * @param context
     * @throws Exception
     */
    public JSFGenerator(IContext context) throws Exception {
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
        String appPath = ((HttpServletRequest) context.getAttribute("request")).getServletContext().getRealPath("..");
        // Get template used by the application.
        String template = ((Application) context.getAttribute("app")).getTemplate();

        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);

        // Copy template files for the archetype to destination folder of the application being generated.
        File src = new File(appPath + "/" + mc.getParameter("archetype.files.path") + "jsp/" + template);
        File dest = new File(((Application) context.getAttribute("app")).getPath());
        IOUtil.copyFiles(src, dest, false);
    }

    /**
     * @throws Exception
     */
    private void generateCode() throws Exception {
        Application app = (Application) context.getAttribute("app");
        String tplPath = "archetype/jsp/" + app.getTemplate();
        String javaPath = app.getSrcFolder() + app.getPackage();

        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/pom.xml.ftl", "/pom.xml"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/classpath.ftl", "/.classpath"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/project.ftl", "/.project"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/server.xml.ftl", "/server.xml"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/DomainServlet.java.ftl", javaPath + "/server/" + StringUtils.capitalize(app.getShortName()) + "Servlet.java"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/web.xml.ftl", "/WebContent/WEB-INF/web.xml"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/header.jsp.ftl", "/WebContent/WEB-INF/jsp/header.jsp"));
        executeDecorator(new JSPServletDecorator(app, context, tplPath + "/index.jsp.ftl", "/WebContent/WEB-INF/jsp/index.jsp"));

        for (TableWrapper table : app.getTables()) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(app.getId(), table);
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/Domain.java.ftl", javaPath + "/domain/" + table.getCamelCaseName(true) + ".java"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/DomainModel.java.ftl", javaPath + "/model/" + table.getCamelCaseName(true) + "Model.java"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/DomainMapper.java.ftl", javaPath + "/mapper/" + table.getCamelCaseName(true) + "Mapper.java"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/ActionCommand.java.ftl", javaPath + "/server/" + table.getCamelCaseName() + "/commands/" + table.getCamelCaseName(true) + "ActionCommand.java"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/create.jsp.ftl", "/WebContent/WEB-INF/jsp/" + table.getAlias() + "/create.jsp"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/update.jsp.ftl", "/WebContent/WEB-INF/jsp/" + table.getAlias() + "/update.jsp"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/search.jsp.ftl", "/WebContent/WEB-INF/jsp/" + table.getAlias() + "/search.jsp"));
            executeDecorator(new JSPServletDecorator(app, table, context, tplPath + "/search.js.ftl", "/WebContent/WEB-INF/jsp/" + table.getAlias() + "/search.js"));

        }

    }

    /**
     * @param d
     * @throws IOException
     * @throws TemplateException
     */
    private void executeDecorator(JSPServletDecorator d) throws Exception {
        IOUtil.write(d.getPath(), d.decorate());
    }
}
