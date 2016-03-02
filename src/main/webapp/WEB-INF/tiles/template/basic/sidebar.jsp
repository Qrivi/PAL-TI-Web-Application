<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<sec:authentication var="auth" property="principal"/>
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
            <li class="header">ADMIN NAVIGATION</li>
            <li class="${nav_item == "students" ? "active" : "" }"><a
                    href="<c:url value="/admin/students"/>"><i class="fa fa-users"></i><span>Students</span></a>
            </li>
            <li class="${nav_item == "courses" ? "active" : "" }"><a
                    href="<c:url value="/admin/courses"/>"><i class="fa fa-book"></i><span>Courses</span></a></li>
            <li class="${nav_item == "rooms" ? "active" : "" }"><a
                    href="<c:url value="/admin/rooms"/>"><i class="fa fa-building"></i><span>Rooms</span></a></li>
            <li class="${nav_item == "applications" ? "active" : "" }"><a
                    href="<c:url value="/admin/applications"/>"><i class="fa fa-file-text"></i><span>Applications</span></a></li>
            <li class="${nav_item == "tutors" ? "active" : "" }"><a
                    href="<c:url value="/admin/tutors"/>"><i class="fa fa-briefcase"></i><span>Tutors</span></a>
            </li>
            <li class="${nav_item == "reviews" ? "active" : "" }"><a
                    href="<c:url value="/admin/reviews"/>"><i class="fa fa-commenting-o"></i><span>Reviews</span></a>
            </li>
            <li class="${nav_item == "requests" ? "active" : ""}"><a
                    href="<c:url value="/admin/requests"/>"><i class="fa fa-question-circle"></i><span>Requests</span></a>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_TUTOR')">
            <li class="header">TUTOR NAVIGATION</li>
            <li class="${nav_item == "tutor_lesson_add" ? "active" : ""}"><a
                    href="<c:url value="/tutor/lessons/add"/>"><i class="fa fa-calendar-plus-o"></i><span>Make a new lesson</span></a>
            </li>
            <li class="${nav_item == "tutor_lessons" ? "active" : ""}"><a
                    href="<c:url value="/tutor/lessons"/>"><i
                    class="fa fa-calendar-o"></i><span>My lessons</span></a>
            </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_USER')">
            <li class="header">MAIN NAVIGATION</li>
            <li class="${nav_item == "profile" ? "active" : "" }"><a
                    href="<c:url value="/profile/${auth.profileIdentifier}"/>"><i class="fa fa-user"></i><span>Profile</span></a>
            </li>
            <li class="${nav_item == "calendar" ? "active" : "" }"><a
                    href="<c:url value="/calendar"/>"><i class="fa fa-calendar"></i><span>Calendar</span></a>
            </li>
            <li class="${nav_item == "booking" ? "active" : "" }"><a
                    href="<c:url value="/booking"/>"><i class="fa fa-pencil-square-o"></i><span>Book a lesson</span></a>
            </li>
            <li class="${nav_item == "request" ? "active" : "" }"><a
                    href="<c:url value="/request"/>"><i class="fa fa-plus-square-o"></i><span>Request a lesson</span></a>
            </li>
            <li class="${nav_item == "apply" ? "active" : "" }"><a
                    href="<c:url value="/apply"/>"><i class="fa fa-check-circle-o"></i><span>Apply for Tutoring</span></a>
            </li>
        </sec:authorize>
    </ul>
</div>