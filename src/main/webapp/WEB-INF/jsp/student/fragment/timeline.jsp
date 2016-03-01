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

<c:forEach var="archivable" items="${timeline.archivables}">
    <li class="time-label">
        <span class="bg-red">
            <fmt:formatDate pattern="dd MMM. YYYY"
                            value="${archivable.getArchiveDate()}"/>
        </span>
    </li>
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
                    <h3 class="timeline-header">Went to <c:out
                            value="${archivable.name}"/></h3>
                    <div class="timeline-body">
                        <div class="row">
                            <!-- lesson name -->
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="small-box bg-purple">
                                    <div class="inner">
                                        <h3>Course</h3>
                                        <p><c:out
                                                value="${archivable.course.name}"/></p>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-book"></i>
                                    </div>
                                </div>
                            </div>
                            <!-- tutor -->
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="small-box bg-blue">
                                    <div class="inner">
                                        <h3>Tutor</h3>
                                        <p><c:out
                                                value="${archivable.tutor.student.name}"/></p>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-user"></i>
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
                <!-- Is a Lesson object -->
                <i class="fa fa-star bg-blue"></i>
                <div class="timeline-item">
                    <span class="time">
                        <i class="fa fa-clock-o"></i>
                        <fmt:formatDate pattern="hh:mm"
                                        value="${archivable.getArchiveDate()}"/>
                    </span>
                    <h3 class="timeline-header">Gave a review to <c:out
                            value="${archivable.lesson.tutor.student.name}"/></h3>
                    <div class="timeline-body">
                        <div class="row">
                            <!-- description -->
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <p><c:out value="${archivable.text}"/></p>
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