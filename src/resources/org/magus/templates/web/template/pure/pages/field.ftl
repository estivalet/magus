            <div class="field">
        <#assign id="${column.getCamelCaseName()}">
        <#assign size="${column.getInputSize()}">
        <label for="${id}"><strong>${column.getLabel()}<#if column.isRequired()>*</#if></strong></label> 
                <#switch column.customFieldType>
                    <#case 2>
                        <#list column.options?keys as field>
                <input id="${id}" name="${id}" type="radio" value="${column.options[field].value}" <c:if test="<#noparse>${</#noparse>${id}Value == '${column.options[field].value}'}">checked="checked"</c:if>/>${column.options[field].text}</br>
                        </#list>
                    <#break>
                    <#case 6>
                <select id="${id}" name="${id}">
                        <#list column.options?keys as field>
                    <option value="${column.options[field].value}" <c:if test="<#noparse>${</#noparse>${id}Value == '${column.options[field].value}'}">selected="selected"</c:if>>${column.options[field].text}</option>
                        </#list>
                </select>    
                    <#break>
                    <#case 7>
                <input id="${id}" name="${id}" type="text">
                <script>datepickr('#${id}',{ dateFormat: 'd-m-Y'});</script>
                    <#break>
                    <#case 8>
                <textarea class="ckeditor" cols="80" id="${id}" name="${id}" rows="10"><#noparse>${</#noparse>${id}Value}</textarea>
                    <#break>
                    
                    <#default>
                        <#-- If attribute is a foreign key then create a combo box with the values for selection -->
                        <#if (column.isColumnInForeignKey())>
                            <#assign fkDisplay="${id}" + "_fk_display">
                <select id="${id}" name="${id}">
                    <c:forEach var="${column.getForeignTableAlias()}" items="<#noparse>${requestScope</#noparse>.${column.getForeignTableAlias()}s}">
                    <option value="<c:out value='<#noparse>${</#noparse>${column.getForeignTableColumnAlias()}}'/>" <c:if test="<#noparse>${</#noparse>${id}Value == ${column.getForeignTableColumnAlias()}<#noparse>}</#noparse>">selected="selected"</c:if>><c:out value='<#noparse>${</#noparse>${column.getForeignTableAlias()}.${.vars[fkDisplay]}}'/></option>
                    </c:forEach>
                </select>
                        <#else>
                        <#-- Otherwise create a normal input. -->
                <input type="text" id="${id}" name="${id}" maxlength="${size}" value="<#noparse>${</#noparse>${id}Value}"/>
                        </#if>
                </#switch>
                <small class="tip-right">tip</small>
            </div>
            
            