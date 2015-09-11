package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.database.meta.ForeignKey;

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
        for (ColumnWrapper c : t.getColumnsWrapper()) {

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

        model.put("columns", t.getOrderedColumnsWrapper());
        model.put("ncolumns", t.getOrderedColumnsWrapper(false));
        model.put("clazzName", t.getAlias());
        model.put("clazz", t.getAlias(true));
        // + "s" to put in plural...
        // TODO Warning! Getting only the first PK, need to check what to do if a table has more than one PK.
        model.put("pks", t.getPrimaryKeyColumns().iterator().next());
        model.put("maxInputSize", 80);

        // TODO Warning getting only the first exported key.
        model.put("hasExportedKeys", t.hasExportedKeys());
        if (t.hasExportedKeys()) {
            ForeignKey fk = (ForeignKey) t.getFks().values().iterator().next();
            model.put("fks", fk);

            ApplicationMapper am = new ApplicationMapper();
            TableWrapper fktable = new TableWrapper(fk.getFkTable());
            fktable = am.fetchApplicationTable(app.getId(), fktable);

            model.put("fkTableColumns", fktable.getOrderedColumnsWrapper());
        }
    }

}
