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
                        <h3>Update ${clazzName}</h3>
                    </div>
                    <form id="myform" class="basic" action="${clazzName}" method="post">
                        <div class="inner-form">
                            <div id="message" class="msg msg-error" style="display:none"></div>
                            <input type="hidden" id="command" name="command" value="${clazzName?capitalize}Action"/>
                            <#list pks as pk><#t>
                            <input type="hidden" id="${pk.getCamelCaseName()}" name="${pk.getCamelCaseName()}" value="<c:out value='<#noparse>${sessionScope.</#noparse>${clazzName}.${pk.getCamelCaseName()}}'/>"/>
                            </#list>
                        	<dl>
                            <#list columns as column><#t>
                                <dt><label for="${column.getCamelCaseName()}">${column.getLabel()} <#if !column.getNullable()>*</#if></label></dt>
                                <#if (column.getInputSize() > maxInputSize)>
                                <dd><textarea id="${column.getCamelCaseName()}" name="${column.getCamelCaseName()}" type="text" cols="80"><c:out value='<#noparse>${sessionScope.</#noparse>${clazzName}.${column.getCamelCaseName()}}'/></textarea></dd>
                                <#else>
                                <#if (column.isColumnInForeignKey())>
                                <dd><select id="${column.getCamelCaseName()}" name="${column.getCamelCaseName()}">
                                <c:forEach var="${column.getForeignTableAlias()}" items="<#noparse>${sessionScope</#noparse>.${column.getForeignTableAlias()}s}">
                                <#assign fkDisplay="${column.getCamelCaseName()}" + "_fk_display">
                                <option value="<c:out value='<#noparse>${</#noparse>${column.getForeignTableColumnAlias()}}'/>" <c:if test="<#noparse>${</#noparse>${column.getForeignTableColumnAlias()}==sessionScope.${clazzName}.${column.getForeignTableColumnAlias()}}">selected</c:if>  ><c:out value='<#noparse>${</#noparse>${column.getForeignTableAlias()}.${.vars[fkDisplay]}}'/></option>
                                </c:forEach>
                                </select></dd>
                                <#else>
                                <dd><input class="txt" id="${column.getCamelCaseName()}" name="${column.getCamelCaseName()}" type="text" size="40" value="<c:out value='<#noparse>${sessionScope.</#noparse>${clazzName}.${column.getCamelCaseName()}}'/>"/></dd>
                                </#if>
                                </#if>
                            </#list>
                                  <dt></dt>
                                  <dd><input class="button" type="button" id="submit-go" value="Save" onclick="validateForm()"/>
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