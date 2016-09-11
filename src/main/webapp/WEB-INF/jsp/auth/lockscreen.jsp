<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Login.invalid" var="mInvalid"/>
<spring:message code="Login.unsupported" var="mUnsupported"/>
<spring:message code="Login.failure" var="mFailure"/>
<spring:message code="Login.retrieveSession" var="mRetrieveSession"/>
<spring:message code="Login.diffUser" var="mDiffUser"/>
<spring:message code="Student.password" var="mPassword"/>

<c:choose>
    <c:when test="${error == 'invalid'}">
        <p>${mInvalid}</p>
    </c:when>
    <c:when test="${error == 'unsupported'}">
        <p>${mUnsupported}</p>
    </c:when>
    <c:when test="${error == 'failure'}">
        <p>${mFailure}</p>
    </c:when>
</c:choose>
<div class="lockscreen-name text-center">${user.name}</div>
<div class="lockscreen-item">
    <div class="lockscreen-image">
        <img src="<c:url value="/resources/students/${user.id}/avatar.png"/>" alt="User Image">
    </div>
    <form class="lockscreen-credentials" method="post" action="<c:url value="/auth/checklogin"/>">
        <input type="hidden" name="email" value="${user.email}">
        <div class="input-group">
            <input type="password" name="password" class="form-control" placeholder="${mPassword}">
            <div class="input-group-btn">
                <button type="submit" class="btn"><i class="fa fa-arrow-right text-muted"></i></button>
            </div>
        </div>
    </form>
</div>
<div class="help-block text-center">
    ${mRetrieveSession}
</div>
<div class="text-center">
    <a href="<c:url value="/auth/login"/>?different_user=true">${mDiffUser}</a>
</div>
