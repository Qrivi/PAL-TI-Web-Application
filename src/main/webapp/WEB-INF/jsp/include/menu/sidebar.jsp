<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- main-sidebar -->
<aside class="main-sidebar">
    <!-- sidebar -->
    <div class="sidebar">
        <!-- user-panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="<c:url value="/resources/img/profile_pic.png"/>" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p><sec:authentication property="principal.name"/></p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- /.user-panel -->
        <!-- sidebar-menu -->
        <ul class="sidebar-menu">
            <li class="header">MAIN NAVIGATION</li>
            <li class="active"><a href="#"><span>Link</span></a></li>
            <li class="treeview">
                <a href="#"><span>Students</span> <i class="fa fa-angle-left pull-right"></i></a>
                <ul class="treeview-menu">
                    <li><a href="<c:url value="/admin/student/add"/>">Add a new student</a></li>
                    <li><a href="<c:url value="/admin/student/overview"/>">Student overview</a></li>
                </ul>
            </li>
        </ul>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
<!-- /.main-sidebar -->