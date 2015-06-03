package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.domain.Application;

public class DomainServletDecorator extends FreemarkerDecorator {

    /**
     * @param app
     * @param table
     * @param context
     */
    public DomainServletDecorator(Application app, IContext context) {
        super(app, context);
    }

    @Override
    public String getFullPath() {
        String path = super.getFullPath();
        String pkg = app.getJavaPackage() + ".server.";

        return path + pkg.replace(".", "/") + StringUtils.capitalize(app.getShortName()) + "Servlet.java";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
     */
    @Override
    protected void decorateIt() {
        model.put("clazzName", StringUtils.capitalize(app.getShortName()));
        model.put("pkg", "server");

        // TODO review hard-coded string.
        model.put("dsn", "jdbc/MagusDB");
    }

    @Override
    protected String getTemplate() {
        return "DomainServlet.ftl";
    }

}
