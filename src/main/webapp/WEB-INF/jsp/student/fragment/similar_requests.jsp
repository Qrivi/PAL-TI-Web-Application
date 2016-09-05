<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty similar}">
    <table class="table table-striped">
        <tbody>
            <c:forEach var="other" items="${similar}">
                <tr>
                    <!-- upvotes -->
                    <td class="col-md-1 col-sm-2 text-center"><span class="label label-default"><i class="fa fa-thumbs-up"></i> ${other.request.upvotes.size()}</span></td>
                    <!-- title -->
                    <td class="col-md-4 col-sm-3 text-left">${other.request.title}</td>
                    <td class="col-md-6 col-sm-5 text-left">${other.request.description}</td>
                    <td class="col-md-1 col-sm-2 text-right">
                        <a href="<c:url value="/request/${other.request.id}"/>" class="btn btn-sm btn-info pull-right"><i class="fa fa-info"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>