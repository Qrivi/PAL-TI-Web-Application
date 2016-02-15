<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <body>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">Username and password are incorrect!</div>
        </c:if>
        <form class="form-horizontal" method="post" action="checklogin">
            <fieldset>
                <legend>Login</legend>
                <div class="form-group">
                    <label for="email" class="col-lg-2 control-label">Email</label>
                    <div class="col-lg-10">
                        <input type="email" name="email" class="form-control" id="email" placeholder="Email" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-lg-2 control-label">Password</label>
                    <div class="col-lg-10">
                        <input type="password" name="password" class="form-control" id="password" placeholder="Password" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-6">
                        <div class="checkbox pull-left">
                            <label>
                                <input type="checkbox" id="remember"> Remember email?
                            </label>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <button type="submit" class="btn btn-default btn-raised pull-right">Login</button>
                    </div>
                </div>
            </fieldset>
        </form>
    </body>
</html>
