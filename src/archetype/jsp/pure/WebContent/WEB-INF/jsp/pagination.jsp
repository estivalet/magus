<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul>
<!-- Previous page -->
<c:choose>
    <c:when test="${pageNum==1}">
        <li><a href="#" class="prevnext disablelink">« previous</a></li>
    </c:when>
    <c:otherwise>
        <li><a href="#" class="prevnext" onclick="executeSearch(<c:out value='${pageNum-1}' />)">« previous</a></li>
    </c:otherwise>
</c:choose>

<c:set var="start" value="${pageNum-5}" />
<c:if test="${start<1}">
    <c:set var="start" value="1" />
</c:if>

<c:set var="end" value="${pageNum+5}" />
<c:if test="${end>totalPages}">
    <c:set var="end" value="${totalPages}" />
</c:if>

<c:forEach var="i" begin="${start}" end="${end}">
    <c:choose>
        <c:when test="${i==pageNum}">
            <li><a href="#" class="currentpage"><c:out value="${i}" /></a></li>
        </c:when>
        <c:otherwise>
            <li><a href="#" onclick="executeSearch(<c:out value='${i}' />)"><c:out value="${i}"/></a></li>
        </c:otherwise>
    </c:choose>
</c:forEach>

<c:if test="${end!=totalPages}">
    <li>...</li>
    <li><a href="#" onclick="executeSearch(<c:out value='${totalPages}' />)"><c:out
                    value="${totalPages}" /></a></li>
</c:if>

<!-- Next page -->
<c:choose>
    <c:when test="${pageNum==totalPages}">
        <li><a href="#" class="prevnext disablelink">next »</a></li>
    </c:when>
    <c:otherwise>
        <li><a href="#" class="prevnext" onclick="executeSearch(<c:out value='${pageNum+1}' />)">next »</a></li>
    </c:otherwise>
</c:choose>

</ul>
