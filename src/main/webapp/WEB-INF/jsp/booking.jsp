<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<h2>Bookings for ${lesson}</h2>
<table>
    <thead>
        <tr>
            <th>Student</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.student.name}
                <td>${booking.student.email}</td>
                <td>
                    <form action="<c:url value="/booking/remove/${booking.id}" />" method="POST">
                        <input type="submit" value="Delete"/>
                    </form>
                </td>
                <td></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
