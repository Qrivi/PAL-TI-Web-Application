<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Reset Password" name="title"/>
    </jsp:include>
    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="login-logo">
                <a href="<c:url value="/"/>"><img src="<c:url value="/resources/img/logo.png"/>" width="100%"/></a>
            </div>
            <jsp:include page="../include/util/generic_message.jsp"/>
            <div class="login-box-body">
                <p class="login-box-msg">Enter your registered email address and we will send instructions to help you.</p>
                <form:form method="post" commandName="resetRequest" enctype="application/x-www-form-urlencoded">
                    <c:set var="emailError"><form:errors path="email"/></c:set>
                    <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                        <form:errors path="email" element="label"/>
                        <form:input path="email" class="form-control" placeholder="Email" required="required"/>
                        <span class="glyphicon glyphicon-envelope  form-control-feedback"></span>
                    </div>
                    <div class="row">
                        <div class="col-xs-4 col-xs-offset-8">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Send</button>
                        </div>
                    </div>
                </form:form>
                <a href="<c:url value="/auth/login"/>" class="text-center">Go back to the login page</a>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
    </body>
</html>
