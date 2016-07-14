<%@include file="../header.jsp" %>

<#include "scripts.ftl">

<div id="content">

    <div class="container">
        <div class="header">
            <h3>Update ${clazz.getAlias()}</h3>
        </div>
        <div class="mainbody">

            <div id="message" class="alert-box error" style="display:none">
                <span id="messageText"></span>
            </div>

            <form action="" method="post" id="myform" enctype="multipart/form-data">
            <input type="hidden" id="command" name="command" value="${clazz.getAlias(true)}Action"/>
            <input type="hidden" id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" value="<c:out value='<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${pks.getCamelCaseName()}}'/>"/>
            <#list columnsMinusPk as column><#t>
                <#assign id="${column.getCamelCaseName()}">
                <#assign size="${column.getInputSize()}">
                <#if (column.isColumnInForeignKey())>
                    <#assign fkDisplay="${id}" + "_fk_id">
                <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${column.getForeignTableAlias()}.${.vars[fkDisplay]}}"/>
                <#else>
                <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${column.getCamelCaseName()}}"/>
                </#if>
                <#include "field.ftl">
            </#list>
            </form>
        
            <#include "buttons.ftl">

        </div>
    </div>
        
</div>


<#include "footer.jsp.ftl">