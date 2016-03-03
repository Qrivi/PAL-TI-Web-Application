<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="content-header">
    <h1>
        Lesson "${lesson.name}"
    </h1>
</section>
<!-- main content -->
<section class="content container-box">
    <div class="row">
        <!-- edit form -->
        <div class="col-md-12 col-sm-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Lesson</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="put" commandName="lesson"
                                       enctype="application/x-www-form-urlencoded">
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="descriptionError"><form:errors path="description"/></c:set>
                                <c:set var="dateError"><form:errors path="date"/></c:set>
                                <c:set var="courseError"><form:errors path="course"/></c:set>
                                <c:set var="maxParticipantsError"><form:errors path="maxParticipants"/></c:set>
                                <c:set var="durationError"><form:errors path="duration"/></c:set>
                                <c:set var="roomError"><form:errors path="room"/></c:set>
                                <c:set var="backupRoomError"><form:errors path="backupRoom"/></c:set>
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="form-group has-feedback">
                                            <form:label path="name">Name : <c:if test="${not empty nameError}"><span
                                                    class="text-danger">${nameError}</span></c:if></form:label>
                                            <form:input path="name" class="form-control" placeholder="Name"/>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-feedback">
                                            <form:label path="request">Request : </form:label>
                                            <form:select path="request"
                                                         class="form-control select2 select2-hidden-accessible"
                                                         data-placeholder="Request (optional)" style="width: 100%;"
                                                         tabindex="-1" aria-hidden="true">
                                                <option></option>
                                                <form:option value="null" label="None"/>
                                                <form:options items="${requests}" itemValue="id" itemLabel="title"/>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <form:label path="date">Date & Time : <c:if
                                                test="${not empty dateError}"><span
                                                class="text-danger">${dateError}</span></c:if></form:label>
                                        <div class="form-group has-feedback">
                                            <div class="input-group date" id="datetimepicker">
                                                <form:input path="date" type="text" class="form-control"
                                                            placeholder="Lesson date" disabled="${!editable}"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="course">Course : <c:if
                                                    test="${not empty courseError}"><span
                                                    class="text-danger">${courseError}</span></c:if></form:label>
                                            <form:select path="course" class="form-control"
                                                         placeholder="Course" disabled="${!editable}">
                                                <option></option>
                                                <form:options items="${courses}" itemValue="id"
                                                              itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="maxParticipants">Maximum number of participants :
                                                <c:if test="${not empty maxParticipantsError}"><span
                                                        class="text-danger">${maxParticipantsError}</span></c:if></form:label>
                                            <form:input path="maxParticipants" type="number" min="1"
                                                        class="form-control"
                                                        placeholder="Maximum number of participants" disabled="${!editable}"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="duration">Duration : <c:if
                                                    test="${not empty durationError}"><span
                                                    class="text-danger">${durationError}</span></c:if></form:label>
                                            <form:input path="duration" type="time" class="form-control"
                                                        placeholder="Lesson duration" disabled="${!editable}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="room">Room : <c:if
                                                    test="${not empty roomError}"><span
                                                    class="text-danger">${roomError}</span></c:if></form:label>
                                            <form:select path="room" class="form-control" placeholder="Room" disabled="${!editable}">
                                                <form:option value="" label="--- Room ---"/>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <div class="col-md-6">
                                            <form:label path="backupRoom">Backup room :
                                                <c:if test="${not empty backupRoomError}">
                                                    <span
                                                            class="text-danger">${backupRoomError}
                                                    </span>
                                                </c:if>
                                            </form:label>
                                            <form:select path="backupRoom" class="form-control" disabled="${!editable}">
                                                <form:option value="" label="--- Backup Room ---"/>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <c:if test="${editable}">
                                        <button type="submit" class="btn btn-primary pull-right">Save changes</button>
                                    </c:if>
                                    <a href="<c:url value="/tutor/lessons"/>" class="btn btn-default pull-right">Go back</a>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- My current bookings -->
        <div class="col-md-12 col-sm-12">
            <div class="box box-primary">
                <div class="box-header with-border row">
                    <h3 class="box-title col-md-1">Bookings</h3>
                </div>
                <div class="box-body">
                    <c:if test="${empty bookings}">
                        <div class="alert alert-warning col-sm-4 col-sm-offset-4">
                            <h4><i class="icon fa fa-frown-o"></i>No bookings</h4>
                            Be patient, students will join...
                        </div>
                    </c:if>
                    <c:if test="${not empty bookings}">
                        <ul class="row users-list">
                            <c:forEach var="student" items="${bookings}">
                                <div class="col-md-2 col-sm-3 col-xs-6">
                                    <li>
                                        <a class="users-list-name"
                                           href="<c:url value="/profile/${student.profileIdentifier}"/>">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <img class="profile-user-img img-circle center-block"
                                                         src="<c:url value="/resources/students/${student.id}/avatar.png"/>"
                                                         alt="User Image">
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="text-center"><span>${student.name}</span></div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </div>
                            </c:forEach>
                        </ul>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>