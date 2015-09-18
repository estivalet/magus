<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.package}.server.${clazz.getAlias()}.commands;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.luisoft.commons.sql.criteria.Column;
import org.luisoft.commons.sql.criteria.Criteria;
import org.luisoft.commons.sql.criteria.Like;

import ${app.package}.core.*;
import ${app.package}.domain.*;
import ${app.package}.model.*;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.luisoft.commons.xml.XMLUtil;
import org.luisoft.commons.xml.XMLWrapper;


/**
 * Responsible for CRUD operations on ${clazz.getAlias(true)}.
 * 
 * @author ${app.user}
 */
public class ${clazzName} implements ICommand {

	/** Current action being processed. */
	private String action;

	/** Destination page after action is completed. */
	private String page;

    private boolean dispatch = true;
    
	/*
	 * (non-Javadoc)
	 * 
	 * @see demoapp.core.ICommand#execute(javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, demoapp.core.IContext)
	 */
	@Override
	public Object execute(HttpServletRequest request, HttpServletResponse response, IContext context) throws Exception {
		this.action = request.getParameter("action");
		${clazz.getAlias(true)}Model model;
		
		<#list columns as column><#t>
        <#if (column.customFieldType == 9)>
        if ("get${column.getCamelCaseName(true)}".equals(action)) {
            model = new ${clazz.getAlias(true)}Model(Integer.parseInt(request.getParameter("${pks.getCamelCaseName()}")));
            request.setAttribute("${clazz.getAlias()}", model);
            byte[] data = model.get${column.getCamelCaseName(true)}();
            if (data.length > 0) {
                response.setContentType("image/png");
                response.setContentLength(data.length);
                OutputStream out = response.getOutputStream();
                out.write(data);
            }
            this.dispatch = false;
            
            return null;
        }
        </#if>
		</#list>
		if("create".equals(action) || "update".equals(action)) {
			<#list fks as fk><#t>
			<#if (!fk.table.hasExportedKeys())>
			${fk.getAlias(true)}Model ${fk.getAlias()} = new ${fk.getAlias(true)}Model();
			${collection}<${fk.getAlias(true)}> ${fk.getAlias()}s = ${fk.getAlias()}.listAll();
			request.setAttribute("${fk.getAlias()}s", ${fk.getAlias()}s);
			</#if>
			</#list><#t>
			if("update".equals(action)) {
				model = new ${clazz.getAlias(true)}Model(Integer
						.parseInt(request.getParameter("${pks.getCamelCaseName()}")));
				request.setAttribute("${clazz.getAlias()}", model);
			}
        } else if("filter".equals(action)) {
            filter(request, response);
        } else if ("index".equals(action)) {
            this.page = "search.jsp";
            request.setAttribute("firstTime", "Y");
            return null;            
		} else {
		    request.setAttribute("firstTime", "Y");
		    // Redirects to index.jsp page that will perform a new seacrh.
			this.page = "search.jsp";
			if (request.getParameter("${pks.getCamelCaseName()}") == null) {
				action = "insert";
				model = new ${clazz.getAlias(true)}Model();
			} else {
				model = new ${clazz.getAlias(true)}Model(Integer.parseInt(request.getParameter("${pks.getCamelCaseName()}")));
				if ("delete".equals(action)) {
					model.remove();
                    request.setAttribute("message", action + " successful!");
					return null;
				}
				action = "update";
			}
			populateDto(request, model);
            if (model.save()) {
                request.setAttribute("message", action + " successful!");
            }
		}
		
		return null;
	}
	
    /**
     * @param request
     * @param response
     */
    private void filter(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int pageNum = 1;
        if (request.getParameter("pageNum") != null && !"undefined".equals(request.getParameter("pageNum"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
    
        this.dispatch = false;
        
        int totalRecords = 0;
    
        ${clazz.getAlias(true)}Model model = new ${clazz.getAlias(true)}Model();
        List<${clazz.getAlias(true)}> ${clazz.getAlias()}s = null;
        
        List<Criteria> criterias = new ArrayList<Criteria>();
        <#list columns as column><#t>
            <#-- filter cannot be null otherwise freemarker will throw an exception -->
        String ${column.getCamelCaseName()} = request.getParameter("${column.getCamelCaseName()}");
        if (${column.getCamelCaseName()} != null && !"".equals(${column.getCamelCaseName()}.trim())) {
            //${clazz.getAlias()}s = model.listBy${column.getCamelCaseName()?capitalize}(${column.getCamelCaseName()});
            Criteria like = new Like(new Column("${column.getName()}", ${column.getCamelCaseName()}), "%" + ${column.getCamelCaseName()} + "%");
            criterias.add(like);
        }
        
        </#list>
        if (criterias.size() > 0) {
            // Execute query first time to get total number of records.
            ${clazz.getAlias()}s = model.listByCriteria(criterias);
            totalRecords = model.getTotalRecords();

            // Execute query second time to get correct offset.
            model.setPage(pageNum);
            ${clazz.getAlias()}s = model.listByCriteria(criterias);
        }
        
        // No filter was provided, list all records.
        if (${clazz.getAlias()}s == null) {
            ${clazz.getAlias()}s = model.listAll(pageNum);
        }
        totalRecords = model.getTotalRecords();
        
        
        request.setAttribute("${clazz.getAlias()}s", ${clazz.getAlias()}s);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("totalPages", (int) Math.ceil(totalRecords / (double)${recordsPerPage}));
        request.setAttribute("pageNum", pageNum);
        
        /*
        try {
            JAXBContext jc = JAXBContext.newInstance(XMLWrapper.class, ${clazz.getAlias(true)}.class);
            Marshaller marshaller = jc.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            String xml = XMLUtil.marshal(marshaller, ${clazz.getAlias()}s, "${clazz.getAlias()}s");

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.getWriter().write(xml);
        } catch (JAXBException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        */

        String xml = "<results page=\"" + pageNum + "\" total=\"" + totalRecords + "\">";
        for (${clazz.getAlias(true)} c : ${clazz.getAlias()}s) {
            xml += c.toXML();
        }
        xml += "</results>";
        
        
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.getWriter().write(xml);
        
    }   
	
	/**
	 * Populates a model object based on the parameters received from the
	 * request.
	 * 
	 * @param request
	 *            Request holding parameters.
	 * @param model
	 *            Model to be populate
	 * @return Model populated
	 * @throws Exception
	 */
	private ${clazz.getAlias(true)}Model populateDto(HttpServletRequest request,${clazz.getAlias(true)}Model model) throws Exception {
        <#list columns as column><#t>
        <#if (column.getPSJavaMethod() == "Bytes")>
        if (request.getPart("${column.getCamelCaseName()}") != null) {
            Part filePart = request.getPart("${column.getCamelCaseName()}");
            String fileName = getFileName(filePart);
            InputStream input = filePart.getInputStream();
            byte[] result = new byte[(int) filePart.getSize()];
            int totalBytesRead = 0;
            while (totalBytesRead < result.length) {
                int bytesRemaining = result.length - totalBytesRead;
                int bytesRead = input.read(result, totalBytesRead, bytesRemaining);
                if (bytesRead > 0) {
                    totalBytesRead = totalBytesRead + bytesRead;
                }
            }
            input.close();
            model.set${column.getCamelCaseName(true)}(result);
        }
        <#else>
        if (request.getParameter("${column.getCamelCaseName()}") != null) {
        <#if (column.isColumnInForeignKey())>
			${column.getForeignTableAlias(true)}Model tmp = new ${column.getForeignTableAlias(true)}Model(Integer.parseInt(request
					.getParameter("${column.getCamelCaseName()}")));
			model.set${column.getForeignTableAlias(true)}(tmp);
	    }
        <#else>
        <#if (column.getJdbcDataType() == "String") >
            <#-- Is a checkbox? -->
            <#if column.customFieldType == 1>
            String[] values = request.getParameterValues("${column.getCamelCaseName()}");
            String tmp = "";
            for(String value : values) {
                tmp += value + ";";
            }
            model.set${column.getCamelCaseName(true)}(tmp);
            <#else>
            model.set${column.getCamelCaseName(true)}(request.getParameter("${column.getCamelCaseName()}"));
            </#if>
		<#elseif (column.getJdbcDataType() == "Integer") >
			model.set${column.getCamelCaseName(true)}(Integer.parseInt(request.getParameter("${column.getCamelCaseName()}")));
        <#elseif (column.getJdbcDataType() == "java.sql.Date") >
            String tmp = request.getParameter("${column.getCamelCaseName()}");
            java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("dd-MM-yyyy");
            Date parsed = format.parse(tmp);
            java.sql.Date date = new java.sql.Date(parsed.getTime());
            model.set${column.getCamelCaseName(true)}(date);
		</#if>
		}
		</#if>
		</#if>
        </#list>
		return model;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see demoapp.core.ICommand#dispatch()
	 */
	@Override
	public String dispatch() {
	    if (dispatch) {
    		String page = this.action + ".jsp";
    		if(this.page != null) {
    			page = this.page;
    		}
    		return "/${clazz.getCamelCaseName()}/" + page;
        }
        return null;
	}
	
   /**
     * Used only to get the file name to upload.
     * @param part
     * @return
     */
    private static String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }	
}
