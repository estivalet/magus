<#include license>

/*
 * Created on ${date} by ${user}
 */

package ${package}.resource;

import java.net.URI;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;

import ${package}.domain.*;
import ${package}.mapper.${clazzName}Mapper;
import java.util.*;

@Path("${path}")
public class ${clazz}Resource {
    
      /** Mapper for ${clazzName} object. */
    private ${clazzName}Mapper mapper = new ${clazzName}Mapper();
    
    public ${clazzArray} listAll(Integer pageNum) {
        if (pageNum != null) {
            mapper.setLimit(${recordsPerPage});
            mapper.setOffset((pageNum - 1) * ${recordsPerPage});
        }
    
        return mapper.fetchAll();
    }
    
    @Path("all")
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public ${clazzArray} listAll() {
        return listAll(null);
    }  
    
    @Path("/all/json")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String listAllJ() {
        return new Gson().toJson(listAll(null));
    }
    
    @Path("{id}")
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public ${clazz} get(@PathParam("id") long id) {
        ${clazz} domain = mapper.fetchByPrimaryKey((int) id);
        return domain;
    }
    
    @Path("/{id}/json")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String busca(@PathParam("id") long id) {
        ${clazz} domain = mapper.fetchByPrimaryKey((int) id);
        return new Gson().toJson(domain);
    }
    
    
    /**
     * $ curl -v -H "Content-Type: application/json" -d '{"descricao":"Be"}' http://localhost:8080/recipe/rest/categorias/search
     * 
     * @param contents
     * @return
     */
    @Path("/search")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String search(String contents) {
        ${clazz} domain = new Gson().fromJson(contents, ${clazz}.class);
        return new Gson().toJson(mapper.fetch(domain));
    }
    
    /**
     * $ curl -v -H "Content-Type: application/xml" -d "<categoria><id>10</id><descric ao>novo</descricao></categoria>" http://localhost:8080/recipe/rest/categorias
     * 
     * @param domain
     * @return
     */
    @POST
    @Consumes(MediaType.APPLICATION_XML)
    public Response insert(${clazz} domain) {
        mapper.insert(domain);
        URI uri = URI.create("/${path}/" + domain.getId());
        return Response.created(uri).build();
    }
    
    /**
     * $ curl -v -H "Content-Type: application/json" -d '{"descricao":"Agua"}' http://localhost:8080/recipe/rest/categorias/add
     */
    @Path("add")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response insertJ(String contents) {
        ${clazz} domain = new Gson().fromJson(contents, ${clazz}.class);
        mapper.insert(domain);
        URI uri = URI.create("/${path}/" + domain.getId());
        return Response.created(uri).build();
    }
    

    /**
     * $ curl -v -X PUT -H "Content-Type: application/xml" -d "<categoria><id>4</id><d escricao>cat nova</descricao></categoria>" http://localhost:8080/recipe/rest/categorias
     * 
     * @param domain
     * @return
     */
    @PUT
    @Consumes(MediaType.APPLICATION_XML)
    public Response update(${clazz} domain) {
        mapper.update(domain);
        return Response.ok().build();
    }
    
    /**
     * $ curl -v -X PUT -H "Content-Type: application/json" -d '{"descricao":"Agua com Gas", "id":"7"}' http://localhost:8080/recipe/rest/categorias/update
     * 
     * @param contents
     * @return
     */
    @Path("update")
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateJ(String contents) {
        ${clazz} domain = new Gson().fromJson(contents, ${clazz}.class);
        mapper.update(domain);
        return Response.ok().build();
    }    

    /**
     * $ curl -v -X DELETE -H "Content-Type: application/xml" -d "<categoria><id>4</id><d escricao>cat nova</descricao></categoria>" http://localhost:8080/recipe/rest/categorias
     * 
     * @param domain
     * @return
     */
    @DELETE
    @Consumes(MediaType.APPLICATION_XML)
    public Response delete(${clazz} domain) {
        mapper.delete(domain);
        return Response.ok().build();
    }
    
    /**
     * $ curl -v -X DELETE -H "Content-Type: application/json" -d '{"id":"7"}' http://localhost:8080/recipe/rest/categorias/delete
     * 
     * @param contents
     * @return
     */
    @Path("delete")
    @DELETE
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteJ(String contents) {
        ${clazz} domain = new Gson().fromJson(contents, ${clazz}.class);
        mapper.delete(domain);
        return Response.ok().build();
    }
    
      
}