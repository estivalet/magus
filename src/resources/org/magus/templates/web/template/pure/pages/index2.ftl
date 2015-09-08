<%@include file="../header.jsp" %>
<script>
var xmlhttp = new XMLHttpRequest();

function callServerJSON(method, url, f, data) {
    xmlhttp.onreadystatechange = f;
    xmlhttp.open(method, url, true);
    xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xmlhttp.send(JSON.stringify(data));
}

function filterSearchStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        var xml = xmlhttp.responseXML;
        alert(xmlhttp.responseText);
        var obj = JSON.parse(xmlhttp.responseText);
        alert(obj.length);
        alert(obj[0].descricao);
    }
}    

function search() {
    callServerJSON("GET","http://localhost:8080/${appShortName}/rest/${clazzName}/all/json", filterSearchStatus);
}

function add(categoria) {
    var data = {"descricao":categoria};
    callServerJSON("POST","http://localhost:8080/${appShortName}/rest/${clazzName}/add", addStatus, data);
}

function addStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        alert(xmlhttp.responseText);
    }
}    

function remove(id) {
    var data = {"id":id};
    callServerJSON("DELETE","http://localhost:8080/${appShortName}/rest/${clazzName}/delete", removeStatus, data);
}

function removeStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        alert(xmlhttp.responseText);
    }
}    

function update(data) {
    callServerJSON("PUT","http://localhost:8080/${appShortName}/rest/${clazzName}/update", updateStatus, data);
}

function updateStatus() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
        alert(xmlhttp.responseText);
    }
}    

add('teste');
//search();
//remove(30);
 //var data = {"descricao":"teste update", "id":"22"};
 //update(data);
</script>
<#include "footer.ftl">