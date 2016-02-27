<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty error}">
    <div class="callout callout-danger lead">
        <p>Username and password are incorrect!</p>
    </div>
</c:if>
<div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>
    <form method="post" action="<c:url value="/auth/checklogin"/>">
        <div class="form-group has-feedback">
            <input id="email" type="email" name="email" class="form-control" placeholder="Email" required>
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
                        <input type="checkbox" id="remember-me"> <span>Remember Me</span>
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