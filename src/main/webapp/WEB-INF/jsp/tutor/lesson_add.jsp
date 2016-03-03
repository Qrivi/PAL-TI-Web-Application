<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                        <div class="col-md-12">
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
                                    <form:label path="name">Name : <c:if test="${not empty nameError}"><span class="text-danger">${nameError}</span></c:if></form:label>
                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                </div>
                                <div class="form-group has-feedback">
                                    <form:label path="description">Description : <c:if test="${not empty descriptionError}"><span class="text-danger">${descriptionError}</span></c:if></form:label>
                                    <form:textarea path="description" class="form-control" placeholder="Description" rows="5"/>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <form:label path="date">Date & Time : <c:if test="${not empty dateError}"><span class="text-danger">${dateError}</span></c:if></form:label>
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
                                            <form:label path="course">Course : <c:if test="${not empty courseError}"><span class="text-danger">${courseError}</span></c:if></form:label>
                                            <form:select path="course" class="form-control select2 select2-hidden-accessible"
                                                         data-placeholder="Course" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                                <option></option>
                                                <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="maxParticipants">Maximum number of participants : <c:if test="${not empty maxParticipantsError}"><span class="text-danger">${maxParticipantsError}</span></c:if></form:label>
                                            <form:input path="maxParticipants" type="number" min="1" class="form-control" placeholder="Maximum number of participants"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="duration">Duration : <c:if test="${not empty durationError}"><span class="text-danger">${durationError}</span></c:if></form:label>
                                            <form:input path="duration" type="time" class="form-control" placeholder="Lesson duration"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="room">Room : <c:if test="${not empty roomError}"><span class="text-danger">${roomError}</span></c:if></form:label>
                                            <form:select path="room" class="form-control select2 select2-hidden-accessible"
                                                         data-placeholder="Room" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                                <option></option>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <div class="col-md-6">
                                            <form:label path="backupRoom">Backup room : <c:if test="${not empty backupRoomError}"><span class="text-danger">${backupRoomError}</span></c:if></form:label>
                                            <form:select path="backupRoom" class="form-control select2 select2-hidden-accessible"
                                                         data-placeholder="Backup Room" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                                <option></option>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-default pull-right">Make lesson</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>