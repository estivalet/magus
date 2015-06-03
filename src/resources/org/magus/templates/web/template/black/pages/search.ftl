<%@include file="/header.jsp" %>


<script>
function edit(formAction, command, action, id, pageNum) {
	document.getElementById("command").value=command;
	document.getElementById("action").value=action;
	document.getElementById("pageNum").value=pageNum;
	document.getElementById("${pks.getCamelCaseName()}").value=id;
	document.myform.action = formAction;
    if(action == 'delete') {
        alertify.confirm('Confirm exclusion?').set('onok', function(closeEvent){ document.myform.submit();} );;
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
        li.innerHTML = "<a href=\"#\" class=\"prevnext disablelink\">« previous</a>&nbsp;";
    } else {
        li.innerHTML = "<a href=\"#\" class=\"prevnext\" onclick=\"filterSearch('" + (pageNum-1) + "')\">« previous</a>&nbsp;";
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
            li.innerHTML = "<a href=\"#\" class=\"currentpage\">" + i + "</a>&nbsp;";
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
        li.innerHTML = "<a href=\"#\" class=\"prevnext disablelink\">next »</a>&nbsp;";
    } else {
        li.innerHTML = "<a href=\"#\" class=\"prevnext\" onclick=\"filterSearch('" + (pageNum+1) + "')\">next »</a>&nbsp;";
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
<input type="hidden" id="firstTime" value="<#noparse>${requestScope.firstTime}</#noparse>"/>
        <form name="myform" id="myform" method="post">
        	<input id="command" name="command" type="hidden"/>
        	<input id="action" name="action" type="hidden"/>
        	<input id="pageNum" name="pageNum" type="hidden"/>
        	<input id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" type="hidden"/>
        </form>

        <input id="totalPages" name="totalPages" type="hidden" value="<#noparse>${totalPages}</#noparse>"/>
        <input id="curPage" name="curPage" type="hidden" value="<#noparse>${pageNum}</#noparse>"/>
        
        
    <div id="content">
    
    
    


        <div class="content_block" style="padding: 20px;">

            <div class="rightblock vertsortable ui-sortable">

                <#-- Message area -->
                <c:if test="<#noparse>${message != null}</#noparse>">
                <p class="err_mes jsi_mes_green">
                    <img class="pimpa" width="13" height="13" src="css/images/pimpa_green.gif"> success message 
                    <a class="close_mess" href="#"> <img width="24" height="38" src="css/images/spacer.gif"></a>
                </p>
                </c:if>
                
                <#-- Check if there is any filter -->
                <#if (hasFilter = "Y")>
                <div class="gadget jsi_gv" style="width: 500px">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>Search for ${clazz}</h3>
                    </div>
                    <div class="gadget_content">
                        <form class="form_example">
                            <ol>
                            <#list columns as column><#t>
                            <#-- filter cannot be null otherwise freemarker will throw an exception -->
                                <#if (column.filter = "Y")>
                                <#assign id="${column.getCamelCaseName()}">
                                <#assign size="${column.getInputSize()}">
                                <li>
                                    <label for="${id}"><strong>${column.getLabel()}<#if column.isRequired()>*</#if></strong></label>
                                    <#include "field.ftl"> 
                                </li>
                                </#if>
                            </#list>
                            </ol>
                        </form>
                    </div>
                    <div class="clr"></div>
                    <input type="button" id="submit-go" value="Search" onclick="filterSearch()"/>
                    <input type="reset" value="Reset"/>
                </div>                
                </#if>
                
                <#-- Results table -->
                <div class="gadget jsi_gv">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>List of ${clazz}<a href="#" class="ico" onclick="edit('${servlet}','${clazz}Action','create')">&nbsp;<img src="css/images/plus.png" alt="edit"></a></h3>
                    </div>
                    <div class="gadget_content">
                        <form>
                            <table class="glines" cellpadding="0" cellspacing="0" border="0" width="100%">
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
                        </form>
                    </div>
                </div>
                
                
                <#if (hasExportedKeys)>
                <#-- Details table -->
                <div class="gadget jsi_gv">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>Details</h3>
                    </div>
                    <div class="gadget_content">
                        <form>
                            <table class="glines" cellpadding="0" cellspacing="0" border="0" width="100%">
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
                        </form>
                    </div>
                </div>
                </#if>
                
            </div>
            <div class="clr"></div>
            <#-- Pagination -->
            <div id="pagination" class="pagination">
            </div>
        </div>
    </div>
        



<#include "footer.ftl">
