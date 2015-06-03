<%@include file="/header.jsp" %>

<#include "scripts.ftl">

<div id="content">

    <div class="container">
        <div class="header">
            <h3>Add new ${clazzName}</h3>
        </div>
        <div class="mainbody">
    
            <form action="${servlet}" method="post" id="myform">
            <input type="hidden" id="command" name="command" value="${clazzName?cap_first}Action"/>
            <#list columns as column><#t>
                <#include "field.ftl">
            </#list>
            </form>
            <#include "buttons.ftl">
    
        </div>
    </div>
        
</div>

<script>
<#list columns as column><#t>
    <#if (column.inputMask != "")>
    new InputMask().Initialize(document.querySelectorAll("#${column.getCamelCaseName()}"), {mask: InputMaskDefaultMask.Phone, placeHolder: "Phone: ${column.inputMask}"});
    </#if>
</#list>
</script>

<#include "footer.ftl">