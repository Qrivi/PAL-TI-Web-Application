<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.lessons" var="mLessons"/>
<spring:message code="Lesson.name" var="mName"/>
<spring:message code="Lesson.course" var="mCourse"/>
<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.date" var="mDate"/>
<spring:message code="Lesson.dateTime" var="mDateTime"/>
<spring:message code="Lesson.duration" var="mDuration"/>
<spring:message code="Lesson.maxParticipants" var="mMaxParticipants"/>
<spring:message code="Lesson.tutor" var="mTutor"/>
<spring:message code="Lesson.room" var="mRoom"/>
<spring:message code="Lesson.backupRoom" var="mBackupRoom"/>
<spring:message code="Lesson.request" var="mRequest"/>
<spring:message code="Lesson.bookings" var="mBookings"/>
<spring:message code="Lesson.noBookings" var="mNoBookings"/>
<spring:message code="Lesson.patient" var="mPatient"/>

<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.saveChanges" var="mSaveChanges"/>
<spring:message code="Actions.goBack" var="mGoBack"/>

<section class="content-header">
    <h1>
        ${mLesson}${' '}"${lesson.name}"
    </h1>
</section>
<!-- main content -->
<section class="content container-box">
    <div class="row">
        <!-- edit form -->
        <div class="col-md-12 col-sm-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${mEdit}${' '}${mLesson}</h3>
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
                                            <form:label path="name">${mName} : <c:if test="${not empty nameError}"><span
                                                    class="text-danger">${nameError}</span></c:if></form:label>
                                            <form:input path="name" class="form-control" placeholder="${mName}"/>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-feedback">
                                            <form:label path="request">${mRequest} : </form:label>
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
                                        <form:label path="date">${mDateTime} : <c:if
                                                test="${not empty dateError}"><span
                                                class="text-danger">${dateError}</span></c:if></form:label>
                                        <div class="form-group has-feedback">
                                            <div class="input-group date" id="datetimepicker">
                                                <form:input path="date" type="text" class="form-control"
                                                            placeholder="${mDate}" disabled="${!editable}"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="course">${mCourse} : <c:if
                                                    test="${not empty courseError}"><span
                                                    class="text-danger">${courseError}</span></c:if></form:label>
                                            <form:select path="course" class="form-control"
                                                         placeholder="${mCourse}" disabled="${!editable}">
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
                                            <form:label path="maxParticipants">${mMaxParticipants} :
                                                <c:if test="${not empty maxParticipantsError}"><span
                                                        class="text-danger">${maxParticipantsError}</span></c:if></form:label>
                                            <form:input path="maxParticipants" type="number" min="1"
                                                        class="form-control"
                                                        placeholder="${mMaxParticipants}" disabled="${!editable}"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="duration">${mDuration} : <c:if
                                                    test="${not empty durationError}"><span
                                                    class="text-danger">${durationError}</span></c:if></form:label>
                                            <form:input path="duration" type="time" class="form-control"
                                                        placeholder="${mDuration}" disabled="${!editable}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <form:label path="room">${mRoom} : <c:if
                                                    test="${not empty roomError}"><span
                                                    class="text-danger">${roomError}</span></c:if></form:label>
                                            <form:select path="room" class="form-control" placeholder="${mRoom}"
                                                         disabled="${!editable}">
                                                <form:option value="" label="--- ${Room} ---"/>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <div class="col-md-6">
                                            <form:label path="backupRoom">${BackupRoom} :
                                                <c:if test="${not empty backupRoomError}">
                                                    <span
                                                            class="text-danger">${backupRoomError}
                                                    </span>
                                                </c:if>
                                            </form:label>
                                            <form:select path="backupRoom" class="form-control" disabled="${!editable}">
                                                <form:option value="" label="--- ${mBackupRoom} ---"/>
                                                <form:options items="${rooms}" itemValue="id" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <c:if test="${editable}">
                                        <button type="submit"
                                                class="btn btn-prima}ry pull-right">${mSaveChanges}</button>
                                    </c:if>
                                    <a href="<c:url value="/tutor/lessons"/>"
                                       class="btn btn-default pull-right">${mGoBack}</a>
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
                    <h3 class="box-title col-md-1">${mBookings}</h3>
                </div>
                <div class="box-body">
                    <c:if test="${empty bookings}">
                        <div class="alert alert-warning col-sm-4 col-sm-offset-4">
                            <h4><i class="icon fa fa-frown-o"></i>${mNoBookings}</h4>
                                ${mPatient}
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