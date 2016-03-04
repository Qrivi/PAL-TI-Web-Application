<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Login.incorrect" var="mIncorrect"/>
<spring:message code="Login.sign" var="mSign"/>
<spring:message code="Login.signIn" var="mSignIn"/>
<spring:message code="Login.rememberMe" var="mRememberMe"/>
<spring:message code="Login.forgotPassword" var="mForgotPassword"/>
<spring:message code="Login.register" var="mRegister"/>

<spring:message code="Student.email" var="mEmail"/>
<spring:message code="Student.password" var="mPassword"/>

<c:if test="${not empty error}">
    <div class="callout callout-danger lead">
        <p>${mIncorrect}</p>
    </div>
</c:if>
<div class="login-box-body">
    <p class="login-box-msg">${mSign}</p>
    <form method="post" action="<c:url value="/auth/checklogin"/>">
        <div class="form-group has-feedback">
            <input id="email" type="email" name="email" class="form-control" placeholder="${mEmail}" required>
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
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
    <a href="<c:url value="/auth/reset"/>">${mForgotPassword}</a><br>
    <a href="<c:url value="/auth/register"/>" class="text-center">${mRegister}</a>
</div>