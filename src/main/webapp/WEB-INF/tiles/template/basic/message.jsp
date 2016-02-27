<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty message}">
    <div class="callout callout-<c:out value="${message.type}"/> lead">
        <p>
            <c:out value="${message.message}"/>
        </p>
    </div>
</c:if>