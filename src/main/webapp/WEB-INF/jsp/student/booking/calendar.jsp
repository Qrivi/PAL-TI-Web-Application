<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<spring:message code="Course.courses" var="mCourses"/>
<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.lessons" var="mLessons"/>
<spring:message code="Lesson.name" var="mName"/>
<spring:message code="Lesson.course" var="mCourse"/>
<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.date" var="mDate"/>
<spring:message code="Lesson.duration" var="mDuration"/>
<spring:message code="Lesson.maxParticipants" var="mMaxParticipants"/>
<spring:message code="Lesson.tutor" var="mTutor"/>
<spring:message code="Tutor.tutors" var="mTutors"/>
<spring:message code="Lesson.room" var="mRoom"/>
<spring:message code="Lesson.backupRoom" var="mBackupRoom"/>
<spring:message code="Lesson.booking" var="mBooking"/>
<spring:message code="Lesson.register" var="mRegister"/>
<spring:message code="Lesson.registered" var="mRegistered"/>
<spring:message code="Lesson.unregister" var="mUnregister"/>
<spring:message code="Lesson.unregistered" var="mUnregistered"/>
<spring:message code="Lesson.legend" var="mLegend"/>
<spring:message code="Lesson.result" var="mResult"/>

<spring:message code="Actions.close" var="mClose"/>

<section class="content">
    <div class="row">
        <div class="col-md-3">
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h4 class="box-title">${mFilter}</h4>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="course">${mCourses} :</label>
                            <select id="course" class="form-control select2 select2-hidden-accessible" multiple="multiple"
                                    data-placeholder="${mCourses}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                <option value="">--- ${mCourse} ---</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.id}">${course.shortName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <label for="tutors">${mTutors} :</label>
                            <div id="tutors"></div>
                        </div>
                        <div class="col-md-12">
                            <span id="results">0</span> ${mResult}
                        </div>
                    </div>
                </div>
            </div>
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h4 class="box-title">${mLegend}</h4>
                </div>
                <div class="box-body">
                    <div id="external-events">
                        <div class="bg-green legend-item">${mRegistered}</div>
                        <div class="bg-light-blue legend-item">${mUnregistered}</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="box box-primary no-margin">
                <div class="box-body no-padding">
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal" id="booking-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 id="booking-title" class="modal-title">${mBooking}</h4>
            </div>
            <div class="modal-body">
                <p id="booking-description"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">${mClose}</button>
                <button id="booking-unregister" type="button" class="btn btn-primary" data-dismiss="modal">${mUnregister}</button>
                <button id="booking-register" type="button" class="btn btn-primary" data-dismiss="modal">${mRegister}</button>
            </div>
        </div>
    </div>
</div>
