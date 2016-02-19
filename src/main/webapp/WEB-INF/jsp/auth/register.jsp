<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Register" name="title"/>
    </jsp:include>
    <body class="hold-transition login-page">
        <div class="register-box">
            <div class="register-logo">
                <a href="<c:url value="/"/>"><b>PAL - TI</b></a>
            </div>
            <div class="register-box-body">
                <p class="login-box-msg">Register a new membership</p>
                <form:form method="post" commandName="register" enctype="application/x-www-form-urlencoded">
                    <c:set var="nameError"><form:errors path="name"/></c:set>
                    <c:set var="emailError"><form:errors path="email"/></c:set>
                    <c:set var="passwordError"><form:errors path="password"/></c:set>
                    <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
                    <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                        <form:errors path="name" element="label"/>
                        <form:input path="name" class="form-control" placeholder="Name"/>
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                        <form:errors path="email" element="label"/>
                        <form:input path="email" class="form-control" placeholder="Email"/>
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>
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
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                        </div>
                    </div>
                </form:form>

                <a href="<c:url value="/auth/login"/>" class="text-center">I already have a membership</a>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
    </body>
</html>
