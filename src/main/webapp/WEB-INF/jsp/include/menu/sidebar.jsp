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
            <li class="header">MAIN NAVIGATION</li>
            <li class="${param.title == "students" ? "active" : "" }"><a href="<c:url value="/admin/students"/>"><span>Students</span></a></li>
            <li class="${param.title == "courses" ? "active" : "" }"><a href="<c:url value="/admin/courses"/>"><span>Courses</span></a></li>
            <li class="${param.title == "rooms" ? "active" : "" }"><a href="<c:url value="/admin/rooms"/>"><span>Rooms</span></a></li>
        </ul>
    </div>
</aside>