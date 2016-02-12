<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div>
    <p>${lesson.name}</p>
    <p>${lesson.description}</p>
    <p>${lesson.date}</p>
    <p>Duration: ${lesson.duration/60} : ${lesson.duration%60}</p>
    <p>Course: ${lesson.course}</p>
    <p>Maximum number of participants: ${lesson.maxParticipants}</p>
    <p>Room: ${lesson.room}</p>
    <p>Backup room: ${lesson.backupRoom}</p>

</div>
<form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>

    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Register</button>
    </div>
</form:form>