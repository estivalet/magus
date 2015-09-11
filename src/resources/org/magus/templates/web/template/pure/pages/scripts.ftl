<script type="text/javascript">
function displayError(fieldName) {
    document.getElementById("messageText").innerHTML = fieldName + " is required!";
    document.getElementById("message").style.display = "block";
    document.getElementById(fieldName).focus();
}

function validateForm() {
<#list columns as column><#t>
    <#if (column.isRequired())>
    <#-- RADIO BUTTON -->
        <#if column.customFieldType == 2 >
    var ${column.getCamelCaseName()} = document.getElementsByName("${column.getCamelCaseName()}");
    var selected = false;
    for (var i = 0, length = ${column.getCamelCaseName()}.length; i < length; i++) {
        if (${column.getCamelCaseName()}[i].checked) {
            selected = true;
            break;
        }
    }
    if(!selected) {
        displayError("${column.getCamelCaseName()}");
        return;
    }
        <#else>
    var ${column.getCamelCaseName()} = document.getElementById("${column.getCamelCaseName()}").value;
    if(${column.getCamelCaseName()}.trim() == "") {
        displayError("${column.getCamelCaseName()}");
        return;
    }
        </#if>
    </#if>
</#list>
    document.getElementById("myform").submit();    
}
</script>
