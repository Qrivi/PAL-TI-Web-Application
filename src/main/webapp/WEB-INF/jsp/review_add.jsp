<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:input path="text" class="form-control" placeholder="Comment"/>
    </div>
    <div class="form-group">
        <form:input type="number" min="1" max="10" path="contentScore" class="form-control" placeholder="Content score"/>
    </div>
    <div class="form-group">
        <form:input type="number" min="1" max="10" path="tutorScore" class="form-control" placeholder="Tutor score"/>
    </div>
    <div class="form-group">
        <form:input type="number" min="1" max="10" path="engagementScore" class="form-control" placeholder="Engagement score"/>
    </div>
    <div class="form-group">
        <form:input type="number" min="1" max="10" path="AtmosphereScore" class="form-control" placeholder="Atmosphere score"/>
    </div>
    <div class="form-group">
        <form:input type="checkbox" path="Anonymous" class="form-control" placeholder="Anonymous"/>
    </div>
    
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>
