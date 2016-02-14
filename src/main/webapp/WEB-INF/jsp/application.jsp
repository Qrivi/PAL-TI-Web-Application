<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:forEach var="application" items="${applications}">
    <div class="apply">
        <p>${application.student.name} wants to apply for ${application.course.name}</p>
        <img src="<c:url value="screenshot/${application.id}" />" alt="Application screenshot" width="500px" height="250px"/>
    </div>
    <form action="<c:url value="approve/${application.id}" />" method="POST">
        <button type="submit" class="btn btn-default pull-right">Approve</button>
    </form>
    <form action="<c:url value="reject/${application.id}" />" method="POST">
        <button type="submit" class="btn btn-default pull-right">Reject</button>
    </form>
</c:forEach>
