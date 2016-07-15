<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

<script type="text/javascript" src="js/helper.js"></script>
<script type="text/javascript" src="js/magus.js"></script>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.leanModal.js" type="text/javascript"></script>


<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/magus.css" rel="stylesheet" type="text/css" />


<script>
	function generateCode() {
		openModal();
		callServer("magus?command=Generate&project="
				+ document.getElementById('id').value, generateCodeStatus)
	}

	function generateCodeStatus() {
		if (HttpReq.readyState == 4 && HttpReq.status == 200) {
			closeModal();
			alert("done!");
		}
	}

	function init() {
		document.getElementById("projectName").value = "Role-Based Access Control";
		document.getElementById("projectShortName").value = "rbac";
		document.getElementById("projectPath").value = "C:/apache-tomcat-7.0.53/webapps/rbac";
		document.getElementById("dbURL").value = "jdbc:hsqldb:hsql://localhost/magusdb";
		document.getElementById("dbUser").value = "sa";
		document.getElementById("dbPass").value = "";
	}

	window.onload = init;
</script>

</head>

<body>
    <%@include file="header.jsp" %>

    <div id="content">

        <div class="left-column">
            bla
        </div>

        <div class="center-column">
            <div style="padding:1%">
                Choose a project: <select id="project" name="project" onchange="loadProject(this.value)">
                    <option value="">Select...</option>
                    <c:forEach var="app" items="${apps}">
                        <option value="<c:out value='${app.id}'/>"><c:out value='${app.name}' /></option>
                    </c:forEach>
                </select>
                <input type="button" value="Generate" onclick="generateCode()" />
                <p>&nbsp;</p>
    
                <div class="tabGroup">
                    <input type="radio" name="tabGroup1" id="rad1" class="tab1" checked="checked" /> <label for="rad1">Application</label> <input type="radio"
                        name="tabGroup1" id="rad2" class="tab2" /> <label for="rad2">Data Source</label> <input type="radio" name="tabGroup1" id="rad3"
                        class="tab3" /> <label for="rad3">Table Selection</label> <input type="radio" name="tabGroup1" id="rad4" class="tab4" /> <label for="rad4">Column
                        Mapping</label>
    
                    <div class="tab1">
                        <form action="" method="post" id="form_example" class="form_example">
                            <input type="hidden" id="id" name="id" value="0" />
                            <ol>
                                <li><label for="projectName"><strong>Name</strong></label> <input id="projectName" name="projectName" class="text medium" /></li>
                                <li><label for="projectShortName"><strong>Short Name</strong></label> <input id="projectShortName" name="projectShortName"
                                    class="text medium" /></li>
                                <li><label for="architecture"><strong>Architecture</strong></label> <select id="architecture" name="architecture" class="input_short">
                                        <option value="JSP_Servlet" selected="selected">JSP & Servlet</option>
                                        <option value="REST">REST</option>
                                        <option value="JSF">JSF</option>
                                </select></li>
                                <li><label for="template"><strong>Template</strong></label> <select id="template" name="template" class="input_short">
                                        <option value="pure" selected="selected">pure</option>
                                        <option value="black">Black</option>
                                        <option value="boxieblue">Boxie Blue</option>
                                </select></li>
    
                                <li><label for="projectPath"><strong>Path</strong></label> <input id="projectPath" name="projectPath" class="text large" /></li>
                                <li><label for="projectDescription"><strong>Description</strong></label> <textarea id="projectDescription"
                                        name="projectDescription" class="text medium"></textarea></li>
                            </ol>
                        </form>
                        <input type="button" value="Save" onclick="newProject()" />
                    </div>
    
    
                    <div class="tab2">
                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="database"><strong>Database</strong></label> <select id="database" name="database">
                                        <c:forEach var="db" items="${magus_config.databases}">
                                            <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}' /></option>
                                        </c:forEach>
                                </select></li>
                                <li><label for="dbURL"><strong>URL (Connection String)</strong></label> <input id="dbURL" name="dbURL" class="text large" /></li>
                                <li><label for="dbUser"><strong>User name</strong></label> <input id="dbUser" name="dbUser" class="text medium" /></li>
                                <li><label for="dbPass"><strong>Password</strong></label> <input id="dbPass" name="dbPass" class="text medium" /></li>
                            </ol>
                        </form>
                        <input type="button" value="Save" onclick="saveProject()" />
                    </div>
    
    
                    <div class="tab3">
                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="schema"><strong>Schema</strong></label> 
                                <select id="schema" name="schema" onchange="listTables(this.value)">
                                </select></li>
                                <li>
                                    <table border="0">
                                        <tr>
                                            <td><label for="tables">Available Tables</label></td>
                                            <td>&nbsp;</td>
                                            <td><label for="tables">Selected Tables</label></td>
                                        </tr>
                                        <tr>
                                            <td><select id="tables" name="tables" multiple="multiple" style="height: 100px"></select></td>
                                            <td align="center"><input type="button" value=">" onclick="moveSelectedTables()" /><br /> <input type="button"
                                                value=">>" onclick="moveAllTables()" /><br /> <input type="button" value="<" onclick=" removeSelectedTables()"/><br />
                                                <input type="button" value="<<" onclick=" removeAllTables()"/></td>
                                            <td><select id="selectedTables" name="selectedTables" multiple="multiple" style="height: 100px"></select></td>
                                        </tr>
                                    </table>
                                </li>
                            </ol>
    
                        </form>
                    </div>
    
    
                    <div class="tab4">
                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="table"><strong>Table</strong></label> <select id="table" name="table" onchange="listTableColumns(this.value)">
                                </select></li>
                                <li>
                                    <table id="columnTbl" name="columnTbl" border="0">
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>Column</td>
                                            <td>Label</td>
                                            <td>Type</td>
                                            <td>Order</td>
                                            <td>&nbsp;</td>
                                            <td>Mask</td>
                                            <td>Visible</td>
                                            <td>Filter</td>
                                            <td>Comment</td>
                                        </tr>
                                    </table>
                                </li>
                            </ol>
                            <input type="button" value="Save" onclick="saveColumnMapping()" />
                        </form>
                    </div>
                </div>                    
            </div>
        </div>
    </div>

    <div id="optionspopup">
        <div id="popupheader">
            <a class="modal_close" href="#"></a>
            <h1>
                <img src="images/wizard.png" style="vertical-align: middle; width: 32px; height: 32px;" /> Column options
            </h1>
        </div>
        <div id="optionspopup_content">
            <div id="addOptions" style="display: none">
                <form action="" method="post" id="form_example" class="form_example">
                    <input type="hidden" id="currentColumn" />
                    <fieldset>
                        <legend>
                            Column mapping - available options for <b><span id="currentColumnTxt"></span></b>
                        </legend>
                        <table style="border: 1px solid silver">
                            <tr>
                                <td>Value</td>
                                <td>Text</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tbody id="columnOptions"></tbody>
                        </table>
                        <br /> <input type="button" value="Delete option" onclick="deleteOption()" /> <input type="button" value="Save options"
                            onclick="saveOptions()" /><br />
                    </fieldset>
                </form>
            </div>

        </div>
    </div>

    <%@include file="footer.jsp" %>

    <div id="fade"></div>
    <div id="modal">
        <img id="loader" src="images/loading.gif" />
    </div>
</body>
</html>