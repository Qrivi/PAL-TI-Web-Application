<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Empty Timeline -->
<c:if test="${empty timeline.archivables}">
    <li>
        <i class="fa fa-info bg-gray"></i>
        <div class="timeline-item">
            <h3 class="timeline-header">Timeline info</h3>
            <div class="timeline-body"><p>This page will show you your history,
                This doesn't only contains all the lessons you went to but also
                contains all the reviews you've posted.</p></div>
        </div>
        </i>
    </li>
</c:if>

<c:forEach var="archivable" items="${timeline.archivables}" varStatus="status">
    <c:if test="${not empty previous || status.index == 0}">
        <fmt:formatDate var="current" pattern="dd MMM. YYYY"
                        value="${archivable.getArchiveDate()}"/>
        <c:if test="${!previous.equals(current)}">
            <li class="time-label">
                <span class="bg-red">${current}</span>
            </li>
        </c:if>
        <c:set var="previous" value="${current}"/>
    </c:if>
    <li>
        <c:choose>
            <c:when test="${archivable.class.simpleName == 'Lesson'}">
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
                                <div class="label label-success">Gave lesson</div>
                            </c:when>
                            <c:otherwise>
                                <div class="label label-primary">Went to lesson</div>
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
                                        <strong>Course</strong>
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
                                        <strong>Lesson</strong>
                                        <ul class="list-unstyled">
                                            <li>${archivable.room.campus}
                                                - ${archivable.room.name}, ${archivable.backupRoom.campus}
                                                - ${archivable.backupRoom.name}</li>
                                            <li>${archivable.duration} minutes - ${archivable.bookings.size()}
                                                participants
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
                                            <strong>Tutor</strong>
                                            <ul class="list-unstyled">
                                                <li>${archivable.tutor.student.name}</li>
                                                <li>${archivable.tutor.courses.size()} courses</li>
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
            </c:when>
            <c:when test="${archivable.class.simpleName == 'Review'}">
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
                                <div class="label label-success">Received review for</div>
                            </c:when>
                            <c:otherwise>
                                <div class="label label-primary">Gave review for</div>
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
                                    <div class="col-md-4">
                                        <span>Tutor: </span>
                                    </div>
                                    <div class="col-md-4">
                                        <span>Engagement: </span>
                                    </div>
                                    <div class="col-md-4">
                                        <span>Atmosphere: </span>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>
    </li>
</c:forEach>
<!-- End timeline items -->
<li><i class="fa fa-clock-o bg-gray"></i></li>