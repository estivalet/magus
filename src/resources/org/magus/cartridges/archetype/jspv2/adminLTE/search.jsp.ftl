<%@include file="../header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>${clazz.getAlias(true)}</h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="box box-primary">
            <div class="box-header with-border">
                <form action="" method="post" id="myform" enctype="multipart/form-data">
                    <input type="hidden" id="command" name="command" value="${clazz.getAlias(true)}Action"/>
                    <input type="hidden" id="op" name="op" value="new"/>
                    <input id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" type="hidden"/>
                </form>
                <a href="#" onclick="document.getElementById('myform').submit()"><img src="css/images/plus.png" /></a>
            </div>

            <div class="box-body">
                <table id="${clazz.getAlias()}s" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                        <#list allColumns as column><#t>
                        <#if (column.isColumnInPrimaryKey())>
                        <#assign pkValue="${clazz.getAlias()}.${column.getLabel()}">
                        </#if>

                        <#if (column.visible == 'Y')>
                        <#if (column.isColumnInForeignKey())>
                            <th>${column.getForeignTableAlias()}</th>
                        <#else>
                            <th>${column.getLabel()}</th>
                        </#if>
                        </#if>
                        </#list><#t>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="<#noparse>${</#noparse>${clazz.getAlias()}s<#noparse>}</#noparse>" var="${clazz.getAlias()}" varStatus="loop">
                            <tr>
                            <#list allColumns as column><#t>
                            <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
                            <#if (column.visible == 'Y')>
                            <#if (column.customFieldType == 9)>
                                <td><img src="?command=${clazz.getAlias(true)}Action&op=get${column.getCamelCaseName(true)}&id=<#noparse>${</#noparse>${pkValue}<#noparse>}</#noparse>" onerror="this.style.display='none'" width="50"/>
                            <#else>
                            <#if (column.isColumnInForeignKey())>
                                <td><#noparse>${</#noparse>${clazz.getAlias()}.${column.getForeignTableAlias()}.${.vars[fkDisplay]}<#noparse>}</#noparse></td>
                            <#else>
                                <td><#noparse>${</#noparse>${clazz.getAlias()}.${column.getLabel()}<#noparse>}</#noparse></td>
                            </#if>
                            </#if>
                            </#if>
                            </#list><#t>
                                <td><a href="#" onclick="edit('','${clazz.getAlias(true)}Action','update','<#noparse>${</#noparse>${pkValue}<#noparse>}</#noparse>')">Edit</a>&nbsp;<a href="#" onclick="edit('','${clazz.getAlias(true)}Action','delete','<#noparse>${</#noparse>${pkValue}<#noparse>}</#noparse>')">Remove</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->





<%@include file="../footer.jsp" %>

<!-- Page script -->
<script>
    $(function() {
        $('${clazz.getAlias()}s').DataTable({
            "ordering" : false,
            "searching" : true,
            "paging" : true,
            "dom" : "ftp",
            "pageLength" : 10,
            "language": {
                "url": "plugins/DataTables-1.10.12/i18n/ptBR.json"
            }
        });
        
        

    });
    
    function edit(formAction, command, action, id) {
    document.getElementById("command").value=command;
    document.getElementById("op").value=action;
    document.getElementById("${pks.getCamelCaseName()}").value=id;
    if(action == 'delete') {
        alertify.confirm('Confirm exclusion?', function () {
            document.getElementById("myform").submit(); 
        });  
    } else {
       document.getElementById("myform").submit(); 
    }
}        

</script>
