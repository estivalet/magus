<%@include file="../header.jsp" %>

<script type="text/javascript">
<%@include file="search.js" %>
</script>

<div id="content">

    <form name="myform" id="myform" method="post">
        <input id="command" name="command" type="hidden"/>
        <input id="action" name="action" type="hidden"/>
        <input id="pageNum" name="pageNum" type="hidden"/>
        <input id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" type="hidden"/>
    </form>

    <input type="hidden" id="firstTime" value="<#noparse>${requestScope.firstTime}</#noparse>"/>
    <input id="totalPages" name="totalPages" type="hidden" value="<#noparse>${totalPages}</#noparse>"/>
    <input id="curPage" name="curPage" type="hidden" value="<#noparse>${pageNum}</#noparse>"/>


    <div class="container">
        <div class="table-container">
            <div class="table-header">
                <div class="table-header-text">List of ${clazzDomainName}&nbsp;<a href="#" onclick="edit('','${clazzDomainName}Action','create')"><img style="vertical-align:text-top" src="css/plus.png"/></a></div>
            </div>
            
            <#-- Message area -->
            <c:if test="<#noparse>${message != null}</#noparse>">
            <div class="alert-box success">
                <span>success: </span><#noparse>${message}</#noparse>
            </div>
            </c:if>
            
            <div class="table">
                <table>
                    <thead>
                        <tr>
                        <#list columns as column><#t>
                            <#if (column.visible == 'Y')>
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
                <div class="table-header-text">Details ${fk.getFkTable().getName()}</div>
            </div>
            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <#list fkTableColumns as column><#t>
                                <#if (column.visible == 'Y')>
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
<#include "footer.ftl">