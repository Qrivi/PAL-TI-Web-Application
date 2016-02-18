<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form method="post" commandName="lesson" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        Date: <form:input path="name" class="form-control" placeholder="Name"/>
    </div>
    <div class="form-group">
        Date: <form:input path="description" class="form-control" placeholder="Description"/>
    </div>
    <div class="form-group">
        Date: <form:input path="date" type="datetime" class="form-control" placeholder="Date"/>
    </div>
    <div class="form-group">
        Date: <form:input path="time" type="datetime" class="form-control" placeholder="Time"/>
    </div>
    <div class="form-group">
        Duration: <form:input path="duration" type="time" class="form-control" placeholder="Lesson duration (optional)"/>
    </div>
    <div class="form-group">
        <form:select path="course" class="form-control" placeholder="Course">
            <form:option value="NONE" label="--- Course ---"/>
            <form:options items="${courses}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>
    <div class="form-group">
        Maximum number of participants (optional): <form:input type="number" min="1" path="maxParticipants"
                                                               class="form-control"/>
    </div>
    <div>
        <form:select path="room" class="form-control" placeholder="Room">
            <form:option value="NONE" label="--- Room ---"/>
            <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>

    <div>
        <form:select path="backupRoom" class="form-control">
            <form:option value="NONE" label="--- Backup Room ---"/>
            <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>