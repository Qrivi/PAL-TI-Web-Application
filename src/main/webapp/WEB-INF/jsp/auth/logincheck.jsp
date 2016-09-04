<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Login.sign" var="mSign"/>
<spring:message code="Login.signIn" var="mSignIn"/>
<spring:message code="Error.no-js" var="mNoJS"/>

<!--noscript-->
    <div class="login-box-body">
        <p class="login-box-msg">${mSign}</p>
        <form method="post" action="<c:url value="/auth/checklogin"/>">
            <div class="form-group has-feedback">
                <input type="hidden" name="email" value="${email}">
                <input type="hidden" name="password" value="${password}">
                ${mNoJS}
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        &nbsp;
                    </div>
                </div>
                <div class="col-xs-4">
                    <button type="submit" id="signinbtn" class="btn btn-primary btn-block btn-flat">${mSignIn}</button>
                </div>
            </div>
        </form>
    </div>
<!--/noscript-->
<script>
    document.getElementById('signinbtn').click();
</script>