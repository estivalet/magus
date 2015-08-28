package recipe.resource;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.filter.LoggingFilter;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import recipe.domain.Categoria;

public class CategoriaTest {

    private HttpServer server;
    private Client client;

    @Before
    public void before() {
        // this.server = Servidor.inicializaServidor();
        ClientConfig config = new ClientConfig();
        config.register(new LoggingFilter());
        this.client = ClientBuilder.newClient(config);
    }

    @After
    public void mataServidor() {
        // server.stop();
    }

    @Test
    public void insert() {
        Client client = ClientBuilder.newClient();
        WebTarget target = client.target("http://localhost:8080/recipe/rest");
        Categoria domain = new Categoria();
        domain.setDescricao("nova categoria");

        Entity<Categoria> entity = Entity.entity(domain, MediaType.APPLICATION_XML);
        Response response = target.path("/categorias").request().post(entity);
        Assert.assertEquals(201, response.getStatus());

        String location = response.getHeaderString("Location");
        System.out.println(location);
        String conteudo = client.target(location).request().get(String.class);
        Assert.assertTrue(conteudo.contains("Tablet"));
    }

    @Test
    public void get() {
        WebTarget target = client.target("http://localhost:8080/recipe/rest");
        Categoria domain = target.path("/categorias/1").request().get(Categoria.class);
        Assert.assertEquals("Bebida", domain.getDescricao());
    }
}
