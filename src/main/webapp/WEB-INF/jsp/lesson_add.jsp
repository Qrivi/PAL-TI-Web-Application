<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="include/head.jsp">
    <jsp:param value="Login" name="title"/>
</jsp:include>

<form:form method="post" commandName="lesson" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:input path="name" class="form-control" placeholder="Name"/>
    </div>
    <div class="form-group">
        <form:input path="description" class="form-control" placeholder="Description"/>
    </div>
    <div class="form-group">
        Date & Time:
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="input-group date" id="datetimepicker1">
                            <form:input path="date" type="text" class="form-control" placeholder="Lesson date"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        Duration: <form:input path="duration" type="time" class="form-control" placeholder="Lesson duration (optional)"/>
    </div>
    <div class="form-group">
        <form:select path="course" class="form-control" placeholder="Course">
            <form:option value="" label="--- Course ---"/>
            <form:options items="${courses}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>
    <div class="form-group">
        Maximum number of participants (optional): <form:input type="number" min="1" path="maxParticipants"
                                                               class="form-control"/>
    </div>
    <div>
        <form:select path="room" class="form-control" placeholder="Room">
            <form:option value="" label="--- Room ---"/>
            <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>

    <div>
        <form:select path="backupRoom" class="form-control">
            <form:option value="" label="--- Backup Room ---"/>
            <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Add</button>
    </div>
</form:form>

<jsp:include page="include/footer.jsp"/>