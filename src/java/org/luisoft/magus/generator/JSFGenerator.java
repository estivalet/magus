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
import org.luisoft.magus.decorator.BaseDecorator;
import org.luisoft.magus.decorator.JSFDecorator;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

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
        String javaPath = app.getSrcFolder() + app.getPackage();

        executeDecorator(new JSFDecorator(app, context, tplPath + "/DAO.ftl", javaPath + "/dao/" + StringUtils.capitalize(app.getShortName()) + "DAO.java"));

        for (TableWrapper table : app.getTables()) {
            // Load table meta data from database.
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(app.getId(), table);
            executeDecorator(new JSFDecorator(app, table, context, tplPath + "/bean.ftl", javaPath + "/domain/" + table.getCamelCaseName(true) + ".java"));
            executeDecorator(new JSFDecorator(app, table, context, tplPath + "/model.ftl", javaPath + "/model/" + table.getCamelCaseName(true) + "Model.java"));

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
