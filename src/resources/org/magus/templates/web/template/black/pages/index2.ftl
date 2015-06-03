<%@include file="/header.jsp" %>

<#noparse><c:if test="${not empty requestScope.search}"></#noparse>
    <script>
    document.onload = submit('${clazzName}','${clazzName?capitalize}Action','search','1');
    </script>
<#noparse></c:if></#noparse>

</body>
</html>

