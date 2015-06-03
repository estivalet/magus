<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/fancytree/ui.fancytree.css" rel="stylesheet" type="text/css"/>
<link href="css/magus.css" rel="stylesheet" type="text/css"/>


<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery-ui.custom.js" type="text/javascript"></script>
<script src="js/jquery.fancytree.js" type="text/javascript"></script>
<script src="js/js.js" type="text/javascript" ></script>
<script src="js/jquery.leanModal.js" type="text/javascript"></script>
<script src="js/helper.js" type="text/javascript"></script>


  <script type="text/javascript">

  /**
   * List columns of the selected table.
   * @param table
   */
  function listTableColumns(project, schema, table) {
      if(table != "") {
          callServer("magus?command=Database&action=listTableColumns&id="+project + "&schema=" + schema + "&table=" + table, listTableColumnsStatus);
      }
  }

  function listTableColumnsStatus() {
      if (HttpReq.readyState == 4 && HttpReq.status == 200){
          var xml = HttpReq.responseXML;

          // Table data
          var tableData = xml.getElementsByTagName("table");
          tableName=tableData[0].getElementsByTagName("name")[0].childNodes[0].nodeValue;
          tableLabel=tableData[0].getElementsByTagName("label")[0].childNodes[0].nodeValue;
          tableOrderBy=tableData[0].getElementsByTagName("orderBy")[0].childNodes[0].nodeValue;
          document.getElementById("tableName").value = tableName;
          document.getElementById("tblName").innerHTML = tableName;
          document.getElementById("tableLabel").value = tableLabel;
          orderByCols = document.getElementById("tableOrderBy");
          
          // Column data.
          var xmlData = xml.getElementsByTagName("column");
          columns = document.getElementById("column");
          emptyCombo("column", "");
          emptyCombo("tableOrderBy", "");
          for(i=0; i < xmlData.length; i++) {
              column = xmlData[i].getAttribute("name");
              createSelectOption(columns, column, column);
              createSelectOption(orderByCols, column, column);
          }

          document.getElementById("tableOrderBy").value = tableOrderBy;
      }
  }

  function listColumnMapping(column) {
      if(column != "") {
          var project = document.getElementById("currentProject").value;
          var schema = document.getElementById("currentSchema").value;
          var table = document.getElementById("currentTable").value;
    
          callServer("magus?command=Database&action=listColumnMapping&project="+project + "&schema=" + schema + "&table=" + table + "&column=" + column, listColumnMappingStatus);
      }
  }

  function listColumnMappingStatus() {
      if (HttpReq.readyState == 4 && HttpReq.status == 200){
          var xml = HttpReq.responseXML;
          var xmlData = xml.getElementsByTagName("column");

          label = "";
          if(xmlData[0].getElementsByTagName("label")[0].childNodes[0]) {
              label=xmlData[0].getElementsByTagName("label")[0].childNodes[0].nodeValue;
          }
          columnType = "";
          if(xmlData[0].getElementsByTagName("type")[0].childNodes[0]) {
              columnType=xmlData[0].getElementsByTagName("type")[0].childNodes[0].nodeValue;
          }
          displayOrder = i + 1;
          if(xmlData[0].getElementsByTagName("displayOrder")[0].childNodes[0]) {
              displayOrder=xmlData[0].getElementsByTagName("displayOrder")[0].childNodes[0].nodeValue;
          }
          options = "";
          if(xmlData[0].getElementsByTagName("options")[0].childNodes[0]) {
              options=xmlData[0].getElementsByTagName("options")[0].childNodes[0].nodeValue;
          }
          comment = "";
          if(xmlData[0].getElementsByTagName("comment")[0].childNodes[0]) {
              comment=xmlData[0].getElementsByTagName("comment")[0].childNodes[0].nodeValue;
          }
          mask = "";
          if(xmlData[0].getElementsByTagName("mask")[0].childNodes[0]) {
              mask=xmlData[0].getElementsByTagName("mask")[0].childNodes[0].nodeValue;
          }
          visible = "";
          if(xmlData[0].getElementsByTagName("visible")[0].childNodes[0]) {
        	  visible=xmlData[0].getElementsByTagName("visible")[0].childNodes[0].nodeValue;
          }
          filter = "";
          if(xmlData[0].getElementsByTagName("filter")[0].childNodes[0]) {
        	  filter=xmlData[0].getElementsByTagName("filter")[0].childNodes[0].nodeValue;
          }
          document.getElementById("label").value = label;
          document.getElementById("type").value = columnType;
          document.getElementById("order").value = displayOrder;
          document.getElementById("options").value = options;
          document.getElementById("comment").value = comment;
          document.getElementById("masked").value = mask;
          document.getElementById("visible").value = visible;
          document.getElementById("filter").value = filter;
      }
  }

  function saveOneColumnMapping() {
        var query="&project="+document.getElementById('currentProject').value;
        query += "&schema="+document.getElementById('currentSchema').value;
        query += "&table="+document.getElementById('currentTable').value;
        query += "&column="+document.getElementById('column').value;
        query += "&label=" + document.getElementById('label').value;
        query += "&type=" + document.getElementById('type').value;
        query += "&mask=" + document.getElementById('masked').value;
        query += "&order=" + document.getElementById('order').value;
        query += "&options=" + document.getElementById('options').value;
        query += "&comment=" + document.getElementById('comment').value;
        query += "&filter=" + document.getElementById('filter').value;
        query += "&visible=" + document.getElementById('visible').value;
        
        callServer("magus?command=Database&action=saveOneColumnMapping"+query, saveOneColumnMappingStatus);
    }

  function saveOneColumnMappingStatus() {
      if (HttpReq.readyState == 4 && HttpReq.status == 200) {
          alert("done!");
      }
  }
  
  
  
    $(function(){
      // using default options
      $("#tree").fancytree({

           init: function(event, data) {
                var tree = $("#tree").fancytree("getTree");
                node = tree.getNodeByKey("id1");
                node.data.icon = "images/projects.png";
                node.renderTitle();

                node = node.getFirstChild();
                node.data.icon = "images/project.png";
                node.renderTitle();
                
               },

             click: function(event, data) {
                // logEvent(event, data, ", targetType=" + data.targetType);
                 // return false to prevent default behavior (i.e. activation, ...)
                 //return false;
                 $("#tree").fancytree("getTree").activateKey(data.node.key);

                 var node = $("#tree").fancytree("getActiveNode");

                 if (node.children == null) {
                     if(node.key.startsWith('magschema')) {

                         document.getElementById("currentSchema").value = node.title;

                         $.ajax({
                             url : "magus",
                             type : 'POST',
                             data : {
                                 command : "Database",
                                 action  : "listTables",
                                 schema: node.title
                             },
                             success : function(xml) {
                                 $("#tree").fancytree("getTree").activateKey(data.node.key);

                                 var node = $("#tree").fancytree("getActiveNode");
                                 var tables = xml.getElementsByTagName("table");
                                 // For each schema returned add an option in the selection box.
                                 for(var i=0; i < tables.length; i++) {
                                     tableName = tables[i].firstChild.nodeValue;
                                     var childNode = node.addChildren({
                                         key: "magtable" + tableName,
                                         title: tableName,
                                         folder: true,
                                         type: "table",
                                         icon: "images/table.png"
                                       });
                                 }
                                 
                             }
                         });
                             
                     } else if(node.key.startsWith('magtable')) {
                         listTableColumns(data.node.parent.parent.parent.key,data.node.parent.title,data.node.title);
                         document.getElementById("currentProject").value = data.node.parent.parent.parent.key;
                         document.getElementById("currentSchema").value = data.node.parent.title;
                         document.getElementById("currentTable").value = data.node.title;
                     } else if(!node.data.type) {
                         $.ajax({
                             url : "magus",
                             type : 'POST',
                             data : {
                                 command : "Project",
                                 action  : "load",
                                 project : data.node.key
                             },
                             success : function(xml) {
                                 // Retrieve application related information.
                                 var app = xml.getElementsByTagName("application");
                                 var shortName = app[0].getAttribute("shortName");
                                 var name = getNodeValue(app[0],"name");
                                 var path = getNodeValue(app[0],"path");
                                 var template = getNodeValue(app[0],"template");
                                 document.getElementById("currentProject").value = app[0].getAttribute("id");
                                 document.getElementById("projectName").value = name;
                                 document.getElementById("projectShortName").value = shortName;
                                 document.getElementById("projectPath").value = path;
                                 document.getElementById("template").value = template;
                                 document.getElementById("applicationSettings").style.display = "block";
                                 
                                 // Retrieve database information used by the application.
                                 var db = app[0].getElementsByTagName("database");
                                 var dbtype = getNodeValue(db[0],"type");
                                 var dbconnString = getNodeValue(db[0],"connectionString");
                                 var dbuser = getNodeValue(db[0],"username");
                                 var dbpass = getNodeValue(db[0],"password");
    
    
                                 var childNode = node.addChildren({
                                     key: "idconns",
                                     title: dbtype,
                                     tooltip: "This folder and all child nodes were added programmatically.",
                                     folder: true,
                                     type:"connection",
                                     icon:"images/database.png"
                                   });


                                 $.ajax({
                                     url : "magus",
                                     type : 'POST',
                                     data : {
                                         command : "Database",
                                         action  : "listSchemas",
                                         database: dbtype,
                                         url     : dbconnString,
                                         username: dbuser,
                                         password: dbpass
                                     },
                                     success : function(xml) {
                                         $("#tree").fancytree("getTree").activateKey("idconns");
                                         var node = $("#tree").fancytree("getActiveNode");
                                         var schemas = xml.getElementsByTagName("schema");
                                         // For each schema returned add an option in the selection box.
                                         for(var i=0; i < schemas.length; i++) {
                                             schemaName = schemas[i].firstChild.nodeValue;
                                             var childNode = node.addChildren({
                                                 key: "magschema" + schemaName,
                                                 title: schemaName,
                                                 folder: true,
                                                 type: "schema",
                                                 icon:"images/schema.png"
                                               });
                                         }
                                         
                                     }
                                 });
                                 
                                 
                             }
                         });
                     }
                 }
               }
          });

        
    });



    $(function() {
        $('a[rel*=leanModal]').leanModal({ overlay:0.8, closeButton: ".modal_close", closeCSS: ".closepopup" });       
        $('a[rel*=leanExecModal]').leanModal({ top:50, overlay:0.8, closeButton: ".modal_close", closeCSS: ".closepopup" });
    });
    
  </script>
  
<script>
function wizard(id) {
    div = document.getElementById(id);
    content = document.getElementById("wizardpopup_content");
    content.innerHTML = div.innerHTML;
        
}

function generateCode() {
    callServer("magus?command=Generate&project="+document.getElementById('currentProject').value, generateCodeStatus)
}

function generateCodeStatus() {
    if (HttpReq.readyState == 4 && HttpReq.status == 200) {
        alert("done!");
    }
}

</script>  

</head>

<body>
    <input type="hidden" id="currentProject"/>
    <input type="hidden" id="currentSchema"/>
    <input type="hidden" id="currentTable"/>


    <div id="header">
        <div class="top_header">
            <div class="header_logo">
                <img src="logo3.png" alt="Logo" class="logo" height="122" style="padding: 5px" /> <a href="#"><img src="logo2.jpg" alt="Logo"
                    class="logo" height="122" width="300" style="padding: 5px" /></a>
                <div class="right">
                    <ul class="dark">
                        <li class="first"><a href="#">My account</a></li>
                        <li><a href="#">Settings</a></li>
                        <li><a href="#">Contact us</a></li>
                    </ul>
                    <div class="clr"></div>
                    <ul class="light">
                        <li class="first"><a href="#"><img src="css/images/icon_email.gif" alt="picture" class="email" height="10" width="14"/></a><a
                            href="#">37</a> incoming messages</li>
                        <li><a href="#"><img src="css/images/icon_logout.gif" alt="picture" class="logout" height="16" width="16"/></a><a href="#">logout</a></li>
                    </ul>
                    <p>
                        Logged in as <a href="#">User Name</a>
                    </p>
                </div>
                <div class="clr"></div>
            </div>

            <div id='cssmenu'>
                <ul>
                    <li><a href='#'><span>Home</span></a></li>
                    <li class='active has-sub'><a href='#'><span>Products</span></a>
                        <ul>
                            <li class='has-sub'><a href='#'><span>Product 1</span></a>
                                <ul>
                                    <li><a href='#'><span>Sub Product</span></a></li>
                                    <li class='last'><a href='#'><span>Sub Product</span></a></li>
                                </ul></li>
                            <li class='has-sub'><a href='#'><span>Product 2</span></a>
                                <ul>
                                    <li><a href='#'><span>Sub Product</span></a></li>
                                    <li class='last'><a href='#'><span>Sub Product</span></a></li>
                                </ul></li>
                        </ul></li>
                    <li><a href='#'><span>About</span></a></li>
                    <li class='last'><a href='#'><span>Contact</span></a></li>
                </ul>
            </div>
        </div>
    </div>

    <div id="content">

<section class="left-column">
    <div id="tree">
        <ul id="treeData" style="display: none;">
            <li id="id1">Projects
                <ul>
            <c:forEach var="app" items="${sessionScope.apps}">
                    <li id='${app.id}' type="project">${app.name}
            </c:forEach>
                </ul>      
        </ul>
    </div>
    
    <a rel="leanModal" name="wizardpopup" href="#wizardpopup" style="text-decoration:none">
    <button type="submit" style="border: 1px solid; background: transparent" onclick="wizard('appwizard')">
        <img src="images/wizard.png" width="32" height="32" alt="submit" />
    </button>
    </a>
    <button type="submit" style="border: 1px solid; background: transparent" onclick="generateCode()">
        <img src="images/wizard.png" width="32" height="32" alt="submit" />
    </button>
    
</section>

<section class="right-column">

    <div class="content_block" style="padding: 1px;">
        <div class="rightblock vertsortable ui-sortable">
            <div class="gadget jsi_gv" style="width: 95%;">
                <div class="gadget_title vertsortable_head">
                    <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"/></a>
                    <h3>Application settings</h3>
                </div>
                <div class="gadget_content">
                    <table>
                        <thead>
                            <tr>
                                <th colspan="2"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="2" style="text-align:center"><b>----- Table ------</b></td>
                            </tr>
                            <tr>
                                <td>name</td>
                                <td><div id="tblName"></div><input id="tableName" name="tableName" type="hidden"/></td>
                            </tr>
                            <tr>
                                <td>label</td>
                                <td><input id="tableLabel" name="tableLabel" class="text medium"/></td>
                            </tr>
                            <tr>
                                <td>orderby</td>
                                <td><select id="tableOrderBy" name="tableOrderBy"></select></td>
                            </tr>                               
                            <tr>
                                <td colspan="2" style="text-align:center"><b>----- Column ------</b></td>
                            </tr>
                            <tr>
                                <td>column</td>
                                <td><select id="column" onchange="listColumnMapping(this.value)"></select></td>
                            </tr>
                            <tr>
                                <td>label</td>
                                <td><input type="text" id="label"/><input type="button" value="..."/></td>
                            </tr>    
                            <tr>
                                <td>type</td>
                                <td><select id="type">
                                        <option value="0">Text</option>
                                        <option value="1">Checkbox</option>
                                        <option value="2">Radio</option>
                                        <option value="3">SelectFK</option>
                                        <option value="4">Textarea</option>
                                        <option value="5">Hidden</option>
                                        <option value="6">Select</option>
                                        <option value="7">Date</option>
                                        <option value="8">RTE</option>
                                    </select>
                                </td>
                            </tr>    
                            <tr>
                                <td>order</td>
                                <td><input type="text" id="order"/><input type="button" value="..."/></td>
                            </tr>
                            <tr>
                                <td>mask</td>
                                <td><input type="text" id="masked" name="masked"/><input type="button" value="..."/></td>
                            </tr>
                            <tr>
                                <td>options</td>
                                <td><input type="text" id="options"/><input type="button" value="..."/></td>
                            </tr>    
                            <tr>
                                <td>comment</td>
                                <td><input type="text" id="comment"/><input type="button" value="..."/></td>
                            </tr>    
                            <tr>
                                <td>visible</td>
                                <td><select id="visible">
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>                        
                                </td>
                            </tr>    
                            <tr>
                                <td>filter</td>
                                <td><select id="filter">
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>                        
                                </td>
                            </tr>    
                        </tbody>
                    </table>
                    <input type="button" class="button" value="Save" onclick="saveOneColumnMapping()"/> 
                </div>
            </div>
        </div>
    </div>


</section>


<section class="center-column">
        <div class="content_block" style="padding: 1px;">
            <div class="rightblock vertsortable ui-sortable">
                <div id="applicationSettings" class="gadget jsi_gv" style="width: 100%; display:none">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"/></a>
                        <h3>Application settings</h3>
                    </div>
                    <div class="gadget_content">
                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="projectName"><strong>Name</strong></label> 
                                <input id="projectName" name="projectName" class="text medium"/></li>
                                <li><label for="projectShortName"><strong>Short Name</strong></label> 
                                <input id="projectShortName" name="projectShortName" class="text medium"/></li>
                                <li><label for="projectPath"><strong>Path</strong></label> 
                                <input id="projectPath" name="projectPath" class="text medium"/></li>
                                <li><label for="template"><strong>Template</strong></label> 
                                    <select id="template" name="template">
                                        <option value="black">Black</option>
                                        <option value="boxieblue">Boxie Blue</option>
                                </select>
                                </li>
                            </ol>
                        </form>
                    </div>
                </div>
                
                
            </div>
        </div>

</section>


    </div>

    <div id="footer">
    
    </div>
    
    
    
    
    
    
    
    
    
    
<div id="wizardpopup">
    <div id="popupheader">
        <a class="modal_close" href="#"></a>
        <h1><img src="images/wizard.png" style="vertical-align:middle;width:32px;height:32px;"/> Wizard</h1>
    </div>
    <div id="wizardpopup_content">
    </div>
</div>

<div id="appwizard" style="display:none">
        <div class="box box-50" style="width:100%;">
            <div class="boxin">
                <div class="header">
                    <h3>Step 1/3: Application Details</h3>
                </div>
                <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                    <div class="inner-form">
                        <dl>
                            <dt><label for="some1">Name:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Short Name:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Path:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Template:</label></dt>
                            <dd>
                                <select id="some10" name="some10">
                                    <option value="val1">select ...</option>
                                    <option value="val1">... something</option>
                                </select>
                                <small>Application name.</small>
                            </dd>
                        
                            <dt></dt>
                            <dd>
                                <input class="button" type="submit" value="Next" onclick="wizard('dbwizard')"/>
                            </dd>
                        </dl>
                    </div>
                </form>
            </div>
        </div>
</div>

<div id="dbwizard" style="display:none">
        <div class="box box-50">
            <div class="boxin">
                <div class="header">
                    <h3>Step 2/3: Database Settings</h3>
                </div>
                <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                    <div class="inner-form">
                        <dl>
                            <dt><label for="some1">Database:</label></dt>
                            <dd>
                                <select id="database" name="database">
                                    <c:forEach var="db" items="${magus_config.databases}">
                                        <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}'/></option>
                                    </c:forEach>
                                </select>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">URL:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Username:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Password:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt></dt>
                            <dd>
                                <input class="button" type="submit" value="Check" onclick='onclick="checkConnection()"'/>
                                <input class="button" type="submit" value="Next" onclick="wizard('tbwizard')"/>
                            </dd>
                        </dl>
                    </div>
                </form>
            </div>
        </div>
</div>

<div id="tbwizard" style="display:none">
        <div class="box box-50">
            <div class="boxin">
                <div class="header">
                    <h3>Step 3/3: Table Selection</h3>
                </div>
                <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                    <div class="inner-form">
                        <dl>
                            <dt><label for="some1">Schema:</label></dt>
                            <dd>
                                <select id="schema" name="schema" onchange="listTables(this.value)">
                                </select>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">URL:</label></dt>
                            <dd>
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
                            </dd>

                            <dt></dt>
                            <dd>
                                <input class="button" type="submit" value="Finish" onclick="wizard('tbwizard')"/>
                            </dd>
                        </dl>
                    </div>
                </form>
            </div>
        </div>
</div>
    
    
    
</body>
</html>