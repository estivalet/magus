<%@include file="/header.jsp" %>

<#-- If any column uses ckeditor then must include it. -->
<#list columns as column><#t>
    <#switch column.customFieldType>
        <#case 8>
<script src="js/ckeditor/ckeditor.js"></script>
        <#break>
    </#switch>
</#list>
<#list columns as column><#t>
    <#if (column.inputMask??)>
<script src="js/jquery.maskedinput.js"></script>
        <#break>
    </#if>
</#list>
  

<script>
function validateForm() {
<#list columns as column><#t>
    <#if (column.isRequired())>
    var ${column.getCamelCaseName()} = document.getElementById("${column.getCamelCaseName()}").value;
    if(${column.getCamelCaseName()}.trim() == "") {
        document.getElementById("messageText").innerHTML = "${column.getCamelCaseName()} is required!";
        document.getElementById("message").style.display = "block";
        document.getElementById("${column.getCamelCaseName()}").focus();
        return;
    }
    </#if>
</#list>
    document.getElementById("myform").submit();    
}

    $(function() {
        $( ".datepicker" ).datepicker({
            showOn: "button",
            buttonImage: "images/calendar.gif",
            buttonImageOnly: true
        });

        $(".ui-datepicker-trigger").css("margin-bottom","-8px").css("width","26px");
        <#list columns as column><#t>
            <#if (column.inputMask??)>
        $("#${column.getCamelCaseName()}").mask("${column.inputMask}");
            </#if>
        </#list>
    });
    
</script>


    <div id="content">



        <div class="content_block" style="padding: 20px;">

            <div class="rightblock vertsortable ui-sortable">

                <div class="gadget jsi_gv" style="width: 500px">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>Create new ${clazzName}</h3>
                    </div>
                    <div class="gadget_content">
                        <form action="${servlet}" method="post" id="myform" class="form_example">
                            <div id="message" style="display:none">
                                <p class="err_mes jsi_mes_red">
                                    <img class="pimpa" width="13" height="13" src="css/images/pimpa_red.gif"><span id="messageText"></span><a class="close_mess" href="#"> <img
                                            width="24" height="38" src="css/images/spacer.gif"></a>
                                </p>
                            </div>
                            <input type="hidden" id="command" name="command" value="${clazzName?cap_first}Action"/>
                            <ol>
                            
                            <#list columns as column><#t>
                                <#assign id="${column.getCamelCaseName()}">
                                <#assign size="${column.getInputSize()}">
                                <li>
                                    <label for="${id}"><strong>${column.getLabel()}<#if column.isRequired()>*</#if></strong></label> 
                                <#include "field.ftl">
                                </li>
                            </#list>
                            
                            </ol>
                        </form>
                    </div>
                </div>



            </div>
            <div class="clr"></div>
            <input type="button" id="submit-go" value="Save" onclick="validateForm()"/>
            <input type="reset" value="Reset"/>
            <input type="button" value="Cancel" onclick="window.location.href='${servlet}?command=${clazzName?cap_first}Action&action=index'"/>
        </div>





    </div>




<#include "footer.ftl">