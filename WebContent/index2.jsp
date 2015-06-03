<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/create_form.css" type="text/css" />
    
    <script type="text/javascript" src="js/helper.js"></script>

    <script type="text/javascript">
        function connectDatabase() {
        	callServer("magus?command=ConnectDatabase&url=" + document.getElementById('url').value+"&username="+document.getElementById('username').value+"&password="+document.getElementById('password').value, showConnectionStatus);
        }
        
        function populateCombo(combo, reset, addSelect, xmlData) {
        	if(reset) {
            	combo.options.length = 0;
        	}
        	if(addSelect) {
        		combo.options[combo.options.length] = new Option("Select...","");
        	}
        	for (i=0;i<xmlData.length;i++) {
    			combo.options[combo.options.length] = new Option(xmlData[i].childNodes[0].nodeValue, xmlData[i].childNodes[0].nodeValue);
        	}
        }
        
        function showConnectionStatus() {
        	if (HttpReq.readyState == 4 && HttpReq.status == 200){
            	var xml = HttpReq.responseXML;
            	// Clear previous selected tables.
            	document.getElementById("selectedTables").length = 0;
            	var select = document.getElementById("schema");
            	populateCombo(select,true,true,xml.getElementsByTagName("schema"));
			}
        }
        
        function changeSchema(schema) {
        	if(schema != "") {
        		callServer("magus?command=ListTables&schema=" + schema, populateTables);
        	}
        }
        function changeTable(table) {
        	if(table != "") {
        		callServer("magus?command=ListColumns&schema=" + document.getElementById('schema').value + "&table=" + table, populateColumns);
        	}
        }
        
        function populateTables() {
        	if (HttpReq.readyState == 4 && HttpReq.status == 200){
            	var xml = HttpReq.responseXML;
            	var select = document.getElementById("tables");
            	populateCombo(select,true,false,xml.getElementsByTagName("table"));
			}
        }

        function populateColumns() {
        	if (HttpReq.readyState == 4 && HttpReq.status == 200){
            	var xml = HttpReq.responseXML;
            	
            	//alert(HttpReq.responseText);
            	
            	var xmlData = xml.getElementsByTagName("column");
            	
            	//alert("-->"+xmlData[0].getElementsByTagName("type")[0].childNodes[0]);
            	//alert("-->"+xmlData[0].getElementsByTagName("type")[0].childNodes[0].nodeValue);

            	
            	deleteTableRows("columnTbl",false);
            	for(i=0; i < xmlData.length; i++) {
            		label = "";
            		if(xmlData[i].getElementsByTagName("label")[0].childNodes[0]) {
            			label=xmlData[i].getElementsByTagName("label")[0].childNodes[0].nodeValue;
            		}
            		columnType = "";
            		if(xmlData[i].getElementsByTagName("type")[0].childNodes[0]) {
            			columnType=xmlData[i].getElementsByTagName("type")[0].childNodes[0].nodeValue;
            		}
            		displayOrder = i + 1;
            		if(xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0]) {
            			displayOrder=xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0].nodeValue;
            		}
            		addRow("columnTbl",xmlData[i].getAttribute("name"),label, columnType, displayOrder);
        		}
			}
        }
        
        function addRow(tableID, columnName, label, columnType, displayOrder) {
        	 
            var table = document.getElementById(tableID);
 
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
 
            var cell1 = row.insertCell(0);
            var element1 = document.createElement("input");
            element1.type = "checkbox";
            element1.name="chkbox[]";
            element1.id="chkbox[]";
            element1.value=columnName;
            cell1.appendChild(element1);
 
            var cell3 = row.insertCell(1);
            cell3.innerHTML = columnName;

            var cell2 = row.insertCell(2);
            var element2 = document.createElement("input");
            element2.type = "text";
            element2.name="label[]";
            element2.id="label[]";
            element2.size=10;
            element2.value=label;
            cell2.appendChild(element2);

            var cell4 = row.insertCell(3);
            var element2 = document.createElement("select");
            element2.id = "selbox[]";
            element2.name = "selbox[]";
            element2.setAttribute('onChange','checkColumnType(' + (rowCount-1) + ');'); 
            createSelectOption(element2, "0", "TextBox",columnType);
            createSelectOption(element2, "1", "CheckBox",columnType);
            createSelectOption(element2, "2", "RadioButton",columnType);
            createSelectOption(element2, "3", "SelectBox",columnType);
            createSelectOption(element2, "4", "TextArea",columnType);
            createSelectOption(element2, "5", "Hidden",columnType);
            cell4.appendChild(element2);
            
            var cell5 = row.insertCell(4);
            var element3 = document.createElement("input");
            element3.type = "text";
            element3.name="order[]";
            element3.id="order[]";
            element3.size=5;
            element3.value=displayOrder;
            cell5.appendChild(element3);
            
        }     
        
        function checkColumnType(row) {
        	var e = document.getElementsByName("selbox[]")[row];
        	var type = e.options[e.selectedIndex].value;
        	
        	alert("seçected type=" + type);
        }

        /**
         * Populate combo for select colum tables.
         */
        function loadColumns() {
         	emptyCombo("table","Select...");
        	selectAll("selectedTables",true);
        	var selectedTables = document.getElementById("selectedTables");
        	var table = document.getElementById("table");
        	
        	
            selectMoveRows(selectedTables,table, false);        	
        }

        function generate() {
        	callServer("magus?command=Generate&shortName=" + document.getElementById('shortName').value+"&name=" + document.getElementById('name').value+"&path=" + document.getElementById('path').value, generationStatus);
        }

        function save() {
        	var query="&table="+document.getElementById('table').value;
        	var eles = document.getElementsByName('chkbox[]');
        	for(i=0; i < eles.length; i++) {
        		query += "&columns=" + eles[i].value;
        	}
        	var eles2 = document.getElementsByName('selbox[]');
        	for(i=0; i < eles2.length; i++) {
        		query += "&type=" + eles2[i].value;
        	}
        	var eles3 = document.getElementsByName('order[]');
        	for(i=0; i < eles3.length; i++) {
        		query += "&order=" + eles3[i].value;
        	}
        	var eles4 = document.getElementsByName('label[]');
        	for(i=0; i < eles4.length; i++) {
        		query += "&label=" + eles4[i].value;
        	}
        	callServer("magus?command=ListColumns&action=save"+query, generationStatus);
        }

        /**
         * Move only selected tables for source code generation.
         */
        function moveSelectedTables() {
        	var tables = document.getElementById("tables");
        	var selectedTables = document.getElementById("selectedTables");
			selectMoveRows(tables,selectedTables,true);        	
			loadColumns();
        }
        
        /**
         * Select all tables for source code generation.
         */
        function moveAllTables() {
        	selectAll("tables",true)
        	moveSelectedTables();
        }
        
        /**
         * Remove selected tables for source code generation.
         */
        function removeSelectedTables() {
        	var tables = document.getElementById("tables");
        	var selectedTables = document.getElementById("selectedTables");
			selectMoveRows(selectedTables, tables, true);    
			loadColumns();
        }
        
        /**
         * Remove all tables for source code generation.
         */
        function removeAllTables() {
        	selectAll("selectedTables",true)
        	removeSelectedTables();
        }
      
        function generationStatus() {
        }
  
        
    </script>
    
</head>
<body>

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
                            <input id="name" name="name" type="text" size="40" maxlength="80" value="Magus Demo Application"/>
                        </li>
                        <li> 
                            <label for="shortName">shortName*</label>
                            <input id="shortName" name="shortName" type="text" size="20" maxlength="20" value="demoapp"/>
                        </li>
                        <li> 
                            <label for="path">path*</label>
                            <input id="path" name="path" type="text" size="80" maxlength="80" value="/home/88758559000/java/apache-tomcat-7.0.5/webapps/demoapp"/>
                        </li>
                        <li> 
                            <label for="template">template*</label>
                            <select id="template" name="template">
                                <option value="boxieblue">Boxie Blue</option>
                            </select>
                        </li>
                    </ol>
                </fieldset>     
                 <br/>
                 <div><button type="submit" id="submit-go" value="next">Next</button></div>
            </fieldset>     
        
            <fieldset class="main">
                <legend>Step 2: Database settings</legend>
                <fieldset class="nested">
                    <legend>Database</legend>    
                    <ol>
                        <li> 
                            <label for="database">database*</label>
                            <select id="database" name="database">
                                <option value="postgresql">PostgreSQL</option>
                            </select>
                        </li>
                        <li> 
                            <label for="url">url*</label>
                            <input id="url" name="url" type="text" size="40" maxlength="80" value="jdbc:postgresql://localhost:5432/company"/>
                        </li>
                        <li> 
                            <label for="username">username*</label>
                            <input id="username" name="username" type="text" size="40" maxlength="20" value="postgres"/>
                        </li>
                        <li> 
                            <label for="password">password</label>
                            <input id="password" name="password" type="text" size="40" maxlength="20" value="postgres"/>
                        </li>
                    </ol>
                </fieldset>     
                <input type="button" onclick="connectDatabase()" value="Check"/>
                 <br/>
                 <div><button type="submit" id="submit-go" value="next">Next</button></div>
            </fieldset>
            
            <fieldset class="main">
                <legend>Step 3: Select tables</legend>
                <fieldset class="nested">
                    <legend>Tables</legend>    
                    <ol>
                        <li> 
                            <label for="schema">schema*</label>
                            <select id="schema" name="schema" onchange="changeSchema(this.value)">
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
                 <div><button type="button" value="next" onclick="loadColumns()">Next</button></div>
            </fieldset>

            <fieldset class="main">
                <legend>Step 4: Map columns</legend>
                <fieldset class="nested">
                    <legend>Mapping</legend>    
                    <ol>
                        <li> 
                            <label for="schema">table*</label>
                            <select id="table" name="table" onchange="changeTable(this.value)">
                                <option value="">Select...</option>
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
                            </tr>
                            </table>
                            <br/>
                            <input type="button" value="Save" onclick="save()"/>
                        </li>
                    </ol>
                </fieldset>     
                 <br/>
                 <div><button type="button" value="next">Next</button></div>
            </fieldset>
            
            <br/>
            <input type="button" onclick="generate()" value="Generate"/>
                 
        </form>
    </div>
</body>
</html>