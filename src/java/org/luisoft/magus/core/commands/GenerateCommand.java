package org.luisoft.magus.core.commands;

import general.server.ICommand;
import general.server.IContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.magus.domain.Application;
import org.luisoft.magus.generator.JSFGenerator;
import org.luisoft.magus.generator.JSPServletGenerator;
import org.luisoft.magus.generator.RESTGenerator;
import org.luisoft.magus.mapper.ApplicationMapper;

public class GenerateCommand implements ICommand {

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        // Get app data in magus database.
        ApplicationMapper am = new ApplicationMapper();
        am.setContext(context);
        Application app = am.fetchByPrimaryKey(Long.parseLong(request.getParameter("project")));
        System.out.println(app);

        context.setAttribute("app", app);
        context.setAttribute("am", am);
        context.setAttribute("request", request);

        String archetype = app.getArchitecture();
        if ("JSP_Servlet".equals(archetype)) {
            new JSPServletGenerator(context);
        } else if ("REST".equals(archetype)) {
            new RESTGenerator(context);
        } else if ("JSF".equals(archetype)) {
            new JSFGenerator(context);
        }

        return null;
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#dispatch()
     */
    @Override
    public String dispatch() {
        return null;
    }
}
