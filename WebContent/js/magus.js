/**
 * Call server to check connection of the selected database.
 */
function checkConnection() {
	callServer("magus?command=Database&action=checkConnection&database="
			+ document.getElementById('database').value + "&url="
			+ document.getElementById('dbURL').value + "&username="
			+ document.getElementById('dbUser').value + "&password="
			+ document.getElementById('dbPass').value, checkConnectionStatus);
}

/**
 * Return the database connection status.
 */
function checkConnectionStatus() {
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;
		alert(HttpReq.responseText);
	}
}

function submit(formAction, command, action, pageNum) {
	var form = createForm("myform", "post", formAction);
	var input1 = createInput("command", "hidden", command);
	var input2 = createInput("action", "hidden", action);
	var input3 = createInput("pageNum", "hidden", pageNum);
	form.appendChild(input1);
	form.appendChild(input2);
	form.appendChild(input3);
	document.body.appendChild(form);
	form.submit();
}

/**
 * Call server to create new project.
 */
function newProject() {
	var projectName = document.getElementById("projectName").value;
	var projectShortName = document.getElementById("projectShortName").value;
	var projectDescription = document.getElementById("projectDescription").value;
	var projectPath = document.getElementById("projectPath").value;
	var template = document.getElementById("template").value;
	var architecture = document.getElementById("architecture").value;

	callServer("magus?command=Project&action=new&projectName=" + projectName
			+ "&shortName=" + projectShortName + "&description="
			+ projectDescription + "&path=" + projectPath + "&template="
			+ template + "&architecture=" + architecture, newProjectStatus);
}

/**
 * Create new project status.
 */
function newProjectStatus() {
	// Server return the information in a XML.
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;
		var app = xml.getElementsByTagName("application");
		var id = app[0].getAttribute("id");
		document.getElementById("id").value = id;

		alert(id);

	}
}

/**
 * Call server to retrieve information for the selected project.
 */
function loadProject(project) {
	if (project != "") {
		callServer("magus?command=Project&action=load&project=" + project,
				loadProjectStatus);
	}
}

/**
 * Return all information available for current selected project.
 */
var projectTables = new Array();
var projectSchema;
function loadProjectStatus() {
	// Server return the information in a XML.
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;

		// Retrieve application related information.
		var app = xml.getElementsByTagName("application");
		var id = app[0].getAttribute("id");
		var shortName = app[0].getAttribute("shortName");
		var name = getNodeValue(app[0], "name");
		var path = getNodeValue(app[0], "path");
		var template = getNodeValue(app[0], "template");
		var architecture = getNodeValue(app[0], "architecture");

		// Retrieve database information used by the application.
		var db = app[0].getElementsByTagName("database");
		var dbtype = getNodeValue(db[0], "type");
		var dbconnString = getNodeValue(db[0], "connectionString");
		var dbuser = getNodeValue(db[0], "username");
		var dbpass = getNodeValue(db[0], "password");

		// Retrieve tables.
		var tbl = app[0].getElementsByTagName("table");
		projectTables = new Array();
		for (var i = 0; i < tbl.length; i++) {
			projectTables[projectTables.length] = tbl[i].getAttribute("name");
			projectSchema = getNodeValue(tbl[i], "schema");
		}

		// Populate wizard field with the information retrieved.
		document.getElementById("id").value = id;
		document.getElementById("projectName").value = name;
		document.getElementById("projectShortName").value = shortName;
		document.getElementById("projectPath").value = path;
		document.getElementById("template").value = template;
		document.getElementById("architecture").value = architecture;

		document.getElementById("database").value = dbtype;
		document.getElementById("dbURL").value = dbconnString;
		document.getElementById("dbUser").value = dbuser;
		document.getElementById("dbPass").value = dbpass;

		listSchemas();
	}
}

function saveProject() {
	var id = document.getElementById("id").value;
	var database = document.getElementById("database").value;
	var dbURL = document.getElementById("dbURL").value;
	var dbUser = document.getElementById("dbUser").value;
	var dbPass = document.getElementById("dbPass").value;

	callServer("magus?command=Project&action=save&id=" + id + "&database="
			+ database + "&dbURL=" + dbURL + "&dbUser=" + dbUser + "&dbPass="
			+ dbPass, saveProjectStatus);
}

function saveProjectStatus() {
	// When the response is ready to be processed.
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		listSchemas();
	}
}

/**
 * Call server to retrieve schemas of the selected database.
 */
function listSchemas() {
	callServer("magus?command=Database&action=listSchemas&database="
			+ document.getElementById('database').value + "&url="
			+ document.getElementById('dbURL').value + "&username="
			+ document.getElementById('dbUser').value + "&password="
			+ document.getElementById('dbPass').value, listSchemasStatus);
}

/**
 * At the end of the execution of listSchemas() procedure, the server will
 * return an XML with all database available schemas.
 */
function listSchemasStatus() {
	// When the response is ready to be processed.
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		// Empty schemas selection box.
		schemaCbo = document.getElementById("schema");
		schemaCbo.options.length = 0;
		// Get XML from the server.
		var xml = HttpReq.responseXML;
		var schemas = xml.getElementsByTagName("schema");
		// For each schema returned add an option in the selection box.
		for (var i = 0; i < schemas.length; i++) {
			schemaName = schemas[i].firstChild.nodeValue;
			createSelectOption(schemaCbo, schemaName, schemaName);
		}
		if(!projectSchema) {
			projectSchema = schemaCbo.options[schemaCbo.selectedIndex].text
		}
		schemaCbo.value = projectSchema;
		listTables(projectSchema);
	}
}

/**
 * Call server to retrieve tables of the selected schema.
 */
function listTables(schema) {
	if (schema) {
		callServer("magus?command=Database&action=listTables&schema=" + schema,
				listTablesStatus);
	}
}

/**
 * At the end of the execution of listTables() procedure, the server will return
 * an XML with all tables of the selected cshema.
 */
function listTablesStatus() {
	// When the response is ready to be processed.
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;
		// Empty tables selection box.
		tableCbo = document.getElementById("tables");
		tableCbo.options.length = 0;
		var selectedTables = document.getElementById("selectedTables");
		selectedTables.options.length = 0;
		// Get XML from the server.
		var xml = HttpReq.responseXML;
		var tables = xml.getElementsByTagName("table");
		// For each schema returned add an option in the selection box.
		for (var i = 0; i < tables.length; i++) {
			tableName = tables[i].firstChild.nodeValue;
			if (projectTables.indexOf(tableName) >= 0) {
				createSelectOption(selectedTables, tableName, tableName);
			} else {
				createSelectOption(tableCbo, tableName, tableName);
			}
		}
		loadSelectedTables();
	}
}

/**
 * Move only selected tables for source code generation.
 */
function moveSelectedTables() {
	var tables = document.getElementById("tables");
	var selectedTables = document.getElementById("selectedTables");
	selectMoveRows(tables, selectedTables, true);
	loadSelectedTables();
}

/**
 * Select all tables for source code generation.
 */
function moveAllTables() {
	selectAll("tables", true)
	moveSelectedTables();
}

/**
 * Remove selected tables for source code generation.
 */
function removeSelectedTables() {
	var tables = document.getElementById("tables");
	var selectedTables = document.getElementById("selectedTables");
	selectMoveRows(selectedTables, tables, true);
	loadSelectedTables();
}

/**
 * Remove all tables for source code generation.
 */
function removeAllTables() {
	selectAll("selectedTables", true)
	removeSelectedTables();
}

/**
 * Load selected tables.
 */
function loadSelectedTables() {
	emptyCombo("table", "Select...");
	selectAll("selectedTables", true);
	var selectedTables = document.getElementById("selectedTables");
	var table = document.getElementById("table");
	selectMoveRows(selectedTables, table, false, true, 1);
}

/**
 * List columns of the selected table.
 * 
 * @param table
 */
function listTableColumns(table) {
	if (table != "") {
		callServer("magus?command=Database&action=listTableColumns&id="
				+ document.getElementById('id').value + "&schema="
				+ document.getElementById('schema').value + "&table=" + table,
				listTableColumnsStatus);
	}
}

function listTableColumnsStatus() {
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;
		var xmlData = xml.getElementsByTagName("column");

		//deleteTableRows("columnTbl", false);
		document.querySelector("#columns").innerHTML="";
		
		for (i = 0; i < xmlData.length; i++) {
			label = "";
			if (xmlData[i].getElementsByTagName("label")[0].childNodes[0]) {
				label = xmlData[i].getElementsByTagName("label")[0].childNodes[0].nodeValue;
			}
			columnType = "";
			if (xmlData[i].getElementsByTagName("type")[0].childNodes[0]) {
				columnType = xmlData[i].getElementsByTagName("type")[0].childNodes[0].nodeValue;
			}
			displayOrder = i + 1;
			if (xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0]) {
				displayOrder = xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0].nodeValue;
			}
			comment = "";
			if (xmlData[i].getElementsByTagName("comment")[0].childNodes[0]) {
				comment = xmlData[i].getElementsByTagName("comment")[0].childNodes[0].nodeValue;
			}
			masked = "";
			if (xmlData[i].getElementsByTagName("mask")[0].childNodes[0]) {
				masked = xmlData[i].getElementsByTagName("mask")[0].childNodes[0].nodeValue;
			}
			visible = "";
			if (xmlData[i].getElementsByTagName("visible")[0].childNodes[0]) {
				visible = xmlData[i].getElementsByTagName("visible")[0].childNodes[0].nodeValue;
			}
			filter = "";
			if (xmlData[i].getElementsByTagName("filter")[0].childNodes[0]) {
				filter = xmlData[i].getElementsByTagName("filter")[0].childNodes[0].nodeValue;
			}
			addRow("columnTbl", xmlData[i].getAttribute("name"), label,
					columnType, displayOrder, comment, masked, visible, filter);
			createSelectOption(document.getElementById("tableOrder"),xmlData[i].getAttribute("name"),xmlData[i].getAttribute("name"),xml.getElementsByTagName("orderBy")[0].childNodes[0].nodeValue);
		}
	}
}

function addRow(tableID, columnName, label, columnType, displayOrder, comment,
		masked, visible, filter) {

	var columns = document.querySelector("#columns");
	
	var row = document.createElement("div");
	row.style.padding="0px 0px 0px 20px";
	row.classList.add("row");
	columns.appendChild(row);
	
	
	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	var element1 = document.createElement("input");
	element1.type = "checkbox";
	element1.name = "chkbox[]";
	element1.id = "chkbox[]";
	element1.value = columnName;
	div1.appendChild(element1);
	var label1 = document.createElement("label");
	label1.textContent = "Column: " + columnName;
	label1.style.padding="0px 15px 0px 10px";
	div1.appendChild(label1);
	row.appendChild(div1);

	var row = document.createElement("div");
	row.style.padding="0px 0px 0px 20px";
	row.classList.add("row");
	columns.appendChild(row);
	
	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("input");
	input.name = "label[]";
	input.id = "label[]";
	input.placeholder = "Label...";
	input.value=label;
	input.type="text";
	input.classList.add("form-control");
	div1.appendChild(input);
	row.appendChild(div1);

	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("select");
	// See FieldType.java
	// TEXTBOX, CHECKBOX, RADIOBUTTON, SELECTBOXFK, TEXTAREA, HIDDEN, SELECTBOX,
	// DATEPICKER
	createSelectOption(input, "0", "TextBox", columnType);
	createSelectOption(input, "1", "CheckBox", columnType);
	createSelectOption(input, "2", "RadioButton", columnType);
	createSelectOption(input, "3", "SelectBoxFK", columnType);
	createSelectOption(input, "4", "TextArea", columnType);
	createSelectOption(input, "5", "Hidden", columnType);
	createSelectOption(input, "6", "SelectBox", columnType);
	createSelectOption(input, "7", "DatePicker", columnType);
	createSelectOption(input, "8", "RichTextEditor", columnType);
	createSelectOption(input, "9", "PNG", columnType);
	createSelectOption(input, "10", "PDF", columnType);
	input.id = "selbox[]";
	input.name = "selbox[]";
	input.classList.add("form-control");
	div1.appendChild(input);
	row.appendChild(div1);

	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("input");
	input.name = "order[]";
	input.id = "order[]";
	input.placeholder = "Order...";
	input.type="text";
	input.value=displayOrder;
	input.classList.add("form-control");
	div1.appendChild(input);
	row.appendChild(div1);
	
	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("input");
	input.name = "masked[]";
	input.id = "masked[]";
	input.placeholder = "Mask...";
	input.type="text";
	input.value=masked;
	input.classList.add("form-control");
	div1.appendChild(input);
	row.appendChild(div1);

	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("select");
	createSelectOption(input, "Y", "Yes", "Y");
	createSelectOption(input, "N", "No", "Y");
	input.name = "visible[]";
	input.id = "visible[]";
	input.classList.add("form-control");
	input.value=visible;
	div1.appendChild(input);
	row.appendChild(div1);

	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("select");
	createSelectOption(input, "Y", "Yes", "Y");
	createSelectOption(input, "N", "No", "Y");
	input.name = "filter[]";
	input.id = "filter[]";
	input.classList.add("form-control");
	input.value=filter;
	div1.appendChild(input);
	row.appendChild(div1);

	var div1 = document.createElement("div");
	div1.classList.add("form-group");
	div1.style.padding="0px 5px 5px 0px";
	var input = document.createElement("input");
	input.name = "comment[]";
	input.id = "comment[]";
	input.placeholder = "Comment...";
	input.type="text";
	input.value = comment;
	input.classList.add("form-control");
	div1.appendChild(input);
	row.appendChild(div1);

}	
function addRow_old(tableID, columnName, label, columnType, displayOrder, comment,
		masked, visible, filter) {

	var table = document.getElementById(tableID);

	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);

	var cell1 = row.insertCell(0);
	var element1 = document.createElement("input");
	element1.type = "checkbox";
	element1.name = "chkbox[]";
	element1.id = "chkbox[]";
	element1.value = columnName;
	cell1.appendChild(element1);

	var cell3 = row.insertCell(1);
	cell3.innerHTML = columnName;

	var cell2 = row.insertCell(2);
	var element2 = document.createElement("input");
	element2.type = "text";
	element2.name = "label[]";
	element2.id = "label[]";
	element2.size = 10;
	element2.value = label;
	cell2.appendChild(element2);

	var cell4 = row.insertCell(3);
	var element2 = document.createElement("select");
	element2.className = "input_short";
	element2.id = "selbox[]";
	element2.name = "selbox[]";
	// See FieldType.java
	// TEXTBOX, CHECKBOX, RADIOBUTTON, SELECTBOXFK, TEXTAREA, HIDDEN, SELECTBOX,
	// DATEPICKER
	createSelectOption(element2, "0", "TextBox", columnType);
	createSelectOption(element2, "1", "CheckBox", columnType);
	createSelectOption(element2, "2", "RadioButton", columnType);
	createSelectOption(element2, "3", "SelectBoxFK", columnType);
	createSelectOption(element2, "4", "TextArea", columnType);
	createSelectOption(element2, "5", "Hidden", columnType);
	createSelectOption(element2, "6", "SelectBox", columnType);
	createSelectOption(element2, "7", "DatePicker", columnType);
	createSelectOption(element2, "8", "RichTextEditor", columnType);
	createSelectOption(element2, "9", "PNG", columnType);
	createSelectOption(element2, "10", "PDF", columnType);
	cell4.appendChild(element2);

	var cell5 = row.insertCell(4);
	var element3 = document.createElement("input");
	element3.type = "text";
	element3.name = "order[]";
	element3.id = "order[]";
	element3.size = 5;
	element3.value = displayOrder;
	cell5.appendChild(element3);

	var link = document.createElement("a");
	link.setAttribute("rel", "leanModal");
	link.setAttribute("href", "#optionspopup");
	link.style = "text-decoration:none";
	link.name = "optionspopup";
	var cell6 = row.insertCell(5);
	var element4 = document.createElement("input");
	element4.type = "button";
	element4.value = "options"
	element4.setAttribute('onclick', 'checkColumnType(' + "'" + tableID + "', "
			+ (rowCount - 1) + ');');
	link.appendChild(element4);
	cell6.appendChild(link);

	var cell7 = row.insertCell(6);
	var element7 = document.createElement("input");
	element7.type = "text";
	element7.name = "masked[]";
	element7.id = "masked[]";
	element7.size = 20;
	element7.value = masked;
	cell7.appendChild(element7);

	var cell8 = row.insertCell(7);
	var element8 = document.createElement("select");
	createSelectOption(element8, "Y", "Yes", "Y");
	createSelectOption(element8, "N", "No", "Y");
	element8.className = "input_short";
	element8.id = "visible[]";
	element8.name = "visible[]";
	element8.value = visible;
	cell8.appendChild(element8);

	var cell9 = row.insertCell(8);
	var element9 = document.createElement("select");
	createSelectOption(element9, "Y", "Yes", "Y");
	createSelectOption(element9, "N", "No", "N");
	element9.className = "input_short";
	element9.id = "filter[]";
	element9.name = "filter[]";
	element9.value = filter;
	cell9.appendChild(element9);

	var cell10 = row.insertCell(9);
	var element10 = document.createElement("input");
	element10.type = "text";
	element10.name = "comment[]";
	element10.id = "comment[]";
	element10.size = 80;
	element10.value = comment;
	cell10.appendChild(element10);
/*
	$('a[rel*=leanModal]').leanModal({
		overlay : 0.8,
		closeButton : ".modal_close",
		closeCSS : ".closepopup"
	});*/

}

function checkColumnType(tableID, row) {
	var table = document.getElementById(tableID);
	var column = table.rows[row + 1].cells[1].firstChild.nodeValue;
	var e = document.getElementsByName("selbox[]")[row];
	var type = e.options[e.selectedIndex].value;

	document.getElementById("addOptions").style.display = "block";
	document.getElementById("currentColumn").value = column;
	document.getElementById("currentColumnTxt").innerHTML = column;

	var query = "&project=" + document.getElementById('project').value;
	query += "&schema=" + document.getElementById('schema').value;
	query += "&table=" + document.getElementById('table').value;
	query += "&column=" + column;
	callServer("magus?command=Database&action=listColumnOptions" + query,
			checkColumnTypeStatus);

}

function checkColumnTypeStatus() {
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		var xml = HttpReq.responseXML;
		var xmlData = xml.getElementsByTagName("option");
		deleteTableRows("columnOptions", true);
		for (i = 0; i < xmlData.length; i++) {
			value = "";
			if (xmlData[i].getElementsByTagName("value")[0].childNodes[0]) {
				value = xmlData[i].getElementsByTagName("value")[0].childNodes[0].nodeValue;
			}
			text = "";
			if (xmlData[i].getElementsByTagName("text")[0].childNodes[0]) {
				text = xmlData[i].getElementsByTagName("text")[0].childNodes[0].nodeValue;
			}
			displayOrder = "";
			if (xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0]) {
				displayOrder = xmlData[i].getElementsByTagName("displayOrder")[0].childNodes[0].nodeValue;
			}
			addOption(value, text);
		}

		// Add new option value/text fields in the table
		var table = document.getElementById("columnOptions");
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		var cell1 = row.insertCell(0);
		var element1 = document.createElement("input");
		element1.name = "optionValue";
		element1.id = "optionValue";
		cell1.appendChild(element1);
		var cell2 = row.insertCell(1);
		var element2 = document.createElement("input");
		element2.name = "optionText";
		element2.id = "optionText";
		cell2.appendChild(element2);
		// Attach onenter to add an option.
		document.getElementById('optionText').onkeydown = function(e) {
			if (e.keyCode == 13) {
				addOption(document.getElementById('optionValue').value,
						document.getElementById('optionText').value, true);
			}
		};
		var cell3 = row.insertCell(2);
		var element = document.createElement("input");
		element.type = "checkbox";
		cell3.appendChild(element);
		document.getElementById('optionValue').focus();
	}

}

function addOption(value, text, emptyOption) {
	var table = document.getElementById("columnOptions");

	var rowCount = table.rows.length - 1;
	var row = table.insertRow(rowCount);

	var cell1 = row.insertCell(0);
	cell1.innerHTML = value;

	var cell2 = row.insertCell(1);
	cell2.innerHTML = text;

	var cell3 = row.insertCell(2);
	var element = document.createElement("input");
	element.type = "checkbox";
	cell3.appendChild(element);

	if (emptyOption) {
		document.getElementById('optionValue').value = "";
		document.getElementById('optionText').value = "";
		document.getElementById('optionValue').focus();
	}
}

function deleteOption() {
	var table = document.getElementById("columnOptions");

	for (var rowi = table.rows.length; rowi-- > 0;) {
		var row = table.rows[rowi];
		var inputs = row.getElementsByTagName('input');
		for (var inputi = inputs.length; inputi-- > 0;) {
			var input = inputs[inputi];
			if (input.type === 'checkbox' && input.checked) {
				row.parentNode.removeChild(row);
				break;
			}
		}
	}
	saveOptions();
}

function saveOptions() {
	var query = "&project=" + document.getElementById('project').value;
	query += "&schema=" + document.getElementById('schema').value;
	query += "&table=" + document.getElementById('table').value;
	query += "&column=" + document.getElementById('currentColumn').value;
	query += "&colOpts=";

	var table = document.getElementById("columnOptions");
	var rowCount = table.rows.length;
	for (var i = 0; i < rowCount - 1; i++) {
		value = table.rows[i].cells[0].firstChild.nodeValue
		text = table.rows[i].cells[1].firstChild.nodeValue
		query += value + "," + text + ";";
	}

	callServer("magus?command=Database&action=saveColumnOptions" + query,
			saveOptionsStatus);

}

function saveOptionsStatus() {

}


function saveTableMapping() {
	var query = "&project=" + document.getElementById('project').value;
	query += "&schema=" + document.getElementById('schema').value;
	query += "&table=" + document.getElementById('table').value;
	query += "&tableAlias=" + document.getElementById('tableAlias').value;
	query += "&tableLabel=" + document.getElementById('tableLabel').value;
	query += "&tableOrder=" + document.getElementById('tableOrder').value;
	query += "&tableExport=" + document.getElementById('tableExport').value;
	callServer("magus?command=Database&action=saveTableMapping" + query, saveTableMappingStatus);
}

function saveTableMappingStatus() {

}

function saveColumnMapping() {
	var query = "&project=" + document.getElementById('project').value;
	query += "&schema=" + document.getElementById('schema').value;
	query += "&table=" + document.getElementById('table').value;
	var eles = document.getElementsByName('chkbox[]');
	for (i = 0; i < eles.length; i++) {
		query += "&columns=" + eles[i].value;
	}
	var eles2 = document.getElementsByName('selbox[]');
	for (i = 0; i < eles2.length; i++) {
		query += "&type=" + eles2[i].value;
	}
	var eles3 = document.getElementsByName('order[]');
	for (i = 0; i < eles3.length; i++) {
		query += "&order=" + eles3[i].value;
	}
	var eles4 = document.getElementsByName('label[]');
	for (i = 0; i < eles4.length; i++) {
		query += "&label=" + eles4[i].value;
	}
	var eles5 = document.getElementsByName('comment[]');
	for (i = 0; i < eles5.length; i++) {
		query += "&comment=" + eles5[i].value;
	}
	var eles6 = document.getElementsByName('masked[]');
	for (i = 0; i < eles6.length; i++) {
		query += "&masked=" + eles6[i].value;
	}
	var eles7 = document.getElementsByName('visible[]');
	for (i = 0; i < eles7.length; i++) {
		query += "&visible=" + eles7[i].value;
	}
	var eles8 = document.getElementsByName('filter[]');
	for (i = 0; i < eles8.length; i++) {
		query += "&filter=" + eles8[i].value;
	}

	callServer("magus?command=Database&action=saveColumnMapping" + query,
			saveColumnMappingStatus);
}

function saveColumnMappingStatus() {

}
/*
function generateCode() {
	openModal();
	callServer("magus?command=Generate&project="
			+ document.getElementById('project').value + "&shortName="
			+ document.getElementById('shortName').value + "&name="
			+ document.getElementById('name').value + "&path="
			+ document.getElementById('path').value + "&template="
			+ document.getElementById("template").value, generateCodeStatus)
}

function generateCodeStatus() {
	if (HttpReq.readyState == 4 && HttpReq.status == 200) {
		closeModal();
		var xml = HttpReq.responseXML;
	}
}
*/

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

function isEmpty(value) {
	  return typeof value == 'string' && !value.trim() || typeof value == 'undefined' || value === null;
}