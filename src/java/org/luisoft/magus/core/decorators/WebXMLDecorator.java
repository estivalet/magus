package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

public class WebXMLDecorator extends FreemarkerDecorator {

    private ArrayList<Map<String, String>> servlets = new ArrayList<Map<String, String>>();

    public WebXMLDecorator(Application app, Collection<TableWrapper> collection, IContext context) {
        super(app, context);
        for (TableWrapper t : collection) {
            Map<String, String> servlet = new HashMap<String, String>();
            String name = t.getCamelCaseName();
            servlet.put("name", name);
            servlet.put("class", app.getJavaPackage() + ".server." + StringUtils.capitalize(name) + "Servlet");
            servlet.put("pattern", "/" + name);
            this.servlets.add(servlet);
        }
    }

    @Override
    protected String getTemplate() {
        return "web/webxml.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        // TODO Review hard-coded string.
        String path = app.getPath() + "/WebContent/WEB-INF/";

        return path + "web.xml";
    }

    @Override
    protected void decorateIt() {
        model.put("appShortName", app.getShortName());
        model.put("clazzName", app.getJavaPackage() + ".server." + StringUtils.capitalize(app.getShortName()) + "Servlet");
    }

}
