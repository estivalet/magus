            <div class="field">
        <#assign id="${column.getCamelCaseName()}">
        <#assign arch="${app.architecture}">
        <#assign size="${column.getInputSize()}">
        <label for="${id}"><strong>${column.getLabel()}<#if column.isRequired()>*</#if></strong></label> 
                <#switch column.customFieldType>
                    <#case 1><#-- CHECKBOX -->
                        <#list column.options?keys as field>
                <input id="${id}" name="${id}" type="checkbox" value="${column.options[field].value}" <c:if test="<#noparse>${fn:contains(</#noparse>${id}Value, '${column.options[field].value}')}">checked="checked"</c:if>/>${column.options[field].text}
                        </#list>
                    <#break>
                    <#case 2><#-- RADIO BUTTON -->
                        <#list column.options?keys as field>
                <input id="${id}" name="${id}" type="radio" value="${column.options[field].value}" <c:if test="<#noparse>${</#noparse>${id}Value == '${column.options[field].value}'}">checked="checked"</c:if>/>${column.options[field].text}</br>
                        </#list>
                    <#break>
                    <#case 4><#-- TEXT AREA -->
                <textarea cols="80" id="${id}" name="${id}" rows="10" maxlength="${size}"><#noparse>${</#noparse>${id}Value}</textarea>
                    <#break>
                    <#case 6><#-- SELECT BOX -->
                <select id="${id}" name="${id}">
                        <#list column.options?keys as field>
                    <option value="${column.options[field].value}" <c:if test="<#noparse>${</#noparse>${id}Value == '${column.options[field].value}'}">selected="selected"</c:if>>${column.options[field].text}</option>
                        </#list>
                </select>    
                    <#break>
                    <#case 7><#-- DATE PICKER -->
                <input id="${id}" name="${id}" type="text" value="<#noparse>${</#noparse>${id}Value}">
                <script>new datepickr('#${id}',{ dateFormat: 'd-m-Y'});</script>
                    <#break>
                    <#case 8><#-- RICH TEXT EDITOR -->
                <textarea class="ckeditor" id="${id}" name="${id}"><#noparse>${</#noparse>${id}Value}</textarea>
                    <#break>
                    <#case 9><#-- FILE UPLOAD -->    
                    <#-- The form tag is needed only for REST upload -->
                    <#if (arch = 'REST')>
                    <form action="rest/${clazz.getAlias()}/${id}" method="post" enctype="multipart/form-data">
                    </#if>                
                <input type="file" id="${id}" name="${id}"/>
                    <#if (arch = 'REST')>
                <input type="submit" value="Upload It" />
                    </form>
                    </#if>                
                    <#break>
                    <#case 10><#-- FILE UPLOAD (PDF)-->                    
                <input type="file" id="${id}" name="${id}"/>
                    <#break>
                    <#default>
                        <#-- SELECT BOX FK If attribute is a foreign key then create a combo box with the values for selection -->
                        <#if (column.isColumnInForeignKey())>
                            <#assign fkDisplay="${id}" + "_fk_display">
                <select id="${id}" name="${id}">
                    <c:forEach var="${column.getForeignTableAlias()}" items="<#noparse>${requestScope</#noparse>.${column.getForeignTableAlias()}s}">
                    <option value="<c:out value='<#noparse>${</#noparse>${column.getForeignTableColumnAlias()}}'/>" <c:if test="<#noparse>${</#noparse>${id}Value == ${column.getForeignTableColumnAlias()}<#noparse>}</#noparse>">selected="selected"</c:if>><c:out value='<#noparse>${</#noparse>${column.getForeignTableAlias()}.${.vars[fkDisplay]}}'/></option>
                    </c:forEach>
                </select>
                        <#else>
                        <#-- NORMAL INPUT Otherwise create a normal input. -->
                <input type="text" id="${id}" name="${id}" maxlength="${size}" value="<#noparse>${</#noparse>${id}Value}"/>
                        </#if>
                </#switch>
                <#if (column.comment != "")>
                <small class="tip-right">${column.comment}</small>
                </#if>
            </div>
            
            