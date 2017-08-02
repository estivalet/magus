package org.luisoft.magus.decorator;

import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import dbreveng.database.meta.Column;
import general.server.IContext;

public class JSPServletDecorator extends JavaDecorator {

    public JSPServletDecorator(Application app, IContext context, String templateFileName, String destFileName) {
        super(app, context, templateFileName, destFileName);
    }

    public JSPServletDecorator(Application app, TableWrapper table, IContext context, String templateFileName, String destFileName) {
        super(app, context, templateFileName, destFileName);
        super.addTemplateVariable("clazz", table);
        System.out.println("*************** DECORATING TABLE " + table.getName());
        super.addTemplateVariable("allColumns", getTableColumns(app.getId(), context, table));

        // super.addTemplateVariable("columns", table.getOrderedColumnsWrapper(true));
        super.addTemplateVariable("pkColumns", table.getPrimaryKeyColumns());
        // TODO Warning! Getting only the first PK, need to check what to do if a table has more than one PK or even no PKs at all.
        Column pks = null;
        if (!table.getPrimaryKeyColumns().isEmpty()) {
            pks = table.getPrimaryKeyColumns().iterator().next();
        }
        super.addTemplateVariable("pks", pks);

        super.addTemplateVariable("columnsMinusPk", table.getOrderedColumnsWrapper(false));

        super.addTemplateVariable("fks", table.getWrappedFks());
        super.getFKColumns(app.getId(), context, table);

        super.addTemplateVariable("recordsPerPage", getParameter("records.per.page"));
        super.addTemplateVariable("collection", getParameter("collection"));
        super.addTemplateVariable("clazzArray", getParameter("collection.interface").replace("?", table.getAlias(true)));
        super.addTemplateVariable("clazzImplementation", getParameter("collection.implementation").replace("?", table.getAlias(true)));

    }
}
