package org.luisoft.magus.core.commands;

import freemarker.template.TemplateException;
import general.util.IOUtil;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.magus.core.ICommand;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.IDecorator;
import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.core.decorators.ActionCommandDecorator;
import org.luisoft.magus.core.decorators.CreatePageDecorator;
import org.luisoft.magus.core.decorators.DomainDecorator;
import org.luisoft.magus.core.decorators.DomainMapperDecorator;
import org.luisoft.magus.core.decorators.DomainModelDecorator;
import org.luisoft.magus.core.decorators.DomainPKDecorator;
import org.luisoft.magus.core.decorators.DomainServletDecorator;
import org.luisoft.magus.core.decorators.EclipseWebClasspathDecorator;
import org.luisoft.magus.core.decorators.EclipseWebProjectDecorator;
import org.luisoft.magus.core.decorators.HeaderDecorator;
import org.luisoft.magus.core.decorators.Index2PageDecorator;
import org.luisoft.magus.core.decorators.IndexDecorator;
import org.luisoft.magus.core.decorators.SearchPageDecorator;
import org.luisoft.magus.core.decorators.SimpleDecorator;
import org.luisoft.magus.core.decorators.TomcatServerXMLDecorator;
import org.luisoft.magus.core.decorators.UpdatePageDecorator;
import org.luisoft.magus.core.decorators.WebXMLDecorator;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;

public class GenerateCommand implements ICommand {

    private IContext context;
    private Application app = new Application();

    private final static Logger LOGGER = Logger.getLogger(GenerateCommand.class.getName());

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        this.context = context;

        Long appId = Long.parseLong(request.getParameter("project"));

        // Set application attributes.
        app.setName(request.getParameter("name"));
        app.setShortName(request.getParameter("shortName"));
        app.setPath(request.getParameter("path"));
        app.setTemplate(request.getParameter("template"));

        // DBReader dbr = (DBReader)
        // context.getAttribute(MagusServlet.DATABASE);
        // Map<String, TableWrapper> tables = (Map<String, TableWrapper>) context.getAttribute("tables");

        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);
        app = am.fetchByPrimaryKey(appId);
        Map<String, TableWrapper> tables = am.fetchApplicationTables(appId);

        createWebFolderStructure(true);
        copyFiles(request);
        executeDecorator(new WebXMLDecorator(app, tables.values(), context));
        executeDecorator(new HeaderDecorator(app, tables.values(), context));
        executeDecorator(new IndexDecorator(app, tables.values(), context));

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
        // String template = request.getParameter("template");
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
     * @param collection
     * @throws Exception
     */
    private void generateCode(Long appId, Collection<TableWrapper> collection) throws Exception {
        createWebEclipseProject();

        executeDecorator(new DomainServletDecorator(app, context));

        for (TableWrapper table : collection) {
            // Load table meta data from database.
            // MappedTable t = collection.getTable(table.getName());
            ApplicationMapper am = new ApplicationMapper();
            table = am.fetchApplicationTable(appId, table);

            // Generate "model" classes.
            executeDecorator(new DomainDecorator(app, table, context));
            if (table.hasCompositePK()) {
                executeDecorator(new DomainPKDecorator(app, table, context));
            }
            executeDecorator(new DomainModelDecorator(app, table, context));
            executeDecorator(new DomainMapperDecorator(app, table, context));
            executeDecorator(new Index2PageDecorator(app, table, context));
            executeDecorator(new CreatePageDecorator(app, table, context));
            executeDecorator(new UpdatePageDecorator(app, table, context));
            executeDecorator(new SearchPageDecorator(app, table, context));
            executeDecorator(new ActionCommandDecorator(app, table, context));
        }
        executeDecorator(new SimpleDecorator(app, context, "mapper", "Mapper"));
        executeDecorator(new SimpleDecorator(app, context, "core", "ICommand"));
        executeDecorator(new SimpleDecorator(app, context, "core", "IContext"));
        executeDecorator(new SimpleDecorator(app, context, "core", "DefaultContext"));
    }

    /**
     * @throws IOException
     * @throws TemplateException
     */
    private void createWebEclipseProject() throws IOException, TemplateException {

        executeDecorator(new EclipseWebClasspathDecorator(app, context));
        executeDecorator(new EclipseWebProjectDecorator(app, context));
        // executeDecorator(new BuildPropertiesDecorator(app, context));
        // executeDecorator(new BuildXMLDecorator(app, context));
        executeDecorator(new TomcatServerXMLDecorator(app, context));
    }

    /**
     * @param d
     * @throws IOException
     * @throws TemplateException
     */
    private void executeDecorator(IDecorator d) throws IOException, TemplateException {
        IOUtil.write(d.getFullPath(), d.decorate());
    }

}
