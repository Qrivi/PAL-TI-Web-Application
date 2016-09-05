<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="previous" value=""/>

<spring:message code="Timeline.info" var="mTimelineInfo"/>
<spring:message code="Timeline.show" var="mShow"/>
<spring:message code="Timeline.gaveLesson" var="mGaveLesson"/>
<spring:message code="Timeline.wentToLesson" var="mWentToLesson"/>
<spring:message code="Timeline.receivedReviewFor" var="mReceivedReviewFor"/>
<spring:message code="Timeline.gaveReviewFor" var="mGaveReviewFor"/>

<spring:message code="Review.content" var="mContent"/>
<spring:message code="Review.tutor" var="mTutor"/>
<spring:message code="Review.engagement" var="mEngagement"/>
<spring:message code="Review.ambiance" var="mAmbiance"/>

<spring:message code="Course.course" var="mCourse"/>
<spring:message code="Course.courses" var="mCourses"/>
<spring:message code="Lesson.lesson" var="mLesson"/>
<spring:message code="Lesson.participants" var="mParticipants"/>
<spring:message code="Lesson.minutes" var="mMinutes"/>
<spring:message code="Tutor.tutor" var="mTutor"/>

<spring:message code="Actions.loadMore" var="mLoadMore"/>

<c:if test="${empty timeline.archivables}">
    <!-- Empty Timeline -->
    <li>
        <i class="fa fa-info bg-gray"></i>
        <div class="timeline-item">
            <h3 class="timeline-header">${mTimelineInfo}</h3>
            <div class="timeline-body"><p>${mShow}</p></div>
        </div>
    </li>
</c:if>
<c:forEach var="archivable" items="${timeline.archivables}" varStatus="status">
    <c:choose>
        <c:when test="${archivable.class.simpleName == 'Lesson'}">
            <fmt:formatDate var="current" pattern="dd MMM. YYYY"
                            value="${archivable.getArchiveDate()}"/>
            <c:if test="${!previous.equals(current)}">
                <li class="time-label">
                    <span class="bg-red"><c:out value="${current}"/></span>
                </li>
            </c:if>
            <c:set var="previous" value="${current}"/>
            <li>
                <!-- Is a Lesson object -->
                <i class="fa fa-calendar-check-o bg-blue"></i>
                <div class="timeline-item">
                    <span class="time">
                        <i class="fa fa-clock-o"></i>
                        <fmt:formatDate pattern="hh:mm"
                                        value="${archivable.getArchiveDate()}"/>
                    </span>
                    <h3 class="timeline-header">
                        <c:choose>
                            <c:when test="${archivable.tutor.student == student}">
                                <div class="label label-success">${mGaveLesson}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="label label-primary">${mWentToLesson}</div>
                            </c:otherwise>
                        </c:choose>
                        <c:out value=" ${archivable.name}"/>
                    </h3>
                    <div class="timeline-body">
                        <div class="row">
                            <!-- course info -->
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="panel panel-default bg-purple-gradient">
                                    <div class="panel-body">
                                        <strong>${mCourse}</strong>
                                        <ul class="list-unstyled">
                                            <li>${archivable.course.code}/${archivable.course.name}</li>
                                            <li>${archivable.course.curriculum} - ${archivable.course.year}e</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- lesson info -->
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="panel panel-default bg-purple-gradient">
                                    <div class="panel-body">
                                        <strong>${mLesson}</strong>
                                        <ul class="list-unstyled">
                                            <li>${archivable.room.campus}
                                                - ${archivable.room.name}, ${archivable.backupRoom.campus}
                                                - ${archivable.backupRoom.name}</li>
                                            <li>${archivable.duration}${' '}${mMinutes}
                                                - ${archivable.bookings.size()}${' '}${mParticipants}
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- tutor info -->
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="panel panel-default bg-purple-gradient">
                                    <div class="panel-body row">
                                        <div class="col-md-8">
                                            <strong>${mTutor}</strong>
                                            <ul class="list-unstyled">
                                                <li>${archivable.tutor.student.name}</li>
                                                <li>${archivable.tutor.courses.size()}${mCourses}</li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="pull-right">
                                                <a href="<c:url value="/profile/${archivable.tutor.student.profileIdentifier}"/>">
                                                    <img class="user-img img-responsive img-circle"
                                                         src="<c:url value="/resources/students/${archivable.tutor.student.id}/avatar.png"/>"
                                                         alt="User profile picture"
                                                         style="max-width: 32px;max-height: 32px;">
                                                </a>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                            <!-- description -->
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <p><c:out
                                        value="${archivable.description}"/></p>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:when>
        <c:when test="${archivable.class.simpleName == 'Review'}">
            <fmt:formatDate var="current" pattern="dd MMM. YYYY"
                            value="${archivable.getArchiveDate()}"/>
            <c:if test="${!previous.equals(current)}">
                <li class="time-label">
                    <span class="bg-red"><c:out value="${current}"/></span>
                </li>
            </c:if>
            <c:set var="previous" value="${current}"/>
            <li>
                <!-- Is a Review object -->
                <i class="fa fa-star bg-blue"></i>
                <div class="timeline-item">
                    <span class="time">
                        <i class="fa fa-clock-o"></i>
                        <fmt:formatDate pattern="hh:mm"
                                        value="${archivable.getArchiveDate()}"/>
                    </span>
                    <h3 class="timeline-header">
                        <c:choose>
                            <c:when test="${archivable.lesson.tutor.student == student}">
                                <div class="label label-success">${mReceivedReviewFor}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="label label-primary">${mGaveReviewFor}</div>
                            </c:otherwise>
                        </c:choose>
                        <c:out value="${archivable.lesson.name}"/>
                    </h3>
                    <div class="timeline-body">
                        <div class="row">
                            <!-- description -->
                            <div class="col-md-12">
                                <blockquote>
                                    <p><c:out value="${archivable.text}"/></p>
                                    <small>${archivable.anonymous ? 'anonymous' : archivable.student.name} </small>
                                </blockquote>
                            </div>
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-3">
                                        <span>${mTutor}: </span>
                                        <div class="rating" data-rating="${archivable.engagementScore}"></div>
                                    </div>
                                    <div class="col-md-3">
                                        <span>${mEngagement}: </span>
                                        <div class="rating" data-rating="${archivable.engagementScore}"></div>
                                    </div>
                                    <div class="col-md-3">
                                        <span>${mAmbiance}: </span>
                                        <div class="rating" data-rating="${archivable.atmosphereScore}"></div>
                                    </div>
                                    <div class="col-md-3">
                                        <span>${mContent}: </span>
                                        <div class="rating" data-rating="${archivable.contentScore}"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:when>
    </c:choose>
</c:forEach>
<c:if test="${not empty timeline.archivables}">
    <li class="load-more">
        <div class="text-center">
            <button type="button" class="btn btn-default">${mLoadMore}</button>
        </div>
    </li>
</c:if>