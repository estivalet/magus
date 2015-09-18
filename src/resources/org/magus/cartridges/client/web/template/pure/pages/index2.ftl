<%@include file="../header.jsp" %>
<style>
.modalDialog {
    position: fixed;
    /*font-family: Arial, Helvetica, sans-serif;*/
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.8);
    z-index: 99999;
    opacity:0;
    -webkit-transition: opacity 400ms ease-in;
    -moz-transition: opacity 400ms ease-in;
    transition: opacity 400ms ease-in;
    pointer-events: none;
}
.modalDialog:target {
    opacity:1;
    pointer-events: auto;
}
.modalDialog > div {
    width: 1050px;
    position: relative;
    margin: 10% auto;
    padding: 5px 10px 10px 10px;
    border-radius: 10px;
    background: #fff;
}
.modal-body {
  height: 250px;
  overflow-y: auto;
}
.modal-header {
  border-bottom:1px solid black;
}
.modal-footer {
border-top:1px solid black;
}

.close {
    background: #606061;
    color: #FFFFFF;
    line-height: 25px;
    position: absolute;
    right: -12px;
    text-align: center;
    top: -10px;
    width: 24px;
    text-decoration: none;
    font-weight: bold;
    -webkit-border-radius: 12px;
    -moz-border-radius: 12px;
    border-radius: 12px;
    -moz-box-shadow: 1px 1px 3px #000;
    -webkit-box-shadow: 1px 1px 3px #000;
    box-shadow: 1px 1px 3px #000;
}
.close:hover {
    background: #00d9ff;
}
</style>

<script>
var xmlhttp = new XMLHttpRequest();

function callServerJSON(method, url, f, data) {
    xmlhttp.onreadystatechange = f;
    xmlhttp.open(method, url, true);
    xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xmlhttp.send(JSON.stringify(data));
}

function filterSearchStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var obj = JSON.parse(xmlhttp.responseText);
        
        results = document.getElementById("results");
        results.innerHTML = "";
        
        for(var i=0; i < obj.rows.length; i++) {
        <#list columns as column><#t>
            <#if (column.isColumnInForeignKey())>
            ${column.getForeignTableAlias()} = obj.rows[i].${column.getForeignTableAlias()};
            <#else>
            ${column.getCamelCaseName()} = obj.rows[i].${column.getCamelCaseName()};
            </#if>
        </#list>            
        
            var row = results.insertRow();
            row.id = ${pks.getCamelCaseName()};
            <#if (clazz.hasExportedKeys())>
            /*
            row.onclick = function() {
               for(var j=0; j < document.getElementById("results").rows.length; j++) {
                   document.getElementById("results").rows[j].className = "";
               }
               this.className = "table-row-selected";
               callServer("?command=${fk.getFkCamelCaseName(true)}Action&action=filter&${fk.getFkColumnCamelCase(false)}=" + this.id, filterDetailStatus);
            };
            */
            </#if>
                      
        <#list columns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.getCustomFieldType() == 9)>
            cell${column_index}.innerHTML = "<img src='$?command=${clazz}Action&action=get${column.getCamelCaseName(true)}&id="+row.id+"' width='50' alt=''>";
            <#else>
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = ${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a href=\"#createModal\" onclick=\"edit${clazzDomainName}('" + ${column.getCamelCaseName()} + "')\">" + ${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = ${column.getCamelCaseName()};
            </#if>
            </#if>
            </#if>
        </#list>
            var cell${columns?size} = row.insertCell(${columns?size});
            cell${columns?size}.innerHTML = "<a href=\"#createModal\" onclick=\"edit${clazzDomainName}('" + ${pkColumn} + "')\"><img src=\"css/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${columns?size}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"remove${clazzDomainName}('" + ${pkColumn} + "')\"><img src=\"css/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
        }
        setUpPagination(obj.page, Math.ceil(obj.total / 5));  
    }
}    

<#if (clazz.hasExportedKeys())>
function filterDetailStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var obj = JSON.parse(xmlhttp.responseText);
        
        results = document.getElementById("results");
        results.innerHTML = "";
        
        for(var i=0; i < obj.length; i++) {
        <#list fkTableColumns as column><#t>
            <#if (column.isColumnInForeignKey())>
            ${column.getForeignTableAlias()} = obj[i].${column.getForeignTableAlias()};
            <#else>
            ${column.getCamelCaseName()} = obj[i].${column.getCamelCaseName()};
            </#if>
        </#list>            

            var row = results.insertRow();
            row.id = xml_${pks.getCamelCaseName()};
                        
        <#list fkTableColumns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = ${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a href=\"#\" onclick=\"edit('','${fk.getFkCamelCaseName(true)}Action','update','" + ${column.getCamelCaseName()} + "')\">" + ${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = ${column.getCamelCaseName()};
            </#if>
            </#if>
        </#list>
            var cell${fkTableColumns?size} = row.insertCell(${fkTableColumns?size});
            cell${fkTableColumns?size}.innerHTML = "<a href=\"#\" onclick=\"edit('','${fk.getFkCamelCaseName(true)}Action','update','" + ${pkColumn} + "')\"><img src=\"css/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${fkTableColumns?size}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"remove${clazzDomainName}('" + ${pkColumn} + "')\"><img src=\"css/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
        }
        setUpPagination(obj.page, Math.ceil(obj.total / 5));  
    }
}
</#if>

function filter(pageNum) {
    callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/all/json?pageNum=" + pageNum, filterSearchStatus);
}

function add(action) {
    var data = { 
<#list columns as column><#t>
    "${column.getCamelCaseName()}" : document.getElementById("${column.getCamelCaseName()}").value,
</#list>
    };

    document.getElementById("command").value = "POST";
    if(action == "POST") {
        callServerJSON("POST","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/add", addStatus, data);
    } else {
        callServerJSON("PUT","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/update", updateStatus, data);
    }
}

function addStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 201){
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = xmlhttp.responseText;
        filter(1);
    }
}    

function edit${clazzDomainName}(${pkColumn}) {
    callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/" + ${pkColumn} + "/json", edit${clazzDomainName}Status);    
}

function edit${clazzDomainName}Status() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var obj = JSON.parse(xmlhttp.responseText);
        <#list columns as column><#t>
        document.getElementById("${column.getCamelCaseName()}").value = obj.${column.getCamelCaseName()};
        </#list>      
        document.getElementById("command").value = "PUT";      
    }    
}


function remove${clazzDomainName}(${pkColumn}) {
    alertify.confirm('Confirm exclusion?', function () {
        var data = {"${pkColumn}":${pkColumn}};
        callServerJSON("DELETE","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/delete", remove${clazzDomainName}Status, data);
    });  
}

function remove${clazzDomainName}Status() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = xmlhttp.responseText;
        filter(1);
    }
}    

function updateStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = xmlhttp.responseText;
        filter(1);
    }
}    

function setUpPagination(pageNum, totalPages) {
    document.getElementById("pagination").innerHTML = "";
    
    var divPag = document.getElementById("pagination");
    var ul = document.createElement("ul");
    ul.className = "pager";
    divPag.appendChild(ul);    

    var li = document.createElement("li");
    ul.appendChild(li);

    if(pageNum == 1) {
        li.className = "disabled";
        li.innerHTML = "Previous";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"filter('" + (pageNum-1) + "')\">Previous</a>";
    }

    var start = pageNum - 5;
    if(start < 1) {
        start = 1;
    }
    var end = pageNum + 5;
    if(end > totalPages) {
        end = totalPages;
    }
    for(var i=start; i<=end; i++) {
        var li = document.createElement("li");
        ul.appendChild(li);

        if(i==pageNum) {
            li.innerHTML = i;
            li.className = "current";
        } else {
            li.innerHTML = "<a href=\"#\" onclick=\"filter('" + i + "')\">" + i + "</a>";
        }
    }
    if(end != totalPages) {
        var li = document.createElement("li");
        li.innerHTML = "...";
        li.className = "separator";
        ul.appendChild(li);

        var li = document.createElement("li");
        li.innerHTML = "<a href=\"#\" onclick=\"filter('" + totalPages + "')\">" + totalPages + "</a>";
        ul.appendChild(li);
    }
    var li = document.createElement("li");
    if(pageNum == totalPages) {
        li.className = "disabled";
        li.innerHTML = "Next";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"filter('" + (parseInt(pageNum)+1) + "')\">Next</a>";
    }
    ul.appendChild(li);
}
document.onload = filter(1);

</script>

<div id="content">
    <div class="container">
        <div class="table-container">
            <div class="table-header">
                <div class="table-header-text">List of ${clazzDomainName}&nbsp;<a href="#createModal"><img style="vertical-align:text-top" src="css/plus.png"/></a></div>
            </div>
            
            <#-- Message area -->
            <div class="alert-box success" id="messageIdAlert" style="display:none">
                <span id="messageAlert"></span>
            </div>
            
            <div class="table">
                <table>
                    <thead>
                        <tr>
                        <#list columns as column><#t>
                            <#if (column.visible = 'Y')>
                                <#if (column.isColumnInForeignKey())>
                        <th>${column.getForeignTableAlias()}</th>
                                <#else>
                        <th>${column.getLabel()}</th>
                                </#if>
                            </#if>
                        </#list><#t>
                        <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="results">
                    </tbody>
                </table>
            <div id="pagination" class="pagination pagination-left"></div>
            </div>
        </div>
        
        <#if (clazz.hasExportedKeys())>
        <br/>
        <#-- Details table -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-header-text">Details</div>
            </div>
            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <#list fkTableColumns as column><#t>
                                <#if (column.visible = 'Y')>
                                    <#if (column.isColumnInForeignKey())>
                            <th>${column.getForeignTableAlias()}</th>
                                    <#else>
                            <th>${column.getLabel()}</th>
                                    </#if>
                                </#if>
                            </#list><#t>
                            <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="resultsDetail">
                    </tbody>
                </table>
            </div>
        </div>
        </#if>
        
    </div>

</div>

<script type="text/javascript">
function displayError(fieldName) {
    document.getElementById("messageText").innerHTML = fieldName + " is required!";
    document.getElementById("message").style.display = "block";
    document.getElementById(fieldName).focus();
}

function validateForm() {
<#list columnsMinusPk as column><#t>
    <#if (column.isRequired())>
    <#-- RADIO BUTTON -->
        <#if column.customFieldType == 2 >
    var ${column.getCamelCaseName()} = document.getElementsByName("${column.getCamelCaseName()}");
    var selected = false;
    for (var i = 0, length = ${column.getCamelCaseName()}.length; i < length; i++) {
        if (${column.getCamelCaseName()}[i].checked) {
            selected = true;
            break;
        }
    }
    if(!selected) {
        displayError("${column.getCamelCaseName()}");
        return;
    }
        <#else>
    var ${column.getCamelCaseName()} = document.getElementById("${column.getCamelCaseName()}").value;
    if(${column.getCamelCaseName()}.trim() == "") {
        displayError("${column.getCamelCaseName()}");
        return;
    }
        </#if>
    </#if>
</#list>
    document.getElementById("modal").click();
    add(document.getElementById("command").value);    
}
</script>


<!-- Modal -->
<div id="createModal" class="modalDialog">
    <div>   
        <a href="#close" id="modal" title="Close" class="close">X</a>
        <div class="modal-header">
        <h2>Modal Box</h2>
        </div>
        <div class="modal-body">
            <div class="container">
                <div class="header">
                    <h3>Add new ${clazz.getAlias()}</h3>
                </div>
                <div class="mainbody">
                    <div id="message" class="alert-box error" style="display:none">
                        <span id="messageText"></span>
                    </div>
                    <form action="" method="post" id="myform" enctype="multipart/form-data">
                    <input type="hidden" id="command" name="command" value="POST"/>
                    <input type="hidden" id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" value="0"/>
                    <#list columnsMinusPk as column><#t>
                        <#include "field.ftl">
                    </#list>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <div class="buttons">
                <input type="button" id="submit-go" value="Save" onclick="validateForm()"/>
                <input type="reset" value="Reset"/>
                <a href="#"><input type="button" value="Cancel"/></a>
            </div>                 
        </div>
    </div>
</div>
<!-- /Modal -->
<script>
<#list columns as column><#t>
    <#if (column.inputMask != "")>
    new InputMask().Initialize(document.querySelectorAll("#${column.getCamelCaseName()}"), {mask: InputMaskDefaultMask.Phone, placeHolder: "${column.inputMask}"});
    </#if>
</#list>
</script>

<#include "footer.ftl">