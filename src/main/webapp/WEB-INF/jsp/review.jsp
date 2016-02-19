<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<table>
    <c:forEach var="review" items="${reviews}">
        <tr>
            <td>${review.lesson.name}</td>
            <td>${review.date}</td>
            <td>
                <c:when test="${review.anonymous}">Anonymous</c:when>
                <c:otherwise>${review.student}</c:otherwise>
            </td>
            <td>${review.contentScore}</td>
            <td>${review.tutorScore}</td>
            <td>${review.engagementScore}</td>
            <td>${review.atmosphereScore}</td>
            <td>
                <form id="command" action="<c:url value="/review/remove/${review.id}" />" method="POST">
                    <input type="submit" value="Delete"/>
                </form>
            </td>
            <td></td>
        </tr>
    </c:forEach>
</table>
