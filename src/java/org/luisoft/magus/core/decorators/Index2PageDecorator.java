package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

/**
 * Create the main JSP page for the application.
 * 
 * @author 88758559000
 */
public class Index2PageDecorator extends FreemarkerDecorator {

    /** Wrapper object around table object to generate the create page. */
    private TableWrapper t;

    public Index2PageDecorator(Application app, TableWrapper table, IContext context) {
        super(app, context);
        this.t = table;
    }

    @Override
    protected String getTemplate() {
        return "web/template/" + app.getTemplate() + "/pages/index2.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        String path = app.getPath() + getParameter("jsp.path");

        return path + "/" + t.getAlias() + "/index.jsp";
    }

    @Override
    protected void decorateIt() {
        String tbl = t.getAlias();
        model.put("clazzName", tbl);
    }

}
