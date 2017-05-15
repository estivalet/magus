package org.luisoft.magus.decorator;

import org.luisoft.magus.core.TableWrapper;
import org.luisoft.magus.domain.Application;

import general.server.IContext;

public class RESTDecorator extends JSPServletDecorator {

    public RESTDecorator(Application app, IContext context, String templateFileName, String destFileName) {
        super(app, context, templateFileName, destFileName);
    }

    public RESTDecorator(Application app, TableWrapper table, IContext context, String templateFileName, String destFileName) {
        super(app, table, context, templateFileName, destFileName);
    }

}
