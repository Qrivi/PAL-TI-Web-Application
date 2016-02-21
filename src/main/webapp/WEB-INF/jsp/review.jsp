<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<table>
    <thead>
        <th>Lesson</th>
        <th>Date</th>
        <th>Student</th>
        <th>Content Score</th>
        <th>Tutor Score</th>
        <th>Engagement Score</th>
        <th>Atmosphere Score</th>
        <th>Comment</th>
    </thead>
    <tbody>
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
                <td>${review.text}</td></ts>
                <td>
                    <form id="command" action="<c:url value="/review/remove/${review.id}" />" method="POST">
                        <input type="submit" value="Delete"/>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
