<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.lessons" var="mLessons"/>
<spring:message code="Lesson.name" var="mName"/>
<spring:message code="Lesson.course" var="mCourse"/>
<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.date" var="mDate"/>
<spring:message code="Lesson.duration" var="mDuration"/>
<spring:message code="Lesson.maxParticipants" var="mMaxParticipants"/>
<spring:message code="Lesson.tutor" var="mTutor"/>
<spring:message code="Lesson.room" var="mRoom"/>
<spring:message code="Lesson.backupRoom" var="mBackupRoom"/>
<spring:message code="Lesson.registeredStudents" var="mRegisteredStudents"/>
<spring:message code="Lesson.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mLessons}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOverview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"
                                data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="lesson-overview" class="table table-striped table-bordered"
                                   cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>${mName}</th>
                                    <th>${mCourse}</th>
                                    <th>${mDescription}</th>
                                    <th>${mDate}</th>
                                    <th>${mDuration}</th>
                                    <th>${mMaxParticipants}</th>
                                    <th>${mTutor}</th>
                                    <th>${mRoom}</th>
                                    <th>${mBackupRoom}</th>
                                    <th>${mRegisteredStudents}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mName}</th>
                                    <th>${mCourse}</th>
                                    <th>${mDescription}</th>
                                    <th>${mDate}</th>
                                    <th>${mDuration}</th>
                                    <th>${mMaxParticipants}</th>
                                    <th>${mTutor}</th>
                                    <th>${mRoom}</th>
                                    <th>${mBackupRoom}</th>
                                    <th>${mRegisteredStudents}</th>
                                    <th>${mActions}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="lesson" items="${lessons}">
                                    <tr>
                                        <td>${lesson.name}</td>
                                        <td>${lesson.course.shortName}</td>
                                        <td>${lesson.description}</td>
                                        <td>${lesson.date}</td>
                                        <td><fmt:formatNumber maxFractionDigits="0"
                                                              value="${(lesson.duration-0.5)/60}"/>:<fmt:formatNumber
                                                value="${lesson.duration%60}" type="number" minIntegerDigits="2"/></td>
                                        <td>${lesson.maxParticipants}</td>
                                        <td>${lesson.tutor.student.name}</td>
                                        <td>${lesson.room.name}</td>
                                        <td>${lesson.backupRoom.name}</td>
                                        <td>${lesson.bookings.size()}</td>
                                        <td>
                                            <form action="<c:url value="/admin/lessons" />" method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${lesson.id}"/>
                                                <button class="btn btn-sm" data-toggle="tooltip"
                                                        title="${mDelete}" data-toggle="tooltip">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>