<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
	<display-name>${app.shortName}</display-name>
	<!--
	<welcome-file-list>
		<welcome-file>index.jsp</welcome-file>
	</welcome-file-list>
	-->
    <context-param> 
        <description>Location to store uploaded file</description> 
        <param-name>file-upload</param-name> 
        <param-value>
             C:\xampp\htdocs\fileman\Uploads\
         </param-value> 
    </context-param>
        
    <servlet>
       <servlet-name>UploadServlet</servlet-name>
       <servlet-class>org.luisoft.commons.server.UploadServlet</servlet-class>
    </servlet>

    <servlet-mapping>
       <servlet-name>UploadServlet</servlet-name>
       <url-pattern>/UploadServlet</url-pattern>
    </servlet-mapping>  
	
	<!--
	<servlet>
		<servlet-name>${app.shortName}</servlet-name>
		<servlet-class>${app.package}.server.${app.getShortName(true)}Servlet</servlet-class>
	</servlet>

	<servlet-mapping>
		<servlet-name>${app.shortName}</servlet-name>
		<url-pattern>/${app.shortName}</url-pattern>
	</servlet-mapping>
	-->
  <servlet>
        <servlet-name>Rest Servlet</servlet-name>
        <servlet-class>org.glassfish.jersey.servlet.ServletContainer</servlet-class>
        <init-param>
            <param-name>jersey.config.server.provider.packages</param-name>
            <param-value>${app.package}.resource</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>Rest Servlet</servlet-name>
        <url-pattern>/rest/*</url-pattern>
    </servlet-mapping>	
</web-app>
