package org.luisoft.magus.core.decorators;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.domain.Application;

public class SimpleDecorator extends FreemarkerDecorator {

    private String templateName;
    protected String pkg;

    public SimpleDecorator(Application app, IContext context, String pkg, String templateName) {
        super(app, context);
        this.pkg = pkg;
        this.templateName = templateName;
    }

    @Override
    protected String getTemplate() {
        return this.templateName + ".ftl";
    }

    @Override
    public String getFullPath() {
        String path = super.getFullPath();
        String pkg = app.getJavaPackage() + "." + this.pkg + ".";

        return path + pkg.replace(".", "/") + this.templateName + ".java";
    }

    @Override
    protected void decorateIt() {
    }

}
