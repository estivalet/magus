package org.luisoft.magus.decorator;

import freemarker.template.Configuration;
import freemarker.template.Template;
import general.db.local.LocalContext;
import general.db.local.LocalContextFactory;
import general.db.mapper.Mapper;
import general.server.IContext;
import general.util.DateUtils;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.mapper.ApplicationMapper;
import org.luisoft.magus.mapper.MagusConfigMapper;

public class BaseDecorator {

    private IContext context;
    private String path;
    private Application app;
    private String destFileName;
    private String templateFileName;
    private Map<String, Object> model;

    /**
     * @param app
     * @param context
     * @param templateFileName
     * @param path
     * @param destFileName
     */
    public BaseDecorator(Application app, IContext context, String templateFileName, String destFileName) {
        this.app = app;
        this.context = context;
        this.destFileName = destFileName;
        this.templateFileName = templateFileName;
        this.path = app.getPath() + this.destFileName;
        this.model = new HashMap<String, Object>();

        addTemplateVariables();
    }

    /**
     * Common variables to all templates.
     */
    private void addTemplateVariables() {
        model.put("date", DateUtils.getToday(getParameter("date.format")));
        model.put("app", app);
    }

    protected void addTemplateVariable(String variable, Object value) {
        model.put(variable, value);
    }

    /**
     * Decorate the template using the variables.
     * 
     * @return
     * @throws Exception
     */
    public String decorate() throws Exception {
        Configuration cfg = (Configuration) context.getAttribute(MagusServlet.FREEMARKER_CONFIG);
        Template temp = cfg.getTemplate(templateFileName);
        StringWriter out = new StringWriter();
        temp.process(model, out);
        out.flush();

        return out.toString();
    }

    /**
     * 
     * @param parameterName
     *            parameter name to be retrived
     * @return Returns the value of a parameter from magus configuration file
     */
    protected String getParameter(String parameterName) {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        return mc.getParameter(parameterName);
    }

    /**
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        // Connects to Apache Tomcat data source.
        LocalContext ctx = LocalContextFactory.createLocalContext("org.hsqldb.jdbcDriver");
        ctx.addDataSource("java:/comp/env/jdbc/MagusDB", "jdbc:hsqldb:hsql://localhost/magusdb", "sa", "");
        DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/MagusDB");
        Mapper.setDataSource(ds);

        // Retrieve parameters.
        MagusConfigMapper mapper = new MagusConfigMapper();
        MagusConfig magusConfig = mapper.fetch();
        ctx.setAttribute(MagusServlet.MAGUS_CONFIG, magusConfig);

        // Get an application to check the mapping.
        ApplicationMapper am = new ApplicationMapper();
        am.setContext(ctx);
        Application app = am.fetchByPrimaryKey(3L);
        Map<String, TableWrapper> tables = am.fetchApplicationTables(3L);
        // new Decorator(app, ctx, "server/servlet/config/webclasspath.ftl", app.getPath(), "/.classpath");
        TableWrapper table = am.fetchApplicationTable(3L, tables.get("RECEITA"));
        new JSPServletDecorator(app, table, ctx, "server/model/Domain.ftl", "/domain/" + table.getCamelCaseName(true) + ".java");

    }
}
