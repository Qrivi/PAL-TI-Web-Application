<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div>
    <p>${lesson.name}</p>
    <p>${lesson.description}</p>

</div>
<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>

    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Register</button>
    </div>
</form:form>