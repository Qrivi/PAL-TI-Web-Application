<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<h2 class="headline text-red">500</h2>

<spring:message code="Error.500-1" var="m1"/>
<spring:message code="Error.500-2" var="m2"/>
<spring:message code="Error.3" var="m3"/>
<spring:message code="Error.4" var="m4"/>
<spring:message code="Error.5" var="m5"/>
<spring:message code="Error.6" var="m6"/>

<div class="error-content">
    <h3><i class="fa fa-warning text-red"></i> ${m1}</h3>
    <p>
        ${m2}${' '}
        ${m3}<a href="<c:url value="/profile"/>"> ${m4}</a> ${m5} <a href="<c:url value="/auth/login"/>"> ${m6}</a>.
    </p>
</div>