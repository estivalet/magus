<%@include file="../header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>${clazz.getAlias()}</h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- general form elements -->
        <div class="box box-primary">
            <form action="" method="post" id="myform" enctype="multipart/form-data">
                <input type="hidden" id="command" name="command" value="${clazz.getAlias(true)}Action"/>
                <input type="hidden" id="op" name="op" value="save"/>
                <input type="hidden" id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" value="<c:out value='<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${pks.getCamelCaseName()}}'/>"/>
                <!-- form start -->
                <div class="box-body">
                    <div id="divError" class="form-group has-error invisible">
                      <label class="control-label" for="inputError" id="errorMessages"></label>
                    </div>
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
                </div>
            </form>                
            <!-- /.box-body -->
            <div class="box-footer">
                <button type="button" id="save" class="btn btn-primary">Save</button>
            </div>                
        </div>
        <!-- /.box -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->





<%@include file="../footer.jsp"%>

<!-- Page script -->
<script>
    $(function() {
        
        function validateForm() {
            <#list columnsMinusPk as column><#t>
            <#if (column.isRequired())>
            if($('#${column.getCamelCaseName()}').val() == '') {
                $('#divError').removeClass("invisible");
                $('#errorMessages').text("required field");
                return;
            }
            </#if>
            </#list>
            document.getElementById("myform").submit(); 
        }
        
        $('#save').click( function () {
            validateForm();
            
        });

    });
</script>
