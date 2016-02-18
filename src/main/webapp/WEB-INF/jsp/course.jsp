<%@ page import="be.peerassistedlearningti.web.model.util.SessionAuth" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table>
    <th>
        <td>Course Code</td>
        <td>Name</td>
        <td>Short name</td>
        <td>Curriculum</td>
        <td>Year</td>
        <td>Subscribers</td>
    </th>
    <c:forEach var="course" items="${courses}">
        <tr>
            <td>${course.code}</td>
            <td>${course.name}</td>
            <td>${course.shortName}</td>
            <td>${course.curriculum}</td>
            <td>${course.year}</td>
            <td>${course.subscribers.size()}</td>
            <td>
                <c:choose>
                    <c:when test="${!course.isSubscribed(SessionAuth.student)}">
                        <form id="subscribe" action="<c:url value="/course/subscribe/${course.id}" />" method="POST">
                            <input type="submit" value="Subscribe"/>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form id="unsubscribe" action="<c:url value="/course/unsubscribe/${course.id}" />" method="POST">
                            <input type="submit" value="Unsubscribe"/>
                        </form>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <form id="command" action="<c:url value="/course/remove/${course.id}" />" method="POST">
                    <input type="submit" value="Delete"/>
                </form>
            </td>
            <td></td>
        </tr>
    </c:forEach>
</table>