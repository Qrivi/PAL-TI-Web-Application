<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Login.registerMembership" var="mRegisterMembership"/>
<spring:message code="Login.register" var="mRegister"/>
<spring:message code="Login.alreadyMembership" var="mAlreadyMembership"/>

<spring:message code="Student.name" var="mName"/>
<spring:message code="Student.email" var="mEmail"/>
<spring:message code="Student.password" var="mPassword"/>
<spring:message code="Student.repeatPassword" var="mRepeatPassword"/>
<spring:message code="Student.curriculum" var="mCurriculum"/>

<div class="login-box-body">
    <p class="login-box-msg">${mRegisterMembership}</p>
    <form:form method="post" commandName="register"
               accept-charset="UTF-8"
               enctype="application/x-www-form-urlencoded">
        <c:set var="nameError"><form:errors path="name"/></c:set>
        <c:set var="emailError"><form:errors path="email"/></c:set>
        <c:set var="passwordError"><form:errors path="password"/></c:set>
        <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
        <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
        <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
            <form:errors path="name" element="label"/>
            <form:input path="name" class="form-control" placeholder="${mName}"/>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
            <form:errors path="email" element="label"/>
            <form:input path="email" class="form-control" placeholder="${mEmail}"/>
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
            <form:errors path="password" element="label"/>
            <form:password path="password" class="form-control" placeholder="${mPassword}"/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
            <form:errors path="repeatPassword" element="label"/>
            <form:password path="repeatPassword" class="form-control" placeholder="${mRepeatPassword}"/>
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
            <form:errors path="curriculum" element="label"/>
            <form:select path="curriculum" class="form-control">
                <form:option value="None" label="${mCurriculum}"/>
                <form:options items="${curriculums}"/>
            </form:select>
        </div>
        <div class="row">
            <div class="col-xs-4 col-xs-offset-8">
                <button type="submit" class="btn btn-primary btn-block btn-flat">${mRegister}</button>
            </div>
        </div>
    </form:form>
    <a href="<c:url value="/auth/login"/>" class="text-center">${mAlreadyMembership}</a>
</div>