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

function getFilterParams() {
    var query = "";
<#assign hasFilter="N">    
<#list allColumns as column><#t>
    <#-- filter cannot be null otherwise freemarker will throw an exception -->
    <#if (column.filter = "Y")>
    <#assign hasFilter="Y">    
    var ${column.getCamelCaseName()} = document.getElementById("${column.getCamelCaseName()}").value;
    if(${column.getCamelCaseName()} != "") {
        query += "&${column.getCamelCaseName()}=" + ${column.getCamelCaseName()};
    }
    </#if>
</#list>
    return query;
}

function filterSearch(pageNum) {
    if(!pageNum) {
        pageNum = 1;
    }
    var query = "&pageNum=" + pageNum;
    filterParams = getFilterParams();
    callServer("?command=${clazz.getAlias(true)}Action&action=filter" + query + filterParams, filterSearchStatus);
}

function filterSearchStatus() {
    if (HttpReq.readyState == 4 && HttpReq.status == 200){
        var xml = HttpReq.responseXML;

        results = document.getElementById("results");
        results.innerHTML = "";
        
        document.getElementById("totalPages").value = Math.ceil(parseInt(xml.getElementsByTagName("results")[0].getAttribute("total"))/5);
        document.getElementById("curPage").value = parseInt(xml.getElementsByTagName("results")[0].getAttribute("page"));
        
        length = xml.getElementsByTagName("${clazz.getAlias()}").length;
        
        for(var i=0; i < length; i++) {
        <#list allColumns as column><#t>
            <#if (column.visible == 'Y')>
            <#if (column.isColumnInForeignKey())>
            xml_${column.getForeignTableAlias()} = checkNodeUndefined(xml.getElementsByTagName("${column.getForeignTableAlias()}")[i].childNodes[0]);
            <#else>
            xml_${column.getCamelCaseName()} = checkNodeUndefined(xml.getElementsByTagName("${column.getCamelCaseName()}")[i].childNodes[0]);
            </#if>
            </#if>
        </#list>            

             var row = results.insertRow();
             row.id = xml_${pks.getCamelCaseName()};
             <#if (clazz.hasExportedKeys())>
             row.onclick = function() {
                for(var j=0; j < document.getElementById("results").rows.length; j++) {
                    document.getElementById("results").rows[j].className = "";
                }
                this.className = "table-row-selected";
                callServer("?command=${fk.getFkCamelCaseName(true)}Action&action=filter&${fk.getFkColumnCamelCase(false)}=" + this.id, filterDetailStatus);
            };
            </#if>
                    
            <#assign col = 0>
            <#list allColumns as column><#t>
            <#if (column.visible == 'Y')>
            var cell${col} = row.insertCell(${col});
            <#if (column.getCustomFieldType() == 9)>
            cell${col}.innerHTML = "<img src='?command=${clazz.getAlias(true)}Action&action=get${column.getCamelCaseName(true)}&id="+row.id+"' width='50' alt=''>";
            <#else>
            <#if (column.isColumnInForeignKey())>
            cell${col}.innerHTML = xml_${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${col}.innerHTML = "<a href=\"#\" onclick=\"edit('','${clazz.getAlias(true)}Action','update','" + xml_${column.getCamelCaseName()} + "')\">" + xml_${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${col}.innerHTML = xml_${column.getCamelCaseName()};
            </#if>
            </#if>
            </#if>
            <#assign col = col + 1>
            </#if>
            </#list>
            var cell${col} = row.insertCell(${col});
            cell${col}.innerHTML = "<a href=\"#\" onclick=\"edit('','${clazz.getAlias(true)}Action','update','" + xml_${pkColumn} + "')\"><img src=\"css/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${col}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"edit('','${clazz.getAlias(true)}Action','delete','" + xml_${pkColumn} + "')\"><img src=\"css/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            
        }
        
        setUpPagination();
    }
}

<#if (clazz.hasExportedKeys())>
function filterDetailStatus() {
    if (HttpReq.readyState == 4 && HttpReq.status == 200){
        var xml = HttpReq.responseXML;

        results = document.getElementById("resultsDetail");
        results.innerHTML = "";
        
        length = xml.getElementsByTagName("${clazz.getAlias()}").length;
        
        for(var i=0; i < length; i++) {
        <#list fkTableColumns as column><#t>
            <#if (column.isColumnInForeignKey())>
            xml_${column.getForeignTableAlias()} = checkNodeUndefined(xml.getElementsByTagName("${column.getForeignTableAlias()}")[i].childNodes[0]);
            <#else>
            xml_${column.getCamelCaseName()} = checkNodeUndefined(xml.getElementsByTagName("${column.getCamelCaseName()}")[i].childNodes[0]);
            </#if>
        </#list>            

            var row = results.insertRow();
            row.id = xml_${pks.getCamelCaseName()};
                        
        <#list fkTableColumns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = xml_${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a href=\"#\" onclick=\"edit('','${fk.getFkCamelCaseName(true)}Action','update','" + xml_${column.getCamelCaseName()} + "')\">" + xml_${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = xml_${column.getCamelCaseName()};
            </#if>
            </#if>
        </#list>
            var cell${fkTableColumns?size} = row.insertCell(${fkTableColumns?size});
            cell${fkTableColumns?size}.innerHTML = "<a href=\"#\" onclick=\"edit('','${fk.getFkCamelCaseName(true)}Action','update','" + xml_${pkColumn} + "')\"><img src=\"css/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${fkTableColumns?size}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"edit('','${fk.getFkCamelCaseName(true)}Action','delete','" + xml_${pkColumn} + "')\"><img src=\"css/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            
        }
        
    }
}
</#if>

function setUpPagination() {
    document.getElementById("pagination").innerHTML = "";
    
    var pageNum = parseInt(document.getElementById("curPage").value);
    var totalPages = parseInt(document.getElementById("totalPages").value);

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
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + (pageNum-1) + "')\">Previous</a>";
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
            li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + i + "')\">" + i + "</a>";
        }
    }
    if(end != totalPages) {
        var li = document.createElement("li");
        li.innerHTML = "...";
        li.className = "separator";
        ul.appendChild(li);

        var li = document.createElement("li");
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + totalPages + "')\">" + totalPages + "</a>";
        ul.appendChild(li);
    }
    var li = document.createElement("li");
    if(pageNum == totalPages) {
        li.className = "disabled";
        li.innerHTML = "Next";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + (pageNum+1) + "')\">Next</a>";
    }
    ul.appendChild(li);
}

window.onload = function() {
    firstTime = document.getElementById("firstTime").value;
    if(firstTime == "Y") {
        callServer("?command=${clazz.getAlias(true)}Action&action=filter&pageNum=1", filterSearchStatus);
    }
        
}


