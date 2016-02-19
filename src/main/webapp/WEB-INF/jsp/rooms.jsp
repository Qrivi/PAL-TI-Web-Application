<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<table>
    <c:forEach var="room" items="${rooms}">
        <tr>
            <td>${room.name}</td>
            <td>${room.campus}</td>
            <td>${room.type}</td>
            <td>
                <form id="command" action="<c:url value="/room/remove/${room.id}" />" method="POST">
                    <input type="submit" value="Delete"/>
                </form>
            </td>
            <td></td>
        </tr>
    </c:forEach>
</table>