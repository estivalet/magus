package org.luisoft.magus.generator;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.decorator.BaseDecorator;
import org.luisoft.magus.decorator.JSFDecorator;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

import freemarker.template.TemplateException;
import general.server.IContext;
import general.util.IOUtil;

/**
 * Generator for JSF archetype.
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
        File src = new File(appPath + "/" + mc.getParameter("archetype.files.path") + "jsf");
        File dest = new File(((Application) context.getAttribute("app")).getPath());
        IOUtil.copyFiles(src, dest, false);
    }

    /**
     * @throws Exception
     */
    private void generateCode() throws Exception {
        Application app = (Application) context.getAttribute("app");
        String tplPath = "archetype/jsf";
        String javaPath = "/src/" + app.getShortName();

        executeDecorator(new JSFDecorator(app, context, tplPath + "/web.xml.ftl", "/WebContent/WEB-INF/web.xml"));
        executeDecorator(new JSFDecorator(app, context, tplPath + "/faces-config.xml.ftl", "/WebContent/WEB-INF/faces-config.xml"));
        executeDecorator(new JSFDecorator(app, context, tplPath + "/DAO.java.ftl", javaPath + "/dao/DAO.java"));
        executeDecorator(new JSFDecorator(app, context, tplPath + "/JPAUtil.java.ftl", javaPath + "/dao/JPAUtil.java"));
        executeDecorator(new JSFDecorator(app, context, tplPath + "/persistence.xml.ftl", "/src/META-INF/persistence.xml"));

        for (TableWrapper table : app.getTables()) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(app.getId(), table);
            executeDecorator(new JSFDecorator(app, table, context, tplPath + "/Bean.java.ftl", javaPath + "/bean/" + table.getCamelCaseName(true) + "Bean.java"));
            executeDecorator(new JSFDecorator(app, table, context, tplPath + "/Model.java.ftl", javaPath + "/model/" + table.getCamelCaseName(true) + ".java"));
            executeDecorator(new JSFDecorator(app, table, context, tplPath + "/model.xhtml.ftl", "/WebContent/" + table.getAlias() + ".xhtml"));
        }

    }

    /**
     * @param d
     * @throws IOException
     * @throws TemplateException
     */
    private void executeDecorator(BaseDecorator d) throws Exception {
        IOUtil.write(d.getPath(), d.decorate());
    }
}
