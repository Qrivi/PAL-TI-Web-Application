<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Course.courses" var="mCourses"/>
<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.lessons" var="mLessons"/>
<spring:message code="Lesson.noLessons" var="mNoLessons"/>
<spring:message code="Lesson.name" var="mName"/>
<spring:message code="Lesson.course" var="mCourse"/>
<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.date" var="mDate"/>
<spring:message code="Lesson.duration" var="mDuration"/>
<spring:message code="Lesson.participants" var="mParticipants"/>
<spring:message code="Lesson.tutor" var="mTutor"/>
<spring:message code="Tutor.tutors" var="mTutors"/>
<spring:message code="Lesson.room" var="mRoom"/>
<spring:message code="Lesson.backupRoom" var="mBackupRoom"/>
<spring:message code="Lesson.booking" var="mBooking"/>
<spring:message code="Lesson.myBookings" var="mMyBookings"/>
<spring:message code="Lesson.noBookings" var="mNoBookings"/>
<spring:message code="Lesson.noRegister" var="mNoRegister"/>
<spring:message code="Lesson.register" var="mRegister"/>
<spring:message code="Lesson.registered" var="mRegistered"/>
<spring:message code="Lesson.unregister" var="mUnregister"/>
<spring:message code="Lesson.unregistered" var="mUnregistered"/>
<spring:message code="Lesson.noLessonsAvailable" var="mNoLessonsAvailable"/>
<spring:message code="Lesson.notification" var="mNotification"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mBookings}
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <!-- My current bookings -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${mMyBookings}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" title="${mCollapse}"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <c:if test="${empty myOpenBookings}">
                            <div class="alert alert-warning col-sm-4 col-sm-offset-4">
                                <h4><i class="icon fa fa-frown-o"></i>${mNoBookings}</h4>
                                    ${mNoRegister}
                            </div>
                        </c:if>
                        <c:if test="${not empty myOpenBookings}">
                            <c:forEach var="booking" items="${myOpenBookings}">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="info-box bg-gray">
                                        <div class="pull-right">
                                            <form action="<c:url value="/booking/unregister/${booking.id}" />"
                                                  method="POST">
                                                <button class="btn btn-flat btn-danger"><i
                                                        class="fa fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                        <a href="<c:url value="/profile/${booking.tutor.student.profileIdentifier}"/>" alt="Tutor info">
                                                    <span class="info-box-icon">
                                                        <img class="img-circle"
                                                             src="<c:url value="/resources/students/${booking.tutor.student.id}/avatar.png"/>"
                                                             alt="Tutor profile picture" style="padding:10px;">
                                                    </span>
                                        </a>
                                        <div class="info-box-content">
                                            <span class="info-box-text">${booking.course.shortName}</span>
                                            <span class="info-box-text">${booking.name}</span>
                                                <span class="info-box-text"><fmt:formatDate pattern="EEE. dd/MM hh:mm"
                                                                                            value="${booking.date}"/> - ${booking.room.name}</span>
                                            <div class="progress">
                                                <div class="progress-bar"
                                                     style="width: ${booking.bookings.size()/booking.maxParticipants*100}%"></div>
                                            </div>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                    <!-- /.info-box -->
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <!-- Open lessons table -->
            <div class="box box-default">
                <div class="box-header with-border">
                    <h3 class="box-title">${mLessons}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" title="${mCollapse}"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <c:if test="${empty lessons}">
                            <div class="alert alert-warning col-sm-4 col-sm-offset-4">
                                <h4><i class="icon fa fa-frown-o"></i>${mNoLessons}</h4>
                                <p>${mNoLessonsAvailable}</p>
                                <p>${mNotification}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty lessons}">
                            <div class="col-sm-12">
                                <table id="lessons-overview" class="table table-striped table-bordered"
                                       cellspacing="0"
                                       width="100%">
                                    <thead>
                                        <tr>
                                            <th>${mName}</th>
                                            <th>${mCourse}</th>
                                            <th>${mDate}</th>
                                            <th>${mDuration}</th>
                                            <th>${mParticipants}</th>
                                            <th>${mTutor}</th>
                                            <th data-orderable="false">${mActions}</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>${mName}</th>
                                            <th>${mCourse}</th>
                                            <th>${mDate}</th>
                                            <th>${mDuration}</th>
                                            <th>${mParticipants}</th>
                                            <th>${mTutor}</th>
                                            <th>${mActions}</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach var="lesson" items="${lessons}">
                                            <tr>
                                                <td>${lesson.name}</td>
                                                <td>${lesson.course.name}</td>
                                                <td>${lesson.date}</td>
                                                <td><fmt:formatNumber maxFractionDigits="0" value="${(lesson.duration-0.5)/60}"/>:<fmt:formatNumber value="${lesson.duration%60}" type="number" minIntegerDigits="2"/></td>
                                                <td>
                                                    <div class="progress progress-xs">
                                                        <div class="progress-bar
                                                            <c:set var="percentage" value="${lesson.bookings.size()/lesson.maxParticipants*100}"/>
                                                            <c:choose>
                                                                <c:when test="${percentage < 60}">progress-bar-success</c:when>
                                                                <c:when test="${percentage > 60 and percentage < 100}">progress-bar-warning</c:when>
                                                                <c:when test="${percentage == 100}">progress-bar-danger</c:when>
                                                            </c:choose>"
                                                             style="width: ${lesson.bookings.size()/lesson.maxParticipants*100}%"></div>
                                                    </div>
                                                        ${lesson.bookings.size()}/${lesson.maxParticipants}
                                                </td>
                                                <td>${lesson.tutor.student.name}</td>
                                                <td>
                                                    <c:if test="${percentage < 100 and not myOpenBookings.contains(lesson)}">
                                                        <form action="<c:url value="/booking/register/${lesson.id}" />"
                                                              method="POST">
                                                            <button type="submit"
                                                                    class="btn btn-success btn-sm" data-toggle="tooltip"
                                                                    title="${mRegister}">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${myOpenBookings.contains(lesson)}">
                                                        <form action="<c:url value="/booking/unregister/${lesson.id}" />"
                                                              method="POST">
                                                            <button class="btn btn-danger btn-sm" data-toggle="tooltip"
                                                                    title="${mUnregister}">
                                                                <i class="fa fa-trash"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
