package org.luisoft.magus.core.decorators;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import com.sun.xml.internal.ws.util.StringUtils;

/**
 * Create the main JSP page for the application.
 * 
 * @author 88758559000
 */
public class HeaderDecorator extends FreemarkerDecorator {

    private ArrayList<Map<String, String>> servlets = new ArrayList<Map<String, String>>();

    public HeaderDecorator(Application app, Collection<TableWrapper> collection, IContext context) {
        super(app, context);
        for (TableWrapper t : collection) {
            // Add servlet information.
            Map<String, String> servlet = new HashMap<String, String>();
            String name = t.getCamelCaseName();
            servlet.put("name", StringUtils.capitalize(name));
            servlet.put("pattern", name);
            this.servlets.add(servlet);

        }
    }

    @Override
    protected String getTemplate() {
        return "web/template/" + app.getTemplate() + "/pages/header.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        // TODO Review hard-coded string.
        String path = app.getPath() + "/WebContent/";

        return path + "header.jsp";
    }

    @Override
    protected void decorateIt() {
        model.put("appShortName", app.getShortName());
        model.put("servlets", servlets);
    }

}
