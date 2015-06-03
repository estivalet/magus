<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
    <link rel="stylesheet" href="css/create_form.css" type="text/css" />
    
    <script type="text/javascript" src="js/helper.js"></script>
    
    <link rel="StyleSheet" href="sandbox/xtree/xtree.css" type="text/css" />
    <script type="text/javascript" src="sandbox/xtree/xtree.js"></script>
    
    <script>
        var tree = new WebFXTree('Projects');
        tree.setBehavior('classic');
        <c:forEach var="app" items="${sessionScope.apps}">
            var a = new WebFXTreeItem("<c:out value='${app.name}'/>","javascript:loadProject('<c:out value='${app.id}'/>')");
            tree.add(a);
        </c:forEach>

        /**
         * Call server to retrieve information for the selected project.
         */   
        function loadProject(project) {
            if(tree.getSelected().childNodes.length == 0) {
                callServer("magus?command=Project&action=load&project=" + project, loadProjectStatus);
            }
        }

        /**
         * Return all information available for current selected project.
         */
        function loadProjectStatus() {
            // Server return the information in a XML.
            if (HttpReq.readyState == 4 && HttpReq.status == 200) {
                var xml = HttpReq.responseXML;

                // Retrieve application related information.
                var app = xml.getElementsByTagName("application");
                var shortName = app[0].getAttribute("shortName");
                var name = getNodeValue(app[0],"name");
                var path = getNodeValue(app[0],"path");

                // Retrieve database information used by the application.
                var db = app[0].getElementsByTagName("database");
                var dbtype = getNodeValue(db[0],"type");
                var dbconnString = getNodeValue(db[0],"connectionString");
                var dbuser = getNodeValue(db[0],"username");
                var dbpass = getNodeValue(db[0],"password");

//                var b = new WebFXTreeItem("Connections","javascript:listSchemas('" + dbtype +"','" + dbconnString + "','" + dbuser + "','" + dbpass + "')");
                var b = new WebFXTreeItem("Connections");
                tree.getSelected().add(b);
                //alert(b.getFirst());
                tree.getSelected().toggle();
                b.select();

                
                callServer("magus?command=Database&action=listSchemas&database=" +dbtype + "&url=" + dbconnString +"&username="+dbuser+"&password="+dbpass, listSchemasStatus);                
                
            }
        }

        /**
         * Call server to retrieve schemas of the selected database.
         */
        function listSchemas(dbtype,dbconnString,dbuser,dbpass) {
            callServer("magus?command=Database&action=listSchemas&database=" +dbtype + "&url=" + dbconnString +"&username="+dbuser+"&password="+dbpass, listSchemasStatus);
        }
                            

        /**
         * At the end of the execution of listSchemas() procedure, the server will return an XML with all database available schemas.
         */
        function listSchemasStatus() {
            // When the response is ready to be processed.
            if (HttpReq.readyState == 4 && HttpReq.status == 200){
                // Get XML from the server.
                var xml = HttpReq.responseXML;
                var schemas = xml.getElementsByTagName("schema");
                // For each schema returned add an option in the selection box.
                for(var i=0; i < schemas.length; i++) {
                    schemaName = schemas[i].firstChild.nodeValue;
                    var b = new WebFXTreeItem(schemaName,"javascript:listTables('" + schemaName + "')");
                    tree.getSelected().add(b);
                }
            }
        }

        /**
         * Call server to retrieve tables of the selected schema.
         */
        function listTables(schema) {
            if(tree.getSelected().childNodes.length == 0) {
                callServer("magus?command=Database&action=listTables&schema=" + schema, listTablesStatus);
            }
        }

        /**
         * At the end of the execution of listTables() procedure, the server will return an XML with all tables of the selected cshema.
         */
        function listTablesStatus() {
            // When the response is ready to be processed.
            if (HttpReq.readyState == 4 && HttpReq.status == 200){
                var xml = HttpReq.responseXML;
                // Get XML from the server.
                var xml = HttpReq.responseXML;
                var tables = xml.getElementsByTagName("table");
                // For each schema returned add an option in the selection box.
                for(var i=0; i < tables.length; i++) {
                    tableName = tables[i].firstChild.nodeValue;
                    var b = new WebFXTreeItem(tableName);
                    tree.getSelected().add(b);
                }
            }
        }
        
        
        
    </script>
 
</head>
<body>
    <script>
    document.write(tree);
    </script>
</body>
</html>