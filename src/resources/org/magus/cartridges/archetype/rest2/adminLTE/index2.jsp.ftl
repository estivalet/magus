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

            <div class="box-body" id="box-body">
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
        filter${clazz.getAlias(true)}SearchStatus = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                var myTableDiv = document.getElementById("box-body");
                var table = document.createElement('TABLE');
                table.id='${clazz.getAlias()}s'
                table.className = "table table-striped table-bordered";

                var header = table.createTHead();
                var row = header.insertRow(0);
                <#list allColumns as column><#t>
                <#if (column.visible == 'Y')>
                var cell = row.insertCell();
                <#if (column.isColumnInForeignKey())>
                cell.innerHTML = "<b>${column.getForeignTableAlias()}</b>";
                <#else>
                cell.innerHTML = "<b>${column.getLabel()}</b>";
                </#if>
                </#if>
                </#list>
                cell = row.insertCell();
                cell.innerHTML = "";

                var tableBody = document.createElement('TBODY');
                table.appendChild(tableBody);

                var json = JSON.parse(xmlhttp.responseText);
                json.forEach(function(obj) { 
                    console.log(obj);
                    var tr = document.createElement('TR');
                    tableBody.appendChild(tr);
                    
                    <#list allColumns as column><#t>
                    <#if (column.isColumnInPrimaryKey())>
                    <#assign pkColumn="${column.getLabel()}">
                    </#if>
                    </#list>
                    
                    <#list allColumns as column><#t>
                    <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
                    <#if (column.visible == 'Y')>
                    var td = document.createElement('TD');
                    <#if (column.customFieldType == 9)>
                    td.innerHTML='<img src="?command=${clazz.getAlias(true)}Action&op=get${column.getCamelCaseName(true)}&id=' + obj.${pkColumn} + '" onerror="this.style.display=\'none\'" width="50"/>';
                    <#else>
                    <#if (column.isColumnInForeignKey())>
                    td.appendChild(document.createTextNode(typeof obj.${column.getForeignTableAlias()}.${.vars[fkDisplay]} == "undefined" ? "" : obj.${column.getForeignTableAlias()}.${.vars[fkDisplay]}));
                    <#else>
                    td.appendChild(document.createTextNode(typeof obj.${column.getLabel()} == "undefined" ? "" : obj.${column.getLabel()}));
                    </#if>
                    </#if>
                    tr.appendChild(td);
                    </#if>
                    </#list><#t>
                    td = document.createElement('TD');
                    td.innerHTML = "<a href=\"#\" onclick=\"edit('','${clazz.getAlias(true)}Action','update','obj.${pkColumn}')\">Edit</a>&nbsp;<a href=\"#\" onclick=\"edit('','${clazz.getAlias(true)}Action','delete','obj.${pkColumn}')\">Remove</a>";
                    tr.appendChild(td);
                });
                myTableDiv.appendChild(table);
                }
                $("#${clazz.getAlias()}s").DataTable({
                    "ordering" : false,
                    "searching" : true,
                    "paging" : true,
                    "dom" : "ftp",
                    "pageLength" : 5,
                    "language": {
                        "url": "plugins/DataTables-1.10.12/i18n/ptBR.json"
                    }
                });
        }
                
        callServerJSON("GET","http://localhost:8080/recipe/rest/${clazz.getAlias()}/all/json", filter${clazz.getAlias(true)}SearchStatus);

    });


</script>
