package org.luisoft.magus.core.commands;

import java.io.FileReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.luisoft.magus.mapper.ApplicationMapper;

import com.google.gson.Gson;

import general.server.ICommand;
import general.server.IContext;

/**
 * @author 88758559000
 * 
 */
public class CollectorCommand implements ICommand {

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

        String action = request.getParameter("action");

        Gson gson = new Gson();
        GamelistGame game = gson.fromJson(new FileReader("/home/lestivalet/Desktop/atari2600/Air-Sea Battle (USA).zip.json"), GamelistGame.class);
        request.setAttribute("gameInfo", game);
        request.setAttribute("system", "Atari 2600");

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

        return "collector/index.jsp";
    }

}
