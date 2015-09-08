package org.luisoft.magus.core.decorators;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
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
public class IndexDecorator extends FreemarkerDecorator {

    private ArrayList<Map<String, String>> servlets = new ArrayList<Map<String, String>>();
    private List<TableWrapper> tables = new ArrayList<TableWrapper>();

    public IndexDecorator(Application app, Collection<TableWrapper> collection, IContext context) {
        super(app, context);
        for (TableWrapper t : collection) {
            // Add servlet information.
            Map<String, String> servlet = new HashMap<String, String>();
            String name = t.getCamelCaseName();
            servlet.put("name", StringUtils.capitalize(name));
            servlet.put("pattern", name);
            this.servlets.add(servlet);

            // Create wrappers for each table.
            // TableWrapper tw = new TableWrapper(t);
            this.tables.add(t);
        }
    }

    @Override
    protected String getTemplate() {
        return "web/template/" + app.getTemplate() + "/pages/index.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        // TODO Review hard-coded string.
        String path = app.getPath() + "/WebContent/WEB-INF/jsp/";

        return path + "index.jsp";
    }

    @Override
    protected void decorateIt() {
        model.put("appShortName", app.getShortName());
        model.put("tables", this.tables);
        model.put("servlets", servlets);
    }

}
