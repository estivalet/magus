<%@include file="/header.jsp" %>

<script>
function validateForm() {
<#list columns as column><#t>
    <#if (column.isRequired())>
    var ${column.getCamelCaseName()} = document.getElementById("${column.getCamelCaseName()}").value;
    if(${column.getCamelCaseName()}.trim() == "") {
        document.getElementById("message").innerHTML = "<p><strong>${column.getCamelCaseName()}</strong> is required!</p>";
        document.getElementById("message").style.display = "block";
        document.getElementById("${column.getCamelCaseName()}").focus();
        return;
    }
    </#if>
    document.getElementById("myform").submit();    
</#list>
}
</script>

        <div class="box box-50">
                <div class="boxin">
                    <div class="header">
                        <h3>Create new ${clazzName}</h3>
                    </div>
            
                    <form id="myform" class="basic" action="${clazzName}" method="post">
                        <div class="inner-form">
                            <div id="message" class="msg msg-error" style="display:none"></div>
                            <input type="hidden" id="command" name="command" value="${clazzName?capitalize}Action"/>
                            <dl>
                            <#list columns as column><#t>
                                <#assign id="${column.getCamelCaseName()}">
                                <#assign size="${column.getInputSize()}">
                                  <dt><label for="${id}">${column.getLabel()}<#if column.isRequired()>*</#if></label></dt>
                                <#switch column.customFieldType>
                                    <#case 2>
                                        <#list column.options?keys as field>
                                  <dd>${column.options[field].text}<input id="${id}" name="${id}" type="radio" value="${column.options[field].value}"/></dd>
                            			</#list>
                        		    <#break>
                            		<#default>
                                        <#if (column.getInputSize() > maxInputSize)>
                                  <dd><textarea id="${id}" name="${id}" cols="80"></textarea></dd>
                                            <#else>
                                            <#-- If attribute is a foreign key then create a combo box with the values for selection -->
                                            <#if (column.isColumnInForeignKey())>
                                                <#assign fkDisplay="${id}" + "_fk_display">
                                  <dd><select id="${id}" name="${id}">
                                	        <c:forEach var="${column.getForeignTableAlias()}" items="<#noparse>${sessionScope</#noparse>.${column.getForeignTableAlias()}s}">
                                	            <option value="<c:out value='<#noparse>${</#noparse>${column.getForeignTableColumnAlias()}}'/>"><c:out value='<#noparse>${</#noparse>${column.getForeignTableAlias()}.${.vars[fkDisplay]}}'/></option>
                                	        </c:forEach>
                                	        </select></dd>
                                            <#else>
                                            <#-- Otherwise create a normal input. -->
                                  <dd>
                                        <input id="${id}" name="${id}" type="text" size="40" maxlength="${size}" class="txt"/>
                                        <#if (column.getComment() != "")>
                                        <small>${column.getComment()}</small>
                                        </#if>
                                  </dd>
                                            </#if>
                                        </#if>
                                </#switch>
                            </#list>
                                  <dt></dt>
                                  <dd>
                                        <input class="button" type="button" id="submit-go" value="Save" onclick="validateForm()"/>
                                        <input class="button" type="reset" value="Reset"/>
                                        <input class="button" type="button" value="Cancel" onclick="window.location.href='${clazzName}?command=${clazzName?cap_first}Action&action=search'"/>
                                  </dd>
                            </dl>                        
                        </div>
                    </form>
                </div>
            </div>
        </div> <!-- content_res end -->
    </div> <!-- content end -->


<#include "footer.ftl">