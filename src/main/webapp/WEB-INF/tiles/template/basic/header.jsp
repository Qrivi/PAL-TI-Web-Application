<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<sec:authentication var="auth" property="principal"/>

<spring:message code="Profile.profile" var="mProfile"/>
<spring:message code="Actions.signOut" var="mSignOut"/>

<header class="main-header">
    <a href="<c:url value="/"/>" class="logo">
        PAL
    </a>
    <nav class="navbar navbar-static-top" role="navigation">
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </a>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li><a href="?lang=en">en</a></li>
                <li><a href="?lang=nl">nl</a></li>
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="<c:url value="/resources/students/${auth.id}/avatar.png"/>" class="user-image"
                             alt="User Image">
                        <span class="hidden-xs">${auth.name}</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="user-header">
                            <img src="<c:url value="/resources/students/${auth.id}/avatar.png"/>" class="img-circle"
                                 alt="User Image">
                            <p>
                                ${auth.name}
                                <small>${auth.email}</small>
                            </p>
                        </li>
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="<c:url value="/profile/${auth.profileIdentifier}"/>"
                                   class="btn btn-default btn-flat">${mProfile}</a>
                            </div>
                            <div class="pull-right" onclick="document.forms['logout'].submit(); return false;">
                                <form id="logout" class="small" action="<c:url value="/auth/logout"/>" method="post">
                                    <a href="#" class="btn btn-default btn-flat">${mSignOut}</a>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>