<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
    <link rel="stylesheet" href="css/create_form.css" type="text/css" />
    
    <style>
    #wizard {
        display: none;
    }
    #addOptions {
        display: none;
    }
    </style>
    
    <script type="text/javascript" src="js/helper.js"></script>
    <script type="text/javascript" src="js/magus.js"></script>
 
</head>
<body>
    <div id="stylized" class="myform">
        <form action="magus" method="post">
            Select project:
            <select id="project" name="project" onchange="loadProject(this.value)">
                <option value="">Select...</option>
                <c:forEach var="app" items="${sessionScope.apps}">
                    <option value="<c:out value='${app.id}'/>"><c:out value='${app.name}'/></option>
                </c:forEach>
            </select>
            <a href="#">Create new project</a>
        </form>
    </div>
    
    
    <div id="wizard">
        <h3>Welcome to Magus Wizard</h3>

        <div id="stylized" class="myform">
            <form action="magus" method="post">
                <fieldset class="main">
                    <legend>Step 1: Application settings</legend>
                    <fieldset class="nested">
                        <legend>Application</legend>
                        <ol>
                            <li> 
                                <label for="name">name*</label>
                                <input id="name" name="name" type="text" size="40" maxlength="80"/>
                            </li>
                            <li> 
                                <label for="shortName">shortName*</label>
                                <input id="shortName" name="shortName" type="text" size="20" maxlength="20"/>
                            </li>
                            <li> 
                                <label for="path">path*</label>
                                <input id="path" name="path" type="text" size="60" maxlength="80"/>
                            </li>
                            <li> 
                                <label for="template">template*</label>
                                <select id="template" name="template">
                                    <option value="black">Black</option>
                                    <option value="boxieblue">Boxie Blue</option>
                                </select>
                            </li>
                        </ol>
                    </fieldset>     
                </fieldset>    
                
                <fieldset class="main">
                    <legend>Step 2: Database settings</legend>
                    <fieldset class="nested">
                        <legend>Database</legend>    
                        <ol>
                            <li> 
                                <label for="database">database*</label>
                                <select id="database" name="database">
                                    <c:forEach var="db" items="${magus_config.databases}">
                                        <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}'/></option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li> 
                                <label for="url">url*</label>
                                <input id="url" name="url" type="text" size="40" maxlength="80"/>
                            </li>
                            <li> 
                                <label for="username">username*</label>
                                <input id="username" name="username" type="text" size="40" maxlength="20"/>
                            </li>
                            <li> 
                                <label for="password">password</label>
                                <input id="password" name="password" type="text" size="40" maxlength="20"/>
                            </li>
                        </ol>
                    </fieldset>     
                    <input type="button" onclick="checkConnection()" value="Check"/><input type="button" onclick="listSchemas()" value="Load"/>
                                <input type="button" onclick="generateCode()" value="Generate"/>
                    
                </fieldset>
                
   
                 
            <fieldset class="main">
                <legend>Step 3: Table selection</legend>
                <fieldset class="nested">
                    <legend>Tables</legend>    
                    <ol>
                        <li> 
                            <label for="schema">schema*</label>
                            <select id="schema" name="schema" onchange="listTables(this.value)">
                            </select>
                        </li>
                        <li>
                            <table border="1">
                                <tr> 
                                    <td><label for="tables">available tables</label></td>
                                    <td>&nbsp;</td>
                                    <td><label for="tables">selected tables</label></td>
                                </tr>
                                <tr>
                                    <td><select id="tables" name="tables" size="10" multiple="multiple"></select></td>
                                    <td align="center">
                                        <input type="button" value=">" onclick="moveSelectedTables()"/><br/>
                                        <input type="button" value=">>" onclick="moveAllTables()"/><br/>
                                        <input type="button" value="<" onclick="removeSelectedTables()"/><br/>
                                        <input type="button" value="<<" onclick="removeAllTables()"/></td>
                                    <td><select id="selectedTables" name="selectedTables" size="10" multiple="multiple"></select></td>                                        
                                </tr>
                            </table>
                        </li>
                    </ol>
                </fieldset>     
                 <br/>
                 <div><button type="button" value="next" onclick="loadSelectedTables()">Next</button></div>
            </fieldset>
                 
            <fieldset class="main">
                <legend>Step 4: Map columns</legend>
                <fieldset class="nested">
                    <legend>Mapping</legend>    
                    <ol>
                        <li> 
                            <label for="schema">table*</label>
                            <select id="table" name="table" onchange="listTableColumns(this.value)">
                            </select>
                        </li>
                        <li>
                            <table id="columnTbl" name="columnTbl" border="1">
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
                            <br/>
                            <input type="button" value="Save" onclick="saveColumnMapping()"/>
                        </li>
                    </ol>
                    <div id="addOptions">
                        <input type="hidden" id="currentColumn"/>
                        <label for="optionValue"><input type="text" id="optionValue"/></label>
                        <label for="optionText"><input type="text" id="optionText"/></label>
                        <input type="button" value="Add option" onclick="addOption(document.getElementById('optionValue').value,document.getElementById('optionText').value)"/>
                        
                        <table id="columnOptions" border="1">
                        <tr>
                            <td>Value</td>
                            <td>Text</td>
                            <td>&nbsp;</td>
                        </tr>
                        </table>
                        <input type="button" value="Delete option" onclick="deleteOption()"/>
                        <input type="button" value="Save options" onclick="saveOptions()"/>
                    </div>
                </fieldset>     
                 <br/>
                 <div><button type="button" value="next">Next</button></div>
            </fieldset>
            
            <br/>
            <input type="button" onclick="generateCode()" value="Generate"/>                 
                 
            </form>
        </div>
    </div>                        
</body>
</html>