<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<spring:message code="Login.enterNewPassword" var="mEnter"/>
<spring:message code="Login.goBackLogin" var="mGoBackLogin"/>

<spring:message code="Actions.send" var="mSend"/>

<div class="login-box-body">
    <p class="login-box-msg">${mEnter}</p>
    <form:form method="post" commandName="reset"
               accept-charset="UTF-8"
               enctype="application/x-www-form-urlencoded">
        <c:set var="passwordError"><form:errors path="password"/></c:set>
        <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
        <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
            <form:errors path="password" element="label"/>
            <form:password path="password" class="form-control" placeholder="Password"/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
            <form:errors path="repeatPassword" element="label"/>
            <form:password path="repeatPassword" class="form-control" placeholder="Repeat Password"/>
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-4 col-xs-offset-8">
                <button type="submit" class="btn btn-primary btn-block btn-flat">${mSend}</button>
            </div>
        </div>
    </form:form>
    <a href="<c:url value="/auth/login"/>" class="text-center">${mGoBackLogin}</a>
</div>
