/*
 * MagusRAD - Digital Howler Entertainment
 * Copyright (C) 2009 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 * Created on 03/08/2009 at 14:16:52 by 88758559000
 */
package org.luisoft.magus.core.decorators;

import general.util.StringUtils;

import org.luisoft.magus.core.ColumnWrapper;
import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.mapper.ApplicationMapper;

import dbreveng.database.meta.ForeignKey;

/**
 * Creates a JSP page to search records in a table.
 * 
 * @author 88758559000
 */
public class SearchPageDecorator extends FreemarkerDecorator {

    /** Wrapper object around table object to generate the create page. */
    private TableWrapper t;

    /**
     * @param app
     * @param table
     * @param context
     */
    public SearchPageDecorator(Application app, TableWrapper table, IContext context) {
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
        return "web/template/" + app.getTemplate() + "/pages/search.ftl";
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.FreemarkerDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        String path = app.getPath() + getParameter("jsp.path");

        return path + "/" + t.getAlias() + "/search.jsp";
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

        model.put("servlet", app.getShortName());
        model.put("columns", t.getOrderedColumnsWrapper());
        model.put("clazzName", t.getAlias());
        model.put("clazz", t.getAlias(true));
        // + "s" to put in plural...
        model.put("clazzes", t.getAlias() + "s");
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
