<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<div class="apply">
    <p>${student.name} wants to apply for ${course}</p>
</div>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <div class="form-group">
        <form action="<c:url value="/lesson/approve/${tutor.id}" />" method="POST">
            <button type="submit" class="btn btn-default pull-right">Approve</button>
        </form>
        <form action="<c:url value="/lesson/reject/${tutor.id}" />" method="POST">
            <button type="submit" class="btn btn-default pull-right">Reject</button>
        </form>
    </div>
</form:form>
