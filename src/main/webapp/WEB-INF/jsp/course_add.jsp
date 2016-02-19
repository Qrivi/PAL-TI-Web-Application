<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:input path="code" class="form-control" placeholder="Course code"/>
    </div>
    <div class="form-group">
        <form:input path="name" class="form-control" placeholder="Course name"/>
    </div>
    <div class="form-group">
        <form:input path="shortName" class="form-control" placeholder="Course short name"/>
    </div>
    <div class="form-group">
        <form:input path="curriculum" class="form-control" placeholder="Course curriculum"/>
    </div>
    <div class="form-group">
        <form:input type="number" min="1" value="null" path="year" class="form-control" placeholder="Course year"/>
    </div>
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>