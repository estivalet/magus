<script type="text/javascript">
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
</script>
