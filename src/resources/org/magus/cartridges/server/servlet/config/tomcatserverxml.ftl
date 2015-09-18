<#--To be appended in Tomcat's server.xml file -->
<Context path="/${app.shortName}" 
         docBase="${app.path}/WebContent" 
         debug="5" 
         reloadable="true" 
         crossContext="true">
	<Resource name="${app.applicationDatabase.dataSource}" 
              auth="Container" 
              type="javax.sql.DataSource" 
              maxActive="100" 
              maxIdle="30" 
              maxWait="10000"
              username="${app.applicationDatabase.username}" 
              password="${app.applicationDatabase.password}" 
              driverClassName="${app.applicationDatabase.db.driver}"
              url="${app.applicationDatabase.connectionString}"/>
</Context>