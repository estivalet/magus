<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"/>
<title></title>
<style>
body {
    margin: 0 0 0 0;
}
#top {
    padding: 1px;
    border: 5px solid #ccc;
    background: #fff;
    height:80px;
    }
#footer {
    padding: 1px;
    border: 5px solid #ccc;
    background: #fff;
    }
    
#left, #right {
    position: absolute;
    top: 85px;
    margin-top: 2px;
    padding: 1px;
    border: 5px solid #ccc;
    background: #fff;
    width:245px;
    height:700px;
    overflow-y:auto;
    }
#left {
    left: 0px;
}    
#middle {
   margin-left:255px;
   margin-top:0px;
   margin-right:255px;
    padding: 1px;
    border: 5px solid #aaa;
    background: #fff;
    height:600px;
    overflow-y:auto;
    }
#right {
    right: 0px;
}

</style>

<style>

table {
    font-size: 75%;
    font-family: tahoma,verdana,arial, "trebuchet ms", sans-serif;
    border-collapse: collapse;
    width:100%;
}

 
table tr td:nth-child(1){
    width: 30%;
}

table tr td:nth-child(2){
    text-align:right;
}

td, th {
    border: 1px solid #c0c0c0;
    padding:0px;
}

th {
    background: #a0a0a0;
    text-align:left;
}

input {
    border: 0px;
    /*font-size: 85%;*/
    font-family: tahoma,verdana,arial, "trebuchet ms", sans-serif;
}
input[type=button] {
    width: 2em;  
    border-left: 1px solid #c0c0c0;
}

</style>

<style>
#lean_overlay {
    position: fixed;
    z-index:100;
    top: 0px;
    left: 0px;
    height:100%;
    width:100%;
    background: #000;
    display: none;
}
.modal_close { position: absolute; top: 12px; right: 12px; display: block; width: 14px; height: 14px; background: url(images/modal_close.png); z-index: 2; }.modal_close { position: absolute; top: 12px; right: 12px; display: block; width: 14px; height: 14px; background: url(images/modal_close.png); z-index: 2; }
#popupheader { background: url(images/hd-bg.png); padding: 18px 18px 14px 18px; border-bottom: 1px solid #CCC; border-top-left-radius: 5px; -moz-border-radius-topleft: 5px; -webkit-border-top-left-radius: 5px; border-top-right-radius: 5px; -moz-border-radius-topright: 5px; -webkit-border-top-right-radius: 5px; }
#popupheader  h1 { color: #444; font-size: 1.5em; font-weight: 700; margin-bottom: 3px; text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.5); }

#wizardpopup {
     width: 1100px;
     padding-bottom: 2px;
    display:none;
    background: #FFF;
        border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px;
        box-shadow: 0px 0px 4px rgba(0,0,0,0.7); -webkit-box-shadow: 0 0 4px rgba(0,0,0,0.7); -moz-box-shadow: 0 0px 4px rgba(0,0,0,0.7);
}
#wizardpopup_content {
     margin:0px;
     padding:10px;
     height: 500px;
     overflow-y:auto;
}

</style>

<link href="sandbox/fancytree/ui.fancytree.css" rel="stylesheet" type="text/css"/>
<!-- link rel="stylesheet" href="sandbox/layout7/css/boxie-blue/boxie-blue.css" type="text/css" /-->
<link href="sandbox/vividadmin/css/vividadmin/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/helper.js"></script>
<script src="sandbox/fancytree/jquery.js" type="text/javascript"></script>
<script src="sandbox/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="sandbox/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<script src="js/jquery.leanModal.js" type="text/javascript"></script>

<script type="text/javascript" src="sandbox/vividadmin/js/js.js"></script>

  <script type="text/javascript">

  /**
   * List columns of the selected table.
   * @param table
   */
  function listTableColumns(project, schema, table) {
      if(table != "") {
          callServer("magus?command=Database&action=listTableColumns&project="+project + "&schema=" + schema + "&table=" + table, listTableColumnsStatus);
      }
  }

  function listTableColumnsStatus() {
      if (HttpReq.readyState == 4 && HttpReq.status == 200){
          var xml = HttpReq.responseXML;
          var xmlData = xml.getElementsByTagName("column");

          columns = document.getElementById("column");
          emptyCombo("column", "");
          for(i=0; i < xmlData.length; i++) {
        	  column = xmlData[i].getAttribute("name");
        	  createSelectOption(columns, column, column);
          }
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
          document.getElementById("label").value = label;
          document.getElementById("type").value = columnType;
          document.getElementById("order").value = displayOrder;
          document.getElementById("options").value = options;
          document.getElementById("comment").value = comment;
      }
  }

  function saveOneColumnMapping() {
        var query="&project="+document.getElementById('currentProject').value;
        query += "&schema="+document.getElementById('currentSchema').value;
        query += "&table="+document.getElementById('currentTable').value;
        query += "&column="+document.getElementById('column').value;
        query += "&label=" + document.getElementById('label').value;
        query += "&type=" + document.getElementById('type').value;
        query += "&order=" + document.getElementById('order').value;
        query += "&options=" + document.getElementById('options').value;
        query += "&comment=" + document.getElementById('comment').value;
        
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


<div id="top">

<a rel="leanModal" name="wizardpopup" href="#wizardpopup" style="text-decoration:none">
<button type="submit" style="border: 1px solid; background: transparent" onclick="wizard('appwizard')">
    <img src="images/wizard.png" width="32" height="32" alt="submit" />
</button>
</a>
<button type="submit" style="border: 1px solid; background: transparent" onclick="generateCode()">
    <img src="images/wizard.png" width="32" height="32" alt="submit" />
</button>
 

</div>

<div id="left">
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
</div>

<div id="middle">


    <div id="content1">



        <div class="content_block">

            <div class="rightblock vertsortable ui-sortable">

                <!--gadget right 2 -->
                <div class="gadget jsi_gv" style="width: 500px">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="sandbox/vividadmin/css/vividadmin/images/spacer.gif" height="35" width="19"/></a>
                        <h3>Application settings</h3>
                    </div>
                    <div class="gadget_content">

                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="name"><strong>Name</strong> (Small input form example)</label> 
                                    <input id="name" name="name" class="text medium"/></li>
                            </ol>
                        </form>
                    </div>
                </div>


            </div>
            <div class="clr"></div>
        </div>
    </div>

        <div class="box box-50" style="width:100%;">
            <div class="boxin">
                <div class="header">
                    <h3>Application settings</h3>
                </div>
                <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                    <div class="inner-form">
                        <dl>
                            <dt><label for="projectName">Name:</label></dt>
                            <dd>
                                <input class="txt" id="projectName" name="projectName" type="text"/>
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="projectShortName">Short Name:</label></dt>
                            <dd>
                                <input class="txt" id="projectShortName" name="projectShortName" type="text"/>
                                <small>Application short name.</small>
                            </dd>

                            <dt><label for="projectPath">Path:</label></dt>
                            <dd>
                                <input class="txt" id="projectPath" name="projectPath" type="text"/>
                                <small>Choose a path to place application source code.</small>
                            </dd>

                            <dt><label for="some1">Template:</label></dt>
                            <dd>
                                <select id="template" name="template">
                                    <option value="black">Black</option>
                                    <option value="boxieblue">Boxie Blue</option>
                                </select>
                                <small>Choose a template for the application.</small>
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

<div id="right">
    <select id="column" onchange="listColumnMapping(this.value)">
    </select>
    <table>
        <thead>
            <tr>
                <th colspan="2">General</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>label</td>
                <td><input type="text" id="label"><input type="button" value="..."/></td>
            </tr>    
            <tr>
                <td>type</td>
                <td><input type="text" id="type"><input type="button" value="..."/></td>
            </tr>    
            <tr>
                <td>order</td>
                <td><input type="text" id="order"><input type="button" value="..."/></td>
            </tr>
            <tr>
                <td>options</td>
                <td><input type="text" id="options"><input type="button" value="..."/></td>
            </tr>    
            <tr>
                <td>comment</td>
                <td><input type="text" id="comment"><input type="button" value="..."/></td>
            </tr>    
        </tbody>
    </table>
    <input type="button" class="button" value="Save" onclick="saveOneColumnMapping()"/> 
</div>


<div id="footer">

<p>footer</p>

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
                                <input class="txt" id="some1" name="some1" type="text">
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Short Name:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text">
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Path:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text">
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
                                <input class="txt" id="some1" name="some1" type="text">
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Username:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text">
                                <small>Application name.</small>
                            </dd>

                            <dt><label for="some1">Password:</label></dt>
                            <dd>
                                <input class="txt" id="some1" name="some1" type="text">
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

