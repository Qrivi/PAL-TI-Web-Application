<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="main-sidebar">
    <div class="sidebar">
        <div class="user-panel">
            <div class="pull-left image">
                <img src="<c:url value="/resources/img/profile_pic.jpg"/>" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p><sec:authentication property="principal.name"/></p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <ul class="sidebar-menu">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li class="header">ADMIN NAVIGATION</li>
                <li class="${param.title == "students" ? "active" : "" }"><a
                        href="<c:url value="/admin/students"/>"><i class="fa fa-users"></i><span> Students</span></a>
                </li>
                <li class="${param.title == "courses" ? "active" : "" }"><a
                        href="<c:url value="/admin/courses"/>"><i class="fa fa-book"></i><span> Courses</span></a></li>
                <li class="${param.title == "rooms" ? "active" : "" }"><a
                        href="<c:url value="/admin/rooms"/>"><i class="fa fa-building"></i><span> Rooms</span></a></li>
                <li class="${param.title == "applications" ? "active" : "" }"><a
                        href="<c:url value="/admin/applications"/>"><i class="fa fa-file-text"></i><span> Applications</span></a></li>
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_TUTOR')">
                <li class="header">TUTOR NAVIGATION</li>
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_USER')">
                <li class="header">MAIN NAVIGATION</li>
                <li class="${param.title == "dashboard" ? "active" : "" }"><a
                        href="<c:url value="/dashboard"/>"><i class="fa  fa-dashboard"></i><span>Dashboard</span></a>
                </li>
                <li class="${param.title == "apply" ? "active" : "" }"><a
                        href="<c:url value="/apply"/>"><i class="fa fa-check-circle-o"></i><span>Apply as a tutor</span></a>
                </li>
            </sec:authorize>
        </ul>
    </div>
</aside>