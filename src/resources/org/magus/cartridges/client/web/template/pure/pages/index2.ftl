<%@include file="../header.jsp" %>


<script>
/**
 * Retrieve ${clazzDomainName}.
 *
 * @param pageNum
 *      Using for paging purposes.
 */
filter${clazzDomainName} = function(pageNum) {
    // Displays search screen.
    document.getElementById("container").innerHTML = document.getElementById("searchbox").innerHTML;  
    // Call server to retrieve ${clazzDomainName}.
    callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/all/json?pageNum=" + pageNum, filter${clazzDomainName}SearchStatus);
}

/**
 * Call back function to display retrieved ${clazzDomainName}s.
 */
filter${clazzDomainName}SearchStatus = function() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var obj = JSON.parse(xmlhttp.responseText);
        
        results = document.getElementById("results");
        results.innerHTML = "";
        
        for(var i=0; i < obj.rows.length; i++) {
        <#list columns as column><#t>
            <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
            <#if (column.isColumnInForeignKey())>
            ${column.getForeignTableAlias()} = obj.rows[i].${column.getForeignTableAlias()}.${.vars[fkDisplay]};
            <#else>
            ${column.getCamelCaseName()} = obj.rows[i].${column.getCamelCaseName()};
            </#if>
        </#list>            
        
            var row = results.insertRow();
            row.id = ${pks.getCamelCaseName()};
                      
        <#list columns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.getCustomFieldType() == 9)>
            cell${column_index}.innerHTML = "<img src='?command=${clazzDomainName}Action&action=get${column.getCamelCaseName(true)}&id="+row.id+"' width='50' alt=''>";
            <#else>
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = ${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a onclick=\"edit${clazzDomainName}('" + ${column.getCamelCaseName()} + "')\">" + ${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = ${column.getCamelCaseName()};
            </#if>
            </#if>
            </#if>
        </#list>
            var cell${columns?size} = row.insertCell(${columns?size});
            cell${columns?size}.innerHTML = "<a onclick=\"edit${clazzDomainName}('" + ${pkColumn} + "')\"><img src=\"css/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${columns?size}.innerHTML += "&nbsp;<a onclick=\"remove${clazzDomainName}('" + ${pkColumn} + "')\"><img src=\"css/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
        }
        setUpPagination(obj.page, Math.ceil(obj.total / 5), "filter${clazzDomainName}");  
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
        setUpPagination(obj.page, Math.ceil(obj.total / 5), "filter${clazzDomainName}");  
    }
}
</#if>


/**
 * Call server to create or update a ${clazzDomainName}.
 */
add${clazzDomainName} = function(action) {
    // Collect data from input fields.
    var data = { 
<#list columns as column><#t>
    <#if (column.isColumnInForeignKey())><#t>
    "${column.getForeignTableAlias()}" : {"${column.getForeignTableColumnPkAlias()}" : document.getElementById("${column.getCamelCaseName()}").value},
    <#else>    
        <#if (column.customFieldType != 9 && column.customFieldType != 10)>
    "${column.getCamelCaseName()}" : document.getElementById("${column.getCamelCaseName()}").value,
        </#if>
    </#if>
</#list>
    };

    document.getElementById("command").value = "POST";
    // Check if we are creating or updating a ${clazzDomainName}.
    if(action == "POST") {
        callServerJSON("POST","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/add", add${clazzDomainName}Status, data);
    } else {
        callServerJSON("PUT","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/update", update${clazzDomainName}Status, data);
    }
}

/**
 * Callback function after creating a ${clazzDomainName}. 
 */
add${clazzDomainName}Status = function() {
    // If ${clazzDomainName} was created correctly then display a message and returns back to search screen.
    if (xmlhttp.readyState == 4 && xmlhttp.status == 201) {
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = xmlhttp.responseText;
        filter${clazzDomainName}(1);
    }
}   

/**
 * Callback function after updating a ${clazzDomainName}. 
 */
update${clazzDomainName}Status = function() {
    // If ${clazzDomainName} was updated correctly then display a message and returns back to search screen.
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = xmlhttp.responseText;
        filter${clazzDomainName}(1);
    }
}    

/**
 * Call server to get ${clazzDomainName} to edit.
 */
edit${clazzDomainName} = function(${pkColumn}) {
    // Call server passing ${clazzDomainName} PK to edit.
    callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/" + ${pkColumn} + "/json", edit${clazzDomainName}Status);    
}

/**
 * Callback function to populate selected ${clazzDomainName} fields to be edited. 
 */
edit${clazzDomainName}Status = function() {
    // If the call to the server got success.
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        // Shows the modify screen.
        document.getElementById("container").innerHTML = document.getElementById("modifybox").innerHTML;
        // Parse data retrieved from server to populate input fields. 
        var obj = JSON.parse(xmlhttp.responseText);
        <#list columns as column><#t>
        document.getElementById("${column.getCamelCaseName()}").value = obj.${column.getCamelCaseName()};
        </#list>
        // Set command to be an update.      
        document.getElementById("command").value = "PUT";      
    }    
}

/**
 * Call server to perform delete operation.
 */
remove${clazzDomainName} = function(${pkColumn}) {
    // Ask for confirmation on delete.
    alertify.confirm('Confirm exclusion?', function () {
        // If really wants to delete then call the server to perform the action.
        var data = {"${pkColumn}":${pkColumn}};
        callServerJSON("DELETE","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/delete", remove${clazzDomainName}Status, data);
    });  
}

/**
 * Callback function to check delete operation status. 
 */
remove${clazzDomainName}Status = function() {
    // If the delete operation got success.
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        // Get the message from the server.
        var msg = xmlhttp.responseText;
        // Return to the search page.
        filter${clazzDomainName}(1);
        // Display success message.
        document.getElementById("messageIdAlert").style.display = "block";
        document.getElementById("messageAlert").innerHTML = msg;
    }
}    



function switchContent() {
<#list columnsMinusPk as column><#t>
 <#if (column.isColumnInForeignKey())><#t>
    callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${column.getForeignTableAlias()}/all/json?pageNum=1", filter${column.getForeignTableAlias()}SearchStatus);
 </#if>
</#list>
    document.getElementById("container").innerHTML = document.getElementById("modifybox").innerHTML; 
}

<#list columnsMinusPk as column><#t>
 <#if (column.isColumnInForeignKey())>
 <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
 function filter${column.getForeignTableAlias()}SearchStatus() {
     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var obj = JSON.parse(xmlhttp.responseText);
        var combo = document.getElementById("${column.getCamelCaseName()}");
        
        for(var i=0; i < obj.rows.length; i++) {
            id = obj.rows[i].${column.getForeignTableColumnPkAlias()};
            descricao = obj.rows[i].${.vars[fkDisplay]};
            option = document.createElement('option');
            option.setAttribute('value', id);
            option.appendChild(document.createTextNode(descricao));
            combo.appendChild(option);
        }            
    }
 
 }
 </#if>
</#list>

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
    add${clazzDomainName}(document.getElementById("command").value);    
}


</script>

<#-- Dynamic content area. It will be replaced by either 'searchbox' or 'modifybox' -->
<div id="content">
    <div class="container" id="container">
    </div>
</div>

<#-- Table with the search results -->
<div id="searchbox" style="display:none">        
    <div class="table-container">
        <div class="table-header">
            <div class="table-header-text">List of ${clazzDomainName}&nbsp;<a onclick="switchContent()"><img style="vertical-align:text-top" src="css/plus.png"/></a></div>
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
                <tbody id="results"></tbody>
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
                <tbody id="resultsDetail"></tbody>
            </table>
        </div>
    </div>
    </#if>
</div>

<#-- Form to create or update data -->
<div id="modifybox" style="display:none">   
    <div class="table-container">
        <div class="table-header">
            <div class="table-header-text">Add new ${clazz.getAlias()}</div>
        </div>
        <div class="mainbody">
            <div id="message" class="alert-box error" style="display:none">
                <span id="messageText"></span>
            </div>
                <input type="hidden" id="command" name="command" value="POST"/>
                <input type="hidden" id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" value="0"/>
            <#list columnsMinusPk as column><#t>
                <#include "field.ftl">
            </#list>
            <div class="buttons">
                <input type="button" id="submit-go" value="Save" onclick="validateForm()"/>
                <input type="reset" value="Reset"/>
                <input type="button" value="Cancel" onclick="filter${clazzDomainName}(1)"/>
            </div>                 
        </div>
    </div>
</div>

<script>
document.onload = filter${clazzDomainName}(1);
<#list columns as column><#t>
    <#if (column.inputMask != "")>
    new InputMask().Initialize(document.querySelectorAll("#${column.getCamelCaseName()}"), {mask: InputMaskDefaultMask.Phone, placeHolder: "${column.inputMask}"});
    </#if>
</#list>
</script>

<#include "footer.ftl">