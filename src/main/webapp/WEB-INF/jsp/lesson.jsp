<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table>
    <c:forEach var="lesson" items="${lessons}">
        <tr>
            <td>${lesson.name}</td>
            <td>${lesson.course}</td>
            <td>${lesson.description}</td>
            <td>${lesson.date}</td>
            <td>${lesson.duration}</td>
            <td>${lesson.maxParticipants}</td>
            <td>${lesson.tutor}</td>
            <td>${lesson.room}</td>
            <td>${lesson.backupRoom}</td>

            <td>
                <form id="command" action="<c:url value="/lesson/remove/${lesson.id}" />" method="POST">
                    <input type="submit" value="Delete"/>
                </form>
                <form id="command" action="<c:url value="/lesson/register/${lesson.id}" />" method="POST">
                    <input type="submit" value="Register"/>
                </form>
                <!-- authenticated student -->
            </td>
            <td></td>
        </tr>
    </c:forEach>
</table>
