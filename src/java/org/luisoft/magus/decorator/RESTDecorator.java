package org.luisoft.magus.decorator;

import general.server.IContext;

import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

public class RESTDecorator extends JSPServletDecorator {

    public RESTDecorator(Application app, IContext context, String templateFileName, String destFileName) {
        super(app, context, templateFileName, destFileName);
    }

    public RESTDecorator(Application app, TableWrapper table, IContext context, String templateFileName, String destFileName) {
        super(app, table, context, templateFileName, destFileName);
    }

}
