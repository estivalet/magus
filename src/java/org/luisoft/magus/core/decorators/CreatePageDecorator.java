package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.mapper.ApplicationMapper;

/**
 * Creates a JSP page with all tables fields to create a new record.
 * 
 * @author 88758559000
 */
public class CreatePageDecorator extends FreemarkerDecorator {

    /** Wrapper object around table object to generate the create page. */
    private TableWrapper t;

    /**
     * @param app
     * @param table
     * @param context
     */
    public CreatePageDecorator(Application app, TableWrapper table, IContext context) {
        super(app, context);
        this.t = table;
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getTemplate()
     */
    @Override
    protected String getTemplate() {
        return "web/template/" + app.getTemplate() + "/pages/create.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        String path = app.getPath() + getParameter("jsp.path");

        return path + "/" + t.getAlias() + "/create.jsp";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
     */
    @Override
    protected void decorateIt() {
        List<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
        for (ColumnWrapper c : t.getColumnsWrapper()) {
            if (!c.isColumnInPrimaryKey()) {
                columns.add(c);
                // If a column is in a foreign key to other table then we need to
                // add a special key in the template to build a combo box for
                // listing foreign table column values.
                if (c.isColumnInForeignKey()) {

                    // Load foreign table.
                    ApplicationMapper am = new ApplicationMapper();
                    am.setContext(context);
                    TableWrapper foreignTable = am.fetchApplicationTable(app.getId(), c.getForeignTable());

                    String key = c.getCamelCaseName() + "_fk_display";
                    String value = StringUtils.toCamelCase(foreignTable.getOrderByColumn());
                    model.put(key, value);
                }
            }
        }

        Collections.sort(columns);
        model.put("columns", columns);
        model.put("clazzName", t.getAlias());
        model.put("maxInputSize", 80);
        model.put("servlet", app.getShortName());

    }

}
