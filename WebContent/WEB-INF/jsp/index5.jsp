<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

<script type="text/javascript" src="js/helper.js"></script>
<script type="text/javascript" src="js/magus.js"></script>

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/magus.css" rel="stylesheet" type="text/css"/>

<script>
window.onload = function() {
    document.getElementById("projectName").value = "Test App";   
    document.getElementById("projectShortName").value = "testapp";   
    document.getElementById("projectDescription").value = "Test App for testing";   
    document.getElementById("projectPath").value = "C:/apache-tomcat-7.0.53/webapps/testapp";   
    document.getElementById("dbURL").value = "jdbc:hsqldb:hsql://localhost/magusdb";   
    document.getElementById("dbUser").value = "sa";   
}
</script>

</head>

<body>

    <div id="header">
        <div class="top_header">

            <div class="header_logo">
                <img src="logo3.png" alt="Logo" class="logo" height="122" style="padding: 5px" /> 
                <div class="clr"></div>
            </div>


            <div id='cssmenu'>
                <ul>
                    <li><a href='#'><span>Home</span></a></li>
                    <li class='active has-sub'><a href='#'><span>Project</span></a>
                        <ul>
                            <li class='has-sub'><a href='#'><span>New</span></a></li>
                            <li class='has-sub'><a href='#'><span>Open</span></a></li>
                        </ul>
                    </li>
                    <li><a href='#'><span>About</span></a></li>
                </ul>
            </div>
        </div>
    </div>

    <div id="content">
        <div style="margin:10px">
        <div class="tabGroup">
            <input type="radio" name="tabGroup1" id="rad1" class="tab1" checked="checked"/>
            <label for="rad1">Application</label>
         
            <input type="radio" name="tabGroup1" id="rad2" class="tab2"/>
            <label for="rad2">Data Source</label>
             
            <input type="radio" name="tabGroup1" id="rad3" class="tab3"/>
            <label for="rad3">Table Selection</label>
             
            <br/>
         
            <div class="tab1">
                <form action="" method="post" id="form_example" class="form_example">
                    <input type="hidden" id="id" name="id" value="0"/>
                    <ol>
                        <li><label for="projectName"><strong>Name</strong></label> 
                        <input id="projectName" name="projectName" class="text medium"/></li>
                        <li><label for="projectShortName"><strong>Short Name</strong></label> 
                        <input id="projectShortName" name="projectShortName" class="text medium"/></li>
                        <li><label for="projectDescription"><strong>Description</strong></label> 
                        <textarea id="projectDescription" name="projectDescription" class="text medium"></textarea></li>
                        <li><label for="projectPath"><strong>Path</strong></label> 
                        <input id="projectPath" name="projectPath" class="text large"/></li>
                        <li><label for="template"><strong>Template</strong></label> 
                            <select id="template" name="template">
                                <option value="black">Black</option>
                                <option value="boxieblue">Boxie Blue</option>
                        </select>
                        </li>
                    </ol>
                </form>
                <input type="button" value="Save" onclick="newProject()"/>
            </div>
            <div class="tab2">
                <form action="" method="post" id="form_example" class="form_example">
                    <ol>
                        <li><label for="database"><strong>Database</strong></label> 
                            <select id="database" name="database">
                            <c:forEach var="db" items="${magus_config.databases}">
                                <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}'/></option>
                            </c:forEach>
                            </select>
                        </li>
                        <li><label for="dbURL"><strong>URL (Connection String)</strong></label> 
                        <input id="dbURL" name="dbURL" class="text large"/></li>
                        <li><label for="dbUser"><strong>User name</strong></label> 
                        <input id="dbUser" name="dbUser" class="text medium"/></li>
                        <li><label for="dbPass"><strong>Password</strong></label> 
                        <input id="dbPass" name="dbPass" class="text medium"/></li>
                    </ol>
                </form>
                <input type="button" value="Test" onclick="checkConnection()"/>
                <input type="button" value="Save" onclick="saveProject()"/>
            </div>
            <div class="tab3">
                <form action="" method="post" id="form_example" class="form_example">
                    <ol>
                        <li><label for="schema"><strong>Schema</strong></label> 
                            <select id="schema" name="schema" onchange="listTables(this.value)">
                            </select>
                        </li>
                        <li>                                
                            <table border="0">
                                <tr> 
                                    <td><label for="tables">Available Tables</label></td>
                                    <td>&nbsp;</td>
                                    <td><label for="tables">Selected Tables</label></td>
                                </tr>
                                <tr>
                                    <td><select id="tables" name="tables" multiple="multiple" style="height:100px"></select></td>
                                    <td align="center">
                                        <input type="button" value=">" onclick="moveSelectedTables()"/><br/>
                                        <input type="button" value=">>" onclick="moveAllTables()"/><br/>
                                        <input type="button" value="<" onclick="removeSelectedTables()"/><br/>
                                        <input type="button" value="<<" onclick="removeAllTables()"/></td>
                                    <td><select id="selectedTables" name="selectedTables" multiple="multiple" style="height:100px"></select></td>                                        
                                </tr>
                            </table>
                        </li>
                        <li><label for="table"><strong>Table</strong></label> 
                            <select id="table" name="table" onchange="listTableColumns(this.value)">
                            </select>
                        </li>
                        <li>
                            <table id="columnTbl" name="columnTbl" border="0">
                            <tr>
                                <td>&nbsp;</td>
                                <td>Column</td>
                                <td>Label</td>
                                <td>Type</td>
                                <td>Order</td>
                                <td>&nbsp;</td>
                                <td>Comment</td>
                            </tr>
                            </table>
                        </li>
                    </ol>
                </form>
            </div>
        </div>
        </div>
    </div>

    <div id="footer">
    
    </div>
    
</body>
</html>