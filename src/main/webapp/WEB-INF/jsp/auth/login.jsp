<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Login.invalid" var="mInvalid"/>
<spring:message code="Login.unsupported" var="mUnsupported"/>
<spring:message code="Login.failure" var="mFailure"/>
<spring:message code="Login.sign" var="mSign"/>
<spring:message code="Login.signIn" var="mSignIn"/>
<spring:message code="Login.rememberMe" var="mRememberMe"/>

<spring:message code="Student.studentId" var="mStudentId"/>
<spring:message code="Student.password" var="mPassword"/>

<c:if test="${not empty error}">
    <div class="callout callout-danger lead">
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
    </div>
</c:if>
<div class="login-box-body">
    <p class="login-box-msg">${mSign}</p>
    <form method="post">
        <div class="form-group has-feedback">
            <input id="studentId" type="text" name="studentId" class="form-control" placeholder="${mStudentId}"
                   value="${studentId}" required>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" name="password" class="form-control" placeholder="${mPassword}" required>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-8">
                <div class="checkbox icheck">
                    <label>
                        <input type="checkbox" id="remember-me"> <span>${mRememberMe}</span>
                    </label>
                </div>
            </div>
            <div class="col-xs-4">
                <button type="submit" class="btn btn-primary btn-block btn-flat">${mSignIn}</button>
            </div>
        </div>
    </form>
</div>