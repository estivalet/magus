package org.luisoft.magus.core.decorators;

import java.util.ArrayList;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.Table;

public class ActionCommandDecorator extends FreemarkerDecorator {

    /** Wrapper object around table object to generate the create page. */
    private TableWrapper t;

    /**
     * @param app
     * @param table
     * @param context
     */
    public ActionCommandDecorator(Application app, TableWrapper table, IContext context) {
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
        return "web/commands/ActionCommand.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        String path = super.getFullPath();
        String pkg = app.getJavaPackage() + ".server.";
        pkg += t.getCamelCaseName() + ".commands.";
        String name = t.getCamelCaseName(true);

        return path + pkg.replace(".", "/") + name + "ActionCommand.java";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#decorateIt()
     */
    @Override
    protected void decorateIt() {
        // All columns minus PK.
        // List<ColumnWrapper> columns = new ArrayList<ColumnWrapper>();
        // for (Column c : t.getColumns(false)) {
        // ColumnWrapper cw = new ColumnWrapper(c);
        // columns.add(cw);
        // }

        // Foreign keys.
        ArrayList<TableWrapper> ats = new ArrayList<TableWrapper>();
        for (ForeignKey fk : t.getFks().values()) {

            Table tmp = new Table();
            tmp.setName(fk.getPkTableName());
            tmp.setHasExportedKeys(fk.getExported());
            TableWrapper appt = new TableWrapper(tmp);

            ats.add(appt);

        }

        String clazzName = this.t.getCamelCaseName(true);
        model.put("clazz", this.t);
        model.put("clazzName", clazzName + "ActionCommand");
        model.put("columns", t.getColumnsWrapper());
        // TODO Warning! Getting only the first PK, need to check what to do if a table has more than one PK.
        model.put("pks", t.getPrimaryKeyColumns().iterator().next());
        model.put("fks", ats);
        model.put("collection", getParameter("collection"));
        model.put("recordsPerPage", getParameter("records.per.page"));
    }

}
