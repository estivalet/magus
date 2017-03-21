package org.luisoft.magus.core.commands;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.luisoft.magus.mapper.ApplicationMapper;

import general.server.ICommand;
import general.server.IContext;

/**
 * @author 88758559000
 * 
 */
public class IndexCommand implements ICommand {

    private String page = null;

    /*
     * (non-Javadoc)
     * 
     * @see org.luisoft.magus.core.ICommand#execute(javax.servlet.http.HttpServletRequest , javax.servlet.http.HttpServletResponse, org.luisoft.magus.core.IContext)
     */
    @Override
    public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
        ApplicationMapper mapper = new ApplicationMapper();
        mapper.setContext(context);

        HttpSession session = request.getSession();
        request.setAttribute("apps", mapper.fetchAll());

        String action = request.getParameter("action");

        if ("new".equals(action)) {
            page = "/index5.jsp";
        } else if ("open".equals(action)) {
            page = "/open.jsp";
        } else if ("fbuilder".equals(action)) {
            page = "form_builder/index.jsp";
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
        if (page != null) {
            return page;
        }

        return "/index_new.jsp";
    }

}
