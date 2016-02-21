<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="student" property="principal"/>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<table>
    <thead>
        <tr>
            <th>Course Code</th>
            <th>Name</th>
            <th>Short name</th>
            <th>Curriculum</th>
            <th>Year</th>
            <th>Lessons</th>
            <th>Subscribe</th>
            <th>Subscribers</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="course" items="${courses}">
            <tr>
                <td>${course.code}</td>
                <td>${course.name}</td>
                <td>${course.shortName}</td>
                <td>${course.curriculum}</td>
                <td>${course.year}</td>
                <td>
                    <form  action="<c:url value="/lesson/overview/${course.id}" />" method="POST">
                        <input type="submit" value="Lessons"/>
                    </form>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${course.isSubscribed(student)}">
                            <form  action="<c:url value="/course/unsubscribe/${course.id}" />" method="POST">
                                <input type="submit" value="Unsubscribe"/>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="<c:url value="/course/subscribe/${course.id}" />" method="POST">
                                <input type="submit" value="Subscribe"/>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${course.subscribers.size()}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>