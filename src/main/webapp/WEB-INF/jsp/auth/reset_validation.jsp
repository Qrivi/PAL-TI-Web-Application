<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/generic_message.jsp"/>
<form:form method="post" commandName="reset" enctype="application/x-www-form-urlencoded">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:password path="password" class="form-control" placeholder="Password"/>
    </div>
    <div class="form-group">
        <form:password path="repeatPassword" class="form-control" placeholder="Repeat Password"/>
    </div>
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Reset</button>
    </div>
</form:form>

