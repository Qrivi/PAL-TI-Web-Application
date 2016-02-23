<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Add a lesson" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="lesson_add" name="title"/>
            </jsp:include>
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Make a new lesson
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="post" commandName="lesson" enctype="application/x-www-form-urlencoded">
                                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                                <c:set var="descriptionError"><form:errors path="description"/></c:set>
                                                <c:set var="dateError"><form:errors path="date"/></c:set>
                                                <c:set var="courseError"><form:errors path="course"/></c:set>
                                                <c:set var="maxParticipantsError"><form:errors path="maxParticipants"/></c:set>
                                                <c:set var="durationError"><form:errors path="duration"/></c:set>
                                                <c:set var="roomError"><form:errors path="room"/></c:set>
                                                <c:set var="backupRoomError"><form:errors path="backupRoom"/></c:set>
                                                <div class="form-group has-feedback">
                                                    <form:label path="name">Name : <span class="text-danger">${nameError}</span></form:label>
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                                <div class="form-group has-feedback">
                                                    <form:label path="description">Description : <span class="text-danger">${descriptionError}</span></form:label>
                                                    <form:textarea path="description" class="form-control" placeholder="Description"/>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <form:label path="date">Date & Time : <span class="text-danger">${dateError}</span></form:label>
                                                        <div class="form-group has-feedback">
                                                            <div class="input-group date" id="datetimepicker">
                                                                <form:input path="date" type="text" class="form-control" placeholder="Lesson date"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group has-feedback">
                                                            <form:label path="course">Course : <span class="text-danger">${courseError}</span></form:label>
                                                            <form:select path="course" class="form-control" placeholder="Course">
                                                                <form:option value="" label="--- Course ---"/>
                                                                <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                                            </form:select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group has-feedback">
                                                            <form:label path="maxParticipants">Maximum number of participants : <span class="text-danger">${maxParticipantsError}</span></form:label>
                                                            <form:input path="maxParticipants" type="number" min="1" class="form-control" placeholder="Maximum number of participants"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <form:label path="duration">Duration : <span class="text-danger">${durationError}</span></form:label>
                                                        <form:input path="duration" type="time" class="form-control" placeholder="Lesson duration (optional)"/>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group has-feedback">
                                                            <form:label path="room">Room : <span class="text-danger">${roomError}</span></form:label>
                                                            <form:select path="room" class="form-control" placeholder="Room">
                                                                <form:option value="" label="--- Room ---"/>
                                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                                            </form:select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group has-feedback">
                                                        <div class="col-md-6">
                                                            <form:label path="backupRoom">Backup room : <span class="text-danger">${backupRoomError}</span></form:label>
                                                            <form:select path="backupRoom" class="form-control">
                                                                <form:option value="" label="--- Backup Room ---"/>
                                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                                            </form:select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-primary pull-right">Add</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
        <script>
            $( document ).ready( function () {
                $( "#datetimepicker" ).datetimepicker( {
                    locale : 'nl'
                } );
            } );
        </script>
    </body>
</html>