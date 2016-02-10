<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:input type="datetime" path="date" class="form-control" placeholder="Date & Time"/>
    </div>
    <div class="form-group">
        <form:input type="time" path="duration" class="form-control" placeholder="Lesson duration (optional)"/>
    </div>
    <div class="form-group">
        <form:input path="course" class="form-control" placeholder="Course Short Name"/>
        <!-- drop down ? -->
    </div>
    <div class="form-group">
        <form:input type="number" path="maxParticipants" class="form-control" placeholder="Maximum number of participants (optional)"/>
    </div>
    <div class="form-group">
        <form:input type="time" path="room" class="form-control" placeholder="Room"/>
    </div>
    <div class="form-group">
        <form:input type="time" path="backup room" class="form-control" placeholder="Backup room"/>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>