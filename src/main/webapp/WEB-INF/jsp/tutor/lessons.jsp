<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.name" var="mName"/>
<spring:message code="Lesson.course" var="mCourse"/>
<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.date" var="mDate"/>
<spring:message code="Lesson.duration" var="mDuration"/>
<spring:message code="Lesson.participants" var="mParticipants"/>
<spring:message code="Lesson.tutor" var="mTutor"/>
<spring:message code="Lesson.room" var="mRoom"/>
<spring:message code="Lesson.backupRoom" var="mBackupRoom"/>
<spring:message code="Lesson.registeredStudents" var="mRegisteredStudents"/>
<spring:message code="Lesson.myLessons" var="mMyLessons"/>
<spring:message code="Lesson.myUpcomingLessons" var="mMyUpcomingLessons"/>
<spring:message code="Lesson.noLessons" var="mNoLessons"/>
<spring:message code="Lesson.noLessonsToGive" var="mNoLessonsToGive"/>
<spring:message code="Lesson.noLessonsGiven" var="mNoLessonsGiven"/>
<spring:message code="Lesson.history" var="mHistory"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>
<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.infoFor" var="mInfoFor"/>

<section class="content-header">
    <h1>
        ${mMyLessons}
    </h1>
</section>
<!-- main content -->
<section class="content container-box">
    <div class="row">
        <!-- My upcoming lessons -->
        <div class="col-md-12 col-sm-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${mMyUpcomingLessons}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" title="${mCollapse}"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <c:if test="${empty myUpcomingLessons}">
                            <div class="alert alert-info col-sm-4 col-sm-offset-4">
                                <h4><i class="icon fa fa-info"></i>${mNoLessons}</h4>
                                    ${mNoLessonsToGive}
                            </div>
                        </c:if>
                        <c:if test="${not empty myUpcomingLessons}">
                            <c:forEach var="lesson" items="${myUpcomingLessons}">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="info-box bg-blue-gradient">
                                        <div class="pull-right">
                                            <form action="<c:url value="/tutor/lessons/remove" />" method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${lesson.id}"/>
                                                <button class="btn btn-flat btn-danger"><i
                                                        class="fa fa-trash"></i></button>
                                            </form>
                                        </div>
                                        <a href="<c:url value="/tutor/lessons/edit/${lesson.id}"/>"
                                           style="cursor:pointer;" alt="${mEdit}${' '}${lesson.name}">
                                            <i class="info-box-icon fa fa-edit"></i>
                                        </a>
                                        <div class="info-box-content">
                                            <span class="info-box-text">${lesson.course.shortName}</span>
                                            <span class="info-box-text"><c:out value="${lesson.name}"/></span>
                                            <span class="info-box-text">
                                                                <fmt:formatDate pattern="EEE. dd/MM hh:mm"
                                                                                value="${lesson.date}"/> - ${lesson.room.name}
                                                            </span>
                                            <div class="progress">
                                                <div class="progress-bar"
                                                     style="width: ${lesson.bookings.size()/lesson.maxParticipants*100}%"></div>
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
        <!-- My lesson history -->
        <div class="col-md-12 col-sm-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${mHistory}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" title="${mCollapse}"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <c:if test="${empty myPastLessons}">
                            <div class="alert alert-info col-sm-4 col-sm-offset-4">
                                <h4><i class="icon fa fa-info"></i>${mNoLessons}</h4>
                                    ${mNoLessonsGiven}
                            </div>
                        </c:if>
                        <c:if test="${not empty myPastLessons}">
                            <div class="col-sm-12">
                                <table id="lesson-history-overview" class="table table-striped table-bordered"
                                       cellspacing="0" width="100%">
                                    <thead>
                                    <tr>
                                        <th>${mName}</th>
                                        <th>${mDate}</th>
                                        <th>${mDuration}</th>
                                        <th>${mCourse}</th>
                                        <th>${mParticipants}</th>
                                        <th>${mRoom}</th>
                                        <th>${mBackupRoom}</th>
                                        <th>${mActions}</th>
                                    </tr>
                                    </thead>
                                    <tfoot>
                                    <tr>
                                        <th>${mName}</th>
                                        <th>${mDate}</th>
                                        <th>${mDuration}</th>
                                        <th>${mCourse}</th>
                                        <th>${mParticipants}</th>
                                        <th>${mRoom}</th>
                                        <th>${mBackupRoom}</th>
                                        <th>${mActions}</th>
                                    </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach var="lesson" items="${myPastLessons}">
                                        <tr>
                                            <td>${lesson.name}</td>
                                            <td><fmt:formatDate pattern="EEE. dd/MM/YYYY hh:mm"
                                                                value="${lesson.date}"/></td>
                                            <td><fmt:formatNumber maxFractionDigits="0"
                                                                  value="${(lesson.duration-0.5)/60}"/>:<fmt:formatNumber
                                                    value="${lesson.duration%60}" type="number"
                                                    minIntegerDigits="2"/></td>
                                            <td>${lesson.course.name}</td>
                                            <td>
                                                <div class="progress progress-xs">
                                                    <div class="progress-bar
                                                                        <c:set var="percentage" value="${lesson.bookings.size()/lesson.maxParticipants*100}"/>
                                                                            <c:choose>
                                                                                <c:when test="${percentage < 60}">progress-bar-success</c:when>
                                                                                <c:when test="${percentage > 60 and percentage < 100}">progress-bar-warning</c:when>
                                                                                <c:when test="${percentage == 100}">progress-bar-danger</c:when>
                                                                            </c:choose>"
                                                         style="width: ${lesson.bookings.size()/lesson.maxParticipants*100}%">
                                                    </div>
                                                </div>
                                                    ${lesson.bookings.size()}/${lesson.maxParticipants}</td>
                                            <td>${lesson.room.name}</td>
                                            <td>${lesson.backupRoom.name}</td>
                                            <td>
                                                <a class="btn btn-sm btn-default"
                                                   href="<c:url value="/tutor/lessons/info/${lesson.id}"/>"
                                                   alt="${mInfoFor}${' '}${lesson.name}">
                                                    <i class="fa fa-info"></i>
                                                </a>
                                                <c:if test="${lesson.bookings.size() < 1}">
                                                    <a class="btn btn-sm btn-default"
                                                       href="<c:url value="/tutor/lessons/edit/${lesson.id}"/>"
                                                       alt="${mEdit}${' '}${lesson.name}">
                                                        <i class="fa fa-pencil"></i>
                                                    </a>
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

