<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<header class="main-header">
    <a href="<c:url value="/"/>" class="logo">
        PAL - TI
    </a>
    <nav class="navbar navbar-static-top" role="navigation">
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="<c:url value="/resources/img/profile_pic.jpg"/>" class="user-image" alt="User Image">
                        <span class="hidden-xs"><sec:authentication property="principal.name"/></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="user-header">
                            <img src="<c:url value="/resources/img/profile_pic.jpg"/>" class="img-circle" alt="User Image">
                            <p>
                                <sec:authentication property="principal.name"/>
                                <small><sec:authentication property="principal.email"/></small>
                            </p>
                        </li>
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="<c:url value="/profile"/>" class="btn btn-default btn-flat">Profile</a>
                            </div>
                            <div class="pull-right" onclick="document.forms['logout'].submit(); return false;">
                                <form id="logout" class="small" action="<c:url value="/auth/logout"/>" method="post">
                                    <a href="#" class="btn btn-default btn-flat">Sign out</a>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>