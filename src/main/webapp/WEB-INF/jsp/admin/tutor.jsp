<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../include/head.jsp">
    <jsp:param value="Tutors" name="Tutors"/>
</jsp:include>

<table>
    <thead>
        <tr>
            <th>Tutor</th>
            <th>Course</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="tutor" items="${tutors}">
            <tr>
                <td>${tutor.student.name}</td>
                <td>
                    <ol>
                        <c:forEach var="course" items="${tutor.courses}">
                            <li>${course.name}</li>
                        </c:forEach>
                    </ol>
                </td>
                <td>
                    <form id="command" action="<c:url value="/booking/remove/${tutor.id}" />" method="POST">
                        <input type="submit" value="Delete"/>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
