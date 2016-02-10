<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:input path="code" class="form-control" placeholder="Course Code"/>
    </div>
    <div class="form-group">
        <form:input path="name" class="form-control" placeholder="Course Name"/>
    </div>
    <div class="form-group">
        <form:input path="shortName" class="form-control" placeholder="Course Short Name"/>
    </div>
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>