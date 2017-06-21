<%@include file="../header.jsp" %>

<style>
table.dataTable thead tr th,
table.dataTable thead tr td {
    background-color: #3399ff;
    border-color: #c0c0c0;
    color:#fff;
}
</style>


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
                <div id="divMsgDel" class="form-group invisible">
                    <label class="control-label" id="messagesDel"></label>
                </div>
            </div>
            <div class="box-body" id="box-body">
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    
    
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Create new</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                    <i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
                    <i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body">
                <form action="" method="post" id="myform" enctype="multipart/form-data">
                    <input type="hidden" id="command" name="command" value="POST"/>
                    <input type="hidden" id="op" name="op" value="save"/>
                    <input type="hidden" id="${pks.getCamelCaseName()}" name="${pks.getCamelCaseName()}" value="0"/>
                    <!-- form start -->
                    <div class="box-body">
                        <div id="divMsg" class="form-group invisible">
                            <label class="control-label" id="messages"></label>
                        </div>
                        <#list allColumns as column><#t>
                        <#assign id="${column.getCamelCaseName()}">
                        <#assign size="${column.getInputSize()}">
                        <#if (column.isColumnInForeignKey())>
                            <#assign fkDisplay="${id}" + "_fk_id">
                        <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${column.getForeignTableAlias()}.${.vars[fkDisplay]}}"/>
                        <#elseif (column.isColumnInExportedKey())>
                        <#elseif !column.isColumnInPrimaryKey()>
                        <c:set var="${id}Value" value="<#noparse>${requestScope.</#noparse>${clazz.getAlias()}.${column.getCamelCaseName()}}"/>
                        </#if>
                        <#include "field.ftl">
                        </#list>
                    </div>
                </form>                
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <button type="button" id="save" class="btn btn-primary">Save</button>
            </div>
            <!-- /.box-footer-->
        </div>
    
    
    
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->





<%@include file="../footer.jsp" %>

<!-- Page script -->
<script>
    $(function() {
    
        function list() {
            $.ajax({
               url: 'http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/all/json',
               type: 'GET',
               error: function() {
                  console.log('<p>An error has occurred</p>');
               },
               dataType: 'json',
               success: function(data) {
                    var table = createTable("box-body","${clazz.getAlias()}s","table table-striped table-bordered");
                    columns = [];
                    <#list allColumns as column><#t>
                    <#if (column.visible == 'Y')><#t>
                    <#if (column.isColumnInForeignKey())><#t>
                    columns.push("${column.getForeignTableAlias()}");
                    <#else><#t>
                    columns.push("${column.getLabel()}");
                    </#if><#t>
                    </#if><#t>
                    </#list><#t>
                    columns.push("");
                    addTableHeader(table, columns);
                    var tableBody = addTableBody(table);
                    
                    data.forEach(function(obj) { 
                        console.log(obj);
                        var tr = addTableRow(tableBody);
                        <#list allColumns as column><#t>
                        <#if (column.isColumnInPrimaryKey())>
                        <#assign pkColumn="${column.getLabel()}">
                        </#if>
                        </#list>
                        <#list allColumns as column><#t>
                        <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
                        <#if (column.visible == 'Y')>
                        <#if (column.customFieldType == 9)>
                        addTableCellHTML(tr,'<img src="?command=${clazz.getAlias(true)}Action&op=get${column.getCamelCaseName(true)}&id=' + obj.${pkColumn} + '" onerror="this.style.display=\'none\'" width="50"/>');
                        <#else>
                        <#if (column.isColumnInForeignKey())>
                        addTableCell(tr, obj.${column.getForeignTableAlias()}.${.vars[fkDisplay]});
                        <#else>
                        addTableCell(tr, obj.${column.getLabel()});
                        </#if>
                        </#if>
                        </#if>
                        </#list><#t>
                        addTableCellHTML(tr,"<a href=\"#\" onclick=\"edit${clazz.getAlias(true)}('" + obj.${pkColumn} + "')\">Edit</a>&nbsp;<a href=\"#\" onclick=\"remove${clazz.getAlias(true)}('" + obj.${pkColumn} + "')\">Remove</a>");
                    });
                    
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
            });
        }
        
        function addUpdate(url, type, obj) {
            $.ajax({
                url: url,
                contentType: "application/json",
                data: JSON.stringify(obj),                      
                type: type,
                error: function(xhr, status, error) {
                },
                success: function(data) {
                    console.log("OK" + data);
                    $('#divMsg').removeClass("invisible");
                    $('#divMsg').addClass("has-success");
                    $('#messages').text(data);
                    document.getElementById("box-body").innerHTML = "";
                    list();
                }
            });
        }
        
        /**
         * Call server to create or update a ${clazz.getAlias(true)}.
         */
        function add${clazz.getAlias(true)}(action) {
            // Collect data from input fields.
            var obj = { 
        <#list allColumns as column><#t>
            <#if (column.isColumnInForeignKey())><#t>
            "${column.getForeignTableAlias()}" : {"${column.getForeignTableColumnPkAlias()}" : document.getElementById("${column.getCamelCaseName()}").value},
            <#else>    
                <#if (column.customFieldType != 9 && column.customFieldType != 10)>
            "${column.getCamelCaseName()}" : isEmpty(document.getElementById("${column.getCamelCaseName()}").value) ? null : document.getElementById("${column.getCamelCaseName()}").value,
                </#if>
            </#if>
        </#list>
            };
        
            document.getElementById("command").value = "POST";
            // Check if we are creating or updating a ${clazz.getAlias(true)}.
            if(action == "POST") {
                addUpdate('http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/add', "post", obj);
            } else {
                addUpdate('http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/update', "put", obj);
            }
        }
        
        /**
         * Call server to get ${clazz.getAlias(true)} to edit.
         */
        edit${clazz.getAlias(true)} = function(${pkColumn}) {
            // Call server passing ${clazz.getAlias(true)} PK to edit.
            $.ajax({
                url: "http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/" + ${pkColumn} + "/json",
                contentType: "application/json",
                type: 'GET',
                error: function(xhr, status, error) {
                },
                success: function(obj) {
                    // Parse data retrieved from server to populate input fields. 
                    <#list allColumns as column><#t>
                    <#if (column.customFieldType != 9) && (column.customFieldType !=10) >
                    document.getElementById("${column.getCamelCaseName()}").value = typeof obj.${column.getCamelCaseName()} == "undefined" ? "" : obj.${column.getCamelCaseName()};
                    </#if>
                    </#list>
                    // Set command to be an update.      
                    document.getElementById("command").value = "PUT";      
                }
            });
        }
        
        /**
         * Call server to perform delete operation.
         */
        remove${clazz.getAlias(true)} = function(${pkColumn}) {
            // Ask for confirmation on delete.
            alertify.confirm('Confirm exclusion?', function () {
                // If really wants to delete then call the server to perform the action.
                addUpdate('http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/delete', "delete", {"${pkColumn}":${pkColumn}});
            });  
        }
        
        function validateForm() {
            <#list columnsMinusPk as column><#t>
            <#if (column.isRequired())>
            if($('#${column.getCamelCaseName()}').val() == '') {
                $('#divMsg').removeClass("invisible");
                $('#divMsg').addClass("has-error");
                $('#messages').text("${column.getCamelCaseName()} is a required field");
                return;
            }
            </#if>
            </#list>
            add${clazz.getAlias(true)}(document.getElementById("command").value); 
        }
        
        $('#save').click( function () {
            validateForm();
            
        });
    
        
                
        
        <#list columnsMinusPk as column><#t>
            <#if (column.isColumnInForeignKey())><#t>
            <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
        $.ajax({
            url: 'http://localhost:8080/${app.shortName}/rest/${column.getForeignTableAlias()}/all/json',
            dataType: 'json',
            success: function(data) {
                var combo = document.getElementById("${column.getCamelCaseName()}");
                data.forEach(function(obj) { 
                    id = obj.${column.getForeignTableColumnPkAlias()};
                    descricao = obj.${.vars[fkDisplay]};
                    option = document.createElement('option');
                    option.setAttribute('value', id);
                    option.appendChild(document.createTextNode(descricao));
                    combo.appendChild(option);
                });            
            },
            type: 'GET'
        });               
            </#if>
        </#list>
        
        list();
    });


</script>
