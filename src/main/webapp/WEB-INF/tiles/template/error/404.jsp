<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="headline text-yellow"> 404</h2>
<div class="error-content">
    <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>
    <p>
        We could not find the page you were looking for.
        Meanwhile, you may <a href="<c:url value="/profile"/>">return to your profile</a> or <a href="<c:url value="/auth/login"/>">return to the login</a>.
    </p>
</div>