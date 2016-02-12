<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="apply">
    <p>${student.name} wants to apply for ${course}</p>
</div>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Approve</button>
        <button type="submit" class="btn btn-default pull-right">Reject</button>
    </div>
</form:form>
