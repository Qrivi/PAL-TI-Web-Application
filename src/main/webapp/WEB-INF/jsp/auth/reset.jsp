<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<spring:message code="Login.emailInstructions" var="mEmailInstructions"/>
<spring:message code="Login.goBackLogin" var="mGoBackLogin"/>

<spring:message code="Actions.send" var="mSend"/>

<div class="login-box-body">
    <p class="login-box-msg">${mEmailInstructions}</p>
    <form:form method="post" commandName="resetRequest"
               accept-charset="UTF-8"
               enctype="application/x-www-form-urlencoded">
        <c:set var="emailError"><form:errors path="email"/></c:set>
        <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
            <form:errors path="email" element="label"/>
            <form:input path="email" class="form-control" placeholder="Email" required="required"/>
            <span class="glyphicon glyphicon-envelope  form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-4 col-xs-offset-8">
                <button type="submit" class="btn btn-primary btn-block btn-flat">${mSend}</button>
            </div>
        </div>
    </form:form>
    <a href="<c:url value="/auth/login"/>" class="text-center">${mGoBackLogin}</a>
</div>