<#--To be appended in Tomcat's server.xml file -->
<Context path="/${appShortName}" 
         docBase="${appPath}/WebContent" 
         debug="5" 
         reloadable="true" 
         crossContext="true">
	<Resource name="${dsName}" 
              auth="Container" 
              type="javax.sql.DataSource" 
              maxActive="100" 
              maxIdle="30" 
              maxWait="10000"
              username="${dbUser}" 
              password="${dbPass}" 
              driverClassName="${dbDriver}"
              url="${dbUrl}"/>
</Context>