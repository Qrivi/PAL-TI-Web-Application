<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<sec:authentication var="auth" property="principal"/>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Navigation.admin" var="mNavAdmin"/>
<spring:message code="Navigation.tutor" var="mNavTutor"/>
<spring:message code="Navigation.main" var="mNavMain"/>

<spring:message code="Student.students" var="mStudents"/>
<spring:message code="Course.courses" var="mCourses"/>
<spring:message code="Room.rooms" var="mRooms"/>
<spring:message code="Application.applications" var="mApplications"/>
<spring:message code="Lesson.lessons" var="mLessons"/>
<spring:message code="Tutor.tutors" var="mTutors"/>
<spring:message code="Review.reviews" var="mReviews"/>
<spring:message code="Request.requests" var="mRequests"/>
<spring:message code="Calendar.calendar" var="mCalendar"/>
<spring:message code="Lesson.makeLesson" var="mMakeLesson"/>
<spring:message code="Profile.profile" var="mProfile"/>
<spring:message code="Lesson.myLessons" var="mMyLessons"/>
<spring:message code="Request.requestLesson" var="mRequestLesson"/>
<spring:message code="Lesson.bookLesson" var="mBookLesson"/>
<spring:message code="Application.applyForTutoring" var="mApplyForTutoring"/>
<spring:message code="Calendar.byCalendar" var="mByCalendar"/>
<spring:message code="Table.byTable" var="mByTable"/>

<tiles:importAttribute name="nav_item"/>
<div class="sidebar">
    <div class="user-panel">
        <div class="pull-left image">
            <img src="<c:url value="/resources/students/${auth.id}/avatar.png"/>" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
            <p>${auth.name}</p>
            <a href="#"><i class="fa fa-circle text-success"></i>Online</a>
        </div>
    </div>
    <ul class="sidebar-menu">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="header">${mNavAdmin}</li>
            <li class="${nav_item == "students" ? "active" : "" }"><a
                    href="<c:url value="/admin/students"/>"><i class="fa fa-users"></i><span>${mStudents}</span></a>
            </li>
            <li class="${nav_item == "courses" ? "active" : "" }"><a
                    href="<c:url value="/admin/courses"/>"><i class="fa fa-book"></i><span>${mCourses}</span></a></li>
            <li class="${nav_item == "rooms" ? "active" : "" }"><a
                    href="<c:url value="/admin/rooms"/>"><i class="fa fa-building"></i><span>${mRooms}</span></a></li>
            <li class="${nav_item == "applications" ? "active" : "" }"><a
                    href="<c:url value="/admin/applications"/>"><i
                    class="fa fa-file-text"></i><span>${mApplications}</span>
                <small id="application-count" class="label pull-right bg-red"></small>
            </a></li>
            <li class="${nav_item == "lessons" ? "active" : "" }"><a
                    href="<c:url value="/admin/lessons"/>"><i class="fa fa-book"></i><span>${mLessons}</span></a>
            </li>
            <li class="${nav_item == "tutors" ? "active" : "" }"><a
                    href="<c:url value="/admin/tutors"/>"><i class="fa fa-briefcase"></i><span>${mTutors}</span></a>
            </li>
            <li class="${nav_item == "reviews" ? "active" : "" }"><a
                    href="<c:url value="/admin/reviews"/>"><i
                    class="fa fa-commenting-o"></i><span>${mReviews}</span></a>
            </li>
            <li class="${nav_item == "requests" ? "active" : ""}"><a
                    href="<c:url value="/admin/requests"/>"><i
                    class="fa fa-question-circle"></i><span>${mRequests}</span></a>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_TUTOR')">
            <li class="header">${mNavTutor}</li>
            <li class="${nav_item == "tutor_lesson_add" ? "active" : ""}"><a
                    href="<c:url value="/tutor/lessons/add"/>"><i
                    class="fa fa-calendar-plus-o"></i><span>${mMakeLesson}</span></a>
            </li>
            <li class="${nav_item == "tutor_lessons" ? "active" : ""}"><a
                    href="<c:url value="/tutor/lessons"/>"><i
                    class="fa fa-calendar-o"></i><span>${mMyLessons}</span></a>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_USER')">
            <li class="header">${mNavMain}</li>
            <li class="${nav_item == "profile" ? "active" : "" }"><a
                    href="<c:url value="/profile/${auth.profileIdentifier}"/>"><i
                    class="fa fa-user"></i><span>${mProfile}</span></a>
            </li>
            <li class="${nav_item == "calendar" ? "active" : "" }"><a
                    href="<c:url value="/calendar"/>"><i class="fa fa-calendar"></i><span>${mCalendar}</span></a>
            </li>

            <li class="treeview ${fn:substring(nav_item, 0, 7) == "booking" ? "active" : "" }">
                <a href="#">
                    <i class="fa fa fa-pencil-square-o"></i> <span>${mBookLesson}</span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li class="${nav_item == "booking_table" ? "active" : "" }"><a
                            href="<c:url value="/booking/table"/>"><i
                            class="fa fa-th-list"></i>${mByTable}</a></li>
                    <li class="${nav_item == "booking_calendar" ? "active" : "" }"><a
                            href="<c:url value="/booking/calendar"/>"><i
                            class="fa fa-calendar"></i>${mByCalendar}</a></li>
                </ul>
            </li>
            <li class="${nav_item == "request" ? "active" : "" }"><a
                    href="<c:url value="/request"/>"><i
                    class="fa fa-plus-square-o"></i><span>${mRequestLesson}</span></a>
            </li>
            <li class="${nav_item == "apply" ? "active" : "" }"><a
                    href="<c:url value="/apply"/>"><i class="fa fa-check-circle-o"></i><span>${mApplyForTutoring}</span></a>
            </li>
        </sec:authorize>
    </ul>
</div>