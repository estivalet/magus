package org.luisoft.magus.core.decorators;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import org.luisoft.magus.core.IContext;
import org.luisoft.magus.core.IDecorator;
import org.luisoft.magus.core.MagusServlet;
import org.luisoft.magus.domain.Application;
import org.luisoft.magus.domain.MagusConfig;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import general.util.DateUtils;

public abstract class FreemarkerDecorator implements IDecorator {

    protected IContext context;

    protected Application app;

    protected Map<String, Object> model;

    /**
     * @param app
     * @param context
     */
    public FreemarkerDecorator(Application app, IContext context) {
        this.app = app;
        this.context = context;
        this.model = new HashMap<String, Object>();
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.IDecorator#getFullPath()
     */
    @Override
    public String getFullPath() {
        return app.getPath() + app.getSrcFolder();
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.IDecorator#decorate()
     */
    @Override
    public String decorate() throws IOException, TemplateException {
        // Get current date/time.
        String now = DateUtils.getToday(getParameter("date.format"));

        // Set up common template information.
        // model.setTemplatePath(getParameter("template.path"));
        model.put("date", now);
        model.put("user", app.getUser());
        model.put("appName", app.getName());
        model.put("copyright", app.getCopyright());
        model.put("license", app.getLicenseFile());
        model.put("package", app.getJavaPackage());

        // Execute the decorator.
        this.decorateIt();

        Configuration cfg = (Configuration) context.getAttribute(MagusServlet.FREEMARKER_CONFIG);
        Template temp = cfg.getTemplate(this.getTemplate());
        StringWriter out = new StringWriter();
        temp.process(model, out);
        out.flush();

        // if ("web/pages/create.ftl".equals(this.getTemplate())) {
        // System.out.println("**********************************************");
        // Tidy tidy = new Tidy();
        // tidy.setInputEncoding("UTF-8");
        // tidy.setOutputEncoding("UTF-8");
        // tidy.setWraplen(Integer.MAX_VALUE);
        // tidy.setPrintBodyOnly(true);
        // tidy.setXmlOut(true);
        // tidy.setSmartIndent(true);
        // tidy.setForceOutput(true);
        //
        // System.out.println(out.toString());
        // System.out.println("**********************************************");
        //
        // byte[] barray = out.toString().getBytes();
        // InputStream is = new ByteArrayInputStream(barray);
        //
        // ByteArrayOutputStream baos = new ByteArrayOutputStream();
        //
        // Document doc = tidy.parseDOM(is, baos);
        //
        // tidy.pprint(doc, baos);
        //
        // System.out.println(baos.toString());
        // System.out.println("xxxxxxxxxxxxx**********************************************");
        // out = new StringWriter();
        // out.write(baos.toString());
        // out.flush();
        // }

        return out.toString();
    }

    /**
     * @param parameterName
     * @return
     */
    protected String getParameter(String parameterName) {
        MagusConfig mc = (MagusConfig) context.getAttribute(MagusServlet.MAGUS_CONFIG);
        return mc.getParameter(parameterName);
    }

    /**
     * @return Template used by the decorator.
     */
    protected abstract String getTemplate();

    /**
     * Execute the decoration, replace all template variables to build the code.
     */
    protected abstract void decorateIt();

}
