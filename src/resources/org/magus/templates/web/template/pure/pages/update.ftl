<%@include file="../header.jsp" %>

<#include "scripts.ftl">

<div id="content">

    <div class="container">
        <div class="header">
            <h3>Update ${clazzName}</h3>
        </div>
        <div class="mainbody">

            <div id="message" class="alert-box error" style="display:none">
                <span id="messageText"></span>
            </div>

            <form action="" method="post" id="myform">
            <input type="hidden" id="command" name="command" value="${clazzName?capitalize}Action"/>
            <#list pks as pk><#t>
            <input type="hidden" id="${pk.getCamelCaseName()}" name="${pk.getCamelCaseName()}" value="<c:out value='<#noparse>${requestScope.</#noparse>${clazzName}.${pk.getCamelCaseName()}}'/>"/>
            </#list>
            <#list columns as column><#t>
                <#assign id="${column.getCamelCaseName()}">
                <#assign size="${column.getInputSize()}">
                <#if (column.isColumnInForeignKey())>
                    <#assign fkDisplay="${id}" + "_fk_id">
                <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazzName}.${column.getForeignTableAlias()}.${.vars[fkDisplay]}}"/>
                <#else>
                <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazzName}.${column.getCamelCaseName()}}"/>
                </#if>
                <#include "field.ftl">
            </#list>
            </form>
        
            <#include "buttons.ftl">

        </div>
    </div>
        
</div>


<#include "footer.ftl">