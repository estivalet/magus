<%@include file="/header.jsp" %>


<script type="text/javascript">
function edit(formAction, command, action, id, pageNum) {
    document.getElementById("command").value=command;
    document.getElementById("action").value=action;
    document.getElementById("pageNum").value=pageNum;
    document.getElementById("${pks.getCamelCaseName()}").value=id;
    document.myform.action = formAction;
    if(action == 'delete') {
        $.Zebra_Dialog('Confirm exclusion?', {
                'type':     'question',
                'title':    'Custom buttons',
                'buttons':  ['Yes', 'No'],
                'onClose':  function(caption) {
                    if(caption == 'Yes') {
                        document.myform.submit();
                    }
                }
            });        
    } else {
           document.myform.submit();
    }
}

function getFilterParams() {
    var query = "";
<#assign hasFilter="N">    
<#list columns as column><#t>
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
    callServer("${servlet}?command=${clazz}Action&action=filter" + query + filterParams, filterSearchStatus);
}

function filterSearchStatus() {
    if (HttpReq.readyState == 4 && HttpReq.status == 200){
        var xml = HttpReq.responseXML;

        results = document.getElementById("results");
        results.innerHTML = "";
        
        document.getElementById("totalPages").value = Math.ceil(parseInt(xml.getElementsByTagName("results")[0].getAttribute("total"))/5);
        document.getElementById("curPage").value = parseInt(xml.getElementsByTagName("results")[0].getAttribute("page"));
        
        length = xml.getElementsByTagName("${clazzName}").length;
        
        for(var i=0; i < length; i++) {
        <#list columns as column><#t>
            <#if (column.isColumnInForeignKey())>
            xml_${column.getForeignTableAlias()} = checkNodeUndefined(xml.getElementsByTagName("${column.getForeignTableAlias()}")[i].childNodes[0]);
            <#else>
            xml_${column.getCamelCaseName()} = checkNodeUndefined(xml.getElementsByTagName("${column.getCamelCaseName()}")[i].childNodes[0]);
            </#if>
        </#list>            

         var row = results.insertRow();
         row.id = xml_id;
         if(i % 2 != 0) {
            row.className = "even";
         }
         <#if (hasExportedKeys)>
         row.onclick = function() {
            callServer("${servlet}?command=${fks.getFkCamelCaseName(true)}Action&action=filter&${fks.getFkColumnCamelCase(false)}=" + this.id, filterDetailStatus);
        };
        </#if>
                        
        <#list columns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = xml_${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a href=\"#\" onclick=\"edit('${servlet}','${clazz}Action','update','" + xml_${column.getCamelCaseName()} + "')\">" + xml_${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = xml_${column.getCamelCaseName()};
            </#if>
            </#if>
        </#list>
            var cell${columns?size} = row.insertCell(${columns?size});
            cell${columns?size}.innerHTML = "<a href=\"#\" onclick=\"edit('${servlet}','${clazz}Action','update','" + xml_${pkColumn} + "')\"><img src=\"css/images/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${columns?size}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"edit('${servlet}','${clazz}Action','delete','" + xml_${pkColumn} + "')\"><img src=\"css/images/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            
        }
        
        setUpPagination();
    }
}

<#if (hasExportedKeys)>
function filterDetailStatus() {
    if (HttpReq.readyState == 4 && HttpReq.status == 200){
        var xml = HttpReq.responseXML;

        results = document.getElementById("resultsDetail");
        results.innerHTML = "";
        
        length = xml.getElementsByTagName("${clazzName}").length;
        
        for(var i=0; i < length; i++) {
        <#list fkTableColumns as column><#t>
            <#if (column.isColumnInForeignKey())>
            xml_${column.getForeignTableAlias()} = checkNodeUndefined(xml.getElementsByTagName("${column.getForeignTableAlias()}")[i].childNodes[0]);
            <#else>
            xml_${column.getCamelCaseName()} = checkNodeUndefined(xml.getElementsByTagName("${column.getCamelCaseName()}")[i].childNodes[0]);
            </#if>
        </#list>            

            var row = results.insertRow();
            row.id = xml_id;
                        
        <#list fkTableColumns as column><#t>
            var cell${column_index} = row.insertCell(${column_index});
            <#if (column.isColumnInForeignKey())>
            cell${column_index}.innerHTML = xml_${column.getForeignTableAlias()};
            <#else>
            <#if (column.isColumnInPrimaryKey())>
            cell${column_index}.innerHTML = "<a href=\"#\" onclick=\"edit('${servlet}','${fks.getFkCamelCaseName(true)}Action','update','" + xml_${column.getCamelCaseName()} + "')\">" + xml_${column.getCamelCaseName()} + "</a>";
            <#assign pkColumn="${column.getCamelCaseName()}">
            <#else>            
            cell${column_index}.innerHTML = xml_${column.getCamelCaseName()};
            </#if>
            </#if>
        </#list>
            var cell${columns?size} = row.insertCell(${columns?size});
            cell${columns?size}.innerHTML = "<a href=\"#\" onclick=\"edit('${servlet}','${fks.getFkCamelCaseName(true)}Action','update','" + xml_${pkColumn} + "')\"><img src=\"css/images/pimpa_yes.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            cell${columns?size}.innerHTML += "&nbsp;<a href=\"#\" onclick=\"edit('${servlet}','${fks.getFkCamelCaseName(true)}Action','delete','" + xml_${pkColumn} + "')\"><img src=\"css/images/pimpa_no.gif\" alt=\"picture\" class=\"tabpimpa\" height=\"13\" width=\"13\"></a>";
            
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
    divPag.appendChild(ul);    

    var li = document.createElement("li");
    ul.appendChild(li);

    if(pageNum == 1) {
        li.innerHTML = "<a href=\"#\">Previous</a>&nbsp;";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + (pageNum-1) + "')\">Previous</a>&nbsp;";
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
            li.innerHTML = "<a href=\"#\" class=\"active\">" + i + "</a>&nbsp;";
        } else {
            li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + i + "')\">" + i + "</a>&nbsp;";
        }
    }
    if(end != totalPages) {
        var li = document.createElement("li");
        li.innerHTML = "...";
        ul.appendChild(li);

        var li = document.createElement("li");
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + totalPages + "')\">" + totalPages + "</a>&nbsp;";
        ul.appendChild(li);
    }
    var li = document.createElement("li");
    if(pageNum == totalPages) {
        li.innerHTML = "<a href=\"#\">Next</a>&nbsp;";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"filterSearch('" + (pageNum+1) + "')\">Next</a>&nbsp;";
    }
    ul.appendChild(li);
        
    
}

window.onload = function() {
    firstTime = document.getElementById("firstTime").value;
    if(firstTime == "Y") {
        callServer("${servlet}?command=${clazz}Action&action=filter&pageNum=1", filterSearchStatus);
    }
        
}


</script>

    <form name="myform" id="myform" method="post">
        <input id="command" name="command" type="hidden"/>
        <input id="action" name="action" type="hidden"/>
        <input id="pageNum" name="pageNum" type="hidden"/>
        <input id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" type="hidden"/>
    </form>

    <input type="hidden" id="firstTime" value="<#noparse>${requestScope.firstTime}</#noparse>"/>
    <input id="totalPages" name="totalPages" type="hidden" value="<#noparse>${totalPages}</#noparse>"/>
    <input id="curPage" name="curPage" type="hidden" value="<#noparse>${pageNum}</#noparse>"/>

        <c:if test="<#noparse>${message != null}</#noparse>">
        <div class="msg msg-ok"><p><#noparse>${message}</#noparse></p></div>
        </c:if>

        <div id="box1" class="box box-100">
                <div class="boxin">
                    <div class="header">
                        <h3>List of ${clazzName?capitalize}<a href="#" class="ico" onclick="edit('${clazzName}','${clazzName?capitalize}Action','create')">&nbsp;<img src="css/boxie-blue/plus.png" alt="edit"></a></h3>
                    </div>
                    <div id="box1-tabular" class="content"><!-- content box 1 for tab switching -->
                        <form class="plain" action="" method="post" enctype="multipart/form-data">
                            <fieldset>
                                <table cellspacing="0">
                                
                                    <thead><!-- universal table heading -->
                                        <tr>
                                            <#list columns as column><#t>
                                            <th>${column.getLabel()}</th>
                                            </#list><#t>
                                            <th class="tc last">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="results">
                                        <c:set var="count" value="0"/>    
                                        <c:forEach var="list" items="<#noparse>${sessionScope.</#noparse>${clazzes}}">
                                            <tr>   
                                            <#assign pk=""/>    
                                            <#list columns as column><#t>
                                                <#-- If attribute is in primary key then put a link on it -->
                                                <#if (column.isColumnInPrimaryKey())>
                                                <#assign pk=column.getCamelCaseName()/>
                                                <td class="nowrap"><a href="#" onclick="edit('${clazzName}','${clazzName?capitalize}Action','update','<c:out value='<#noparse>${list.</#noparse>${pk}}'/>')"><c:out value='<#noparse>${list.</#noparse>${column.getCamelCaseName()}}'/></a></td>
                                                <#else>
                                                <#-- Check if attribute is a foreign key -->
                                                <#if (column.isColumnInForeignKey())>
                                                <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
                                                <td class="nowrap"><c:out value='<#noparse>${list.</#noparse>${column.getForeignTableAlias()}.${.vars[fkDisplay]}}'/></td>
                                                <#else>
                                                <td class="nowrap"><c:out value='<#noparse>${list.</#noparse>${column.getCamelCaseName()}}'/></td>
                                                </#if>
                                                </#if>
                                            </#list><#t>
                                                <td class="tc last">
                                                    <ul class="actions">
                                                        <li><a class="ico" href="#" title="edit" onclick="edit('${clazzName}','${clazzName?capitalize}Action','update','<c:out value='<#noparse>${list.</#noparse>${pk}}'/>')"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                        <li><a class="ico" href="#" title="delete" onclick="edit('${clazzName}','${clazzName?capitalize}Action','delete','<c:out value='<#noparse>${list.</#noparse>${pk}}'/>',1)"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                    </ul>
                                                </td>
                                            </tr>   
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </fieldset>
                        </form>
                        <div class="pagination">
                            <jsp:include page="../pagination.jsp" />
                        </div>
                    </div><!-- .content#box-1-holder -->
                </div>
            </div>
        </div> <!-- content_res end -->
    </div> <!-- content end -->


<#include "footer.ftl">
