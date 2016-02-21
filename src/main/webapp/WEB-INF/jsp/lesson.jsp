<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Course</th>
            <th>Description</th>
            <th>Date</th>
            <th>Duration</th>
            <th>Maximum Participants</th>
            <th>Tutor</th>
            <th>Room</th>
            <th>Backup room</th>
            <th>Registered students</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="lesson" items="${lessons}">
            <tr>
                <td>${lesson.name}</td>
                <td>${lesson.course.name}</td>
                <td>${lesson.description}</td>
                <td>${lesson.date}</td>
                <td>${lesson.duration}</td>
                <td>${lesson.maxParticipants}</td>
                <td>${lesson.tutor.student.name}</td>
                <td>${lesson.room.name}</td>
                <td>${lesson.backupRoom.name}</td>
                <td>${lesson.bookings.size()}</td>
                <td>
                    <form id="command" action="<c:url value="/lesson/remove/${lesson.id}" />" method="POST">
                        <input type="submit" value="Delete"/>
                    </form>
                    <form id="register" action="<c:url value="/lesson/register/${lesson.id}" />" method="POST">
                        <input type="submit" value="Register"/>
                    </form>
                </td>
                <td></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
