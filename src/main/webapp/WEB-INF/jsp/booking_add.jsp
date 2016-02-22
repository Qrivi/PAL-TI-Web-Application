<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Add booking" name="title"/>
</jsp:include>

<form:form method="post" commandName="booking" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <p>Name : ${booking.lesson.name}</p>
    <p>Description : ${booking.lesson.description}</p>
    <p>Date : ${booking.lesson.date}</p>
    <p>Duration: ${booking.lesson.duration / 60} hour(s)</p>
    <p>Course: ${booking.lesson.course.name}</p>
    <p>Maximum number of participants: ${booking.lesson.maxParticipants}</p>
    <p>Room: ${booking.lesson.room.name}</p>
    <p>Backup room: ${booking.lesson.backupRoom.name}</p>
    <form:hidden path="lesson" />
    <form:hidden path="student"/>
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Book</button>
    </div>
</form:form>