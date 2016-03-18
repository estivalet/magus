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

function edit(formAction, command, action, id, pageNum) {
    document.getElementById("command").value=command;
    document.getElementById("action").value=action;
    document.getElementById("pageNum").value=pageNum;
    document.getElementById("${pks.getCamelCaseName()}").value=id;
    document.myform.action = formAction;
    if(action == 'delete') {
        alertify.confirm('Confirm exclusion?', function () {
            document.myform.submit();
        });  
    } else {
       document.myform.submit();
    }
}

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
