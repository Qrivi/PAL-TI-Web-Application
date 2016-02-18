<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Login" name="title"/>
    </jsp:include>
    <body>
        <body class="hold-transition login-page">
            <div class="login-box">
                <div class="login-logo">
                    <a href="<c:url value="/"/>"><b>PAL - TI</b></a>
                </div>
                <c:if test="${not empty error}">
                    <div class="callout callout-danger lead">
                        <p>
                            Username and password are incorrect!
                        </p>
                    </div>
                </c:if>
                <div class="login-box-body">
                    <p class="login-box-msg">Sign in to start your session</p>
                    <form method="post" action="checklogin">
                        <div class="form-group has-feedback">
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="row">
                            <div class="col-xs-8">
                                <div class="checkbox icheck">
                                    <label>
                                        <input type="checkbox"> Remember Me
                                    </label>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                            </div>
                        </div>
                    </form>
                    <a href="<c:url value="/auth/reset"/>">I forgot my password</a><br>
                    <a href="<c:url value="/auth/register"/>" class="text-center">Register a new membership</a>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp">
                <jsp:param value="Login" name="title"/>
            </jsp:include>
        </body>
</html>
