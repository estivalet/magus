<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
	<display-name>${appShortName}</display-name>
	<welcome-file-list>
		<welcome-file>index.jsp</welcome-file>
	</welcome-file-list>
	
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
	
	
	<servlet>
		<servlet-name>${appShortName}</servlet-name>
		<servlet-class>${clazzName}</servlet-class>
	</servlet>

	<servlet-mapping>
		<servlet-name>${appShortName}</servlet-name>
		<url-pattern>/${appShortName}</url-pattern>
	</servlet-mapping>
	
</web-app>
