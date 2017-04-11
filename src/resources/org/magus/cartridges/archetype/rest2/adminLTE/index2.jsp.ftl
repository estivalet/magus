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
                    td.innerHTML = "<a href=\"#\" onclick=\"edit${clazz.getAlias(true)}('" + obj.${pkColumn} + "')\">Edit</a>&nbsp;<a href=\"#\" onclick=\"remove${clazz.getAlias(true)}('" + obj.${pkColumn} + "')\">Remove</a>";
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
        
        
        /**
         * Call server to create or update a ${clazz.getAlias(true)}.
         */
        add${clazz.getAlias(true)} = function(action) {
            // Collect data from input fields.
            var data = { 
        <#list allColumns as column><#t>
            <#if (column.isColumnInForeignKey())><#t>
            "${column.getForeignTableAlias()}" : {"${column.getForeignTableColumnPkAlias()}" : document.getElementById("${column.getCamelCaseName()}").value},
            <#else>    
                <#if (column.customFieldType != 9 && column.customFieldType != 10)>
            "${column.getCamelCaseName()}" : document.getElementById("${column.getCamelCaseName()}").value,
                </#if>
            </#if>
        </#list>
            };
        
            document.getElementById("command").value = "POST";
            // Check if we are creating or updating a ${clazz.getAlias(true)}.
            if(action == "POST") {
                callServerJSON("POST","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/add", add${clazz.getAlias(true)}Status, data);
            } else {
                callServerJSON("PUT","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/update", update${clazz.getAlias(true)}Status, data);
            }
        }
        
        /**
         * Callback function after creating a ${clazz.getAlias(true)}. 
         */
        add${clazz.getAlias(true)}Status = function() {
            // If ${clazz.getAlias(true)} was created correctly then display a message and returns back to search screen.
            if (xmlhttp.readyState == 4 && xmlhttp.status == 201) {
                $('#divMsg').removeClass("invisible");
                $('#divMsg').addClass("has-success");
                $('#messages').text(xmlhttp.responseText);
                document.getElementById("box-body").innerHTML = "";
                callServerJSON("GET","http://localhost:8080/recipe/rest/${clazz.getAlias()}/all/json", filter${clazz.getAlias(true)}SearchStatus);
            }
        } 
        
        /**
         * Callback function after updating a ${clazz.getAlias(true)}. 
         */
        update${clazz.getAlias(true)}Status = function() {
            // If ${clazz.getAlias(true)} was updated correctly then display a message and returns back to search screen.
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                $('#divMsg').removeClass("invisible");
                $('#divMsg').addClass("has-success");
                $('#messages').text(xmlhttp.responseText);
                document.getElementById("box-body").innerHTML = "";
                callServerJSON("GET","http://localhost:8080/recipe/rest/${clazz.getAlias()}/all/json", filter${clazz.getAlias(true)}SearchStatus);
            }
        }  
        
        /**
         * Call server to get ${clazz.getAlias(true)} to edit.
         */
        edit${clazz.getAlias(true)} = function(${pkColumn}) {
            // Call server passing ${clazz.getAlias(true)} PK to edit.
            callServerJSON("GET","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/" + ${pkColumn} + "/json", edit${clazz.getAlias(true)}Status);    
        }
        
        /**
         * Callback function to populate selected ${clazz.getAlias(true)} fields to be edited. 
         */
        edit${clazz.getAlias(true)}Status = function() {
            // If the call to the server got success.
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // Parse data retrieved from server to populate input fields. 
                var obj = JSON.parse(xmlhttp.responseText);
                <#list allColumns as column><#t>
                <#if (column.customFieldType != 9) && (column.customFieldType !=10) >
                document.getElementById("${column.getCamelCaseName()}").value = typeof obj.${column.getCamelCaseName()} == "undefined" ? "" : obj.${column.getCamelCaseName()};
                </#if>
                </#list>
                // Set command to be an update.      
                document.getElementById("command").value = "PUT";      
            }    
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
    
        /**
         * Call server to perform delete operation.
         */
        remove${clazz.getAlias(true)} = function(${pkColumn}) {
            // Ask for confirmation on delete.
            alertify.confirm('Confirm exclusion?', function () {
                // If really wants to delete then call the server to perform the action.
                var data = {"${pkColumn}":${pkColumn}};
                callServerJSON("DELETE","http://localhost:8080/${app.shortName}/rest/${clazz.getAlias()}/delete", remove${clazz.getAlias(true)}Status, data);
            });  
        }
        
        /**
         * Callback function to check delete operation status. 
         */
        remove${clazz.getAlias(true)}Status = function() {
            // If the delete operation got success.
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                $('#divMsgDel').removeClass("invisible");
                $('#divMsgDel').addClass("has-success");
                $('#messagesDel').text(xmlhttp.responseText);
                document.getElementById("box-body").innerHTML = "";
                callServerJSON("GET","http://localhost:8080/recipe/rest/${clazz.getAlias()}/all/json", filter${clazz.getAlias(true)}SearchStatus);
            }
        }    
    
    
        
                
        callServerJSON("GET","http://localhost:8080/recipe/rest/${clazz.getAlias()}/all/json", filter${clazz.getAlias(true)}SearchStatus);
        
        
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
    });


</script>
