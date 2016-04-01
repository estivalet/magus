<%@include file="../header.jsp" %>

<#include "scripts.ftl">


                <div class="box-header with-border">
                  <h3 class="box-title">${clazz.getAlias()}</h3>
                </div><!-- /.box-header -->

            <form role="form" action="" method="post" id="myform" enctype="multipart/form-data">
                  <div class="box-body">
            <input type="hidden" id="command" name="command" value="${clazzDomainName}Action"/>
            <#list columnsMinusPk as column><#t>
                <#include "field.ftl">
            </#list>
            </form>
                    </div>
            <#include "buttons.ftl">



<script>
<#list columnsMinusPk as column><#t>
    <#if (column.inputMask != "")>
    new InputMask().Initialize(document.querySelectorAll("#${column.getCamelCaseName()}"), {mask: InputMaskDefaultMask.Phone, placeHolder: "${column.inputMask}"});
    </#if>
</#list>
</script>

<#include "footer.ftl">