<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty similar}">
    <div class="panel panel-info">
        <div class="panel-heading">
            Existing requests
        </div>
        <div class="panel-body table-responsive no-padding">
            <table class="table table-hover">
                <tbody>
                <c:forEach var="other" items="${similar}">
                    <tr data-toggle="tooltip" title="${other.request.description}">
                        <!-- upvotes -->
                        <td><span class="label label-default"><i
                                class="fa fa-thumbs-up"></i> ${other.request.upvotes.size()}</span></td>
                        <!-- title -->
                        <td>${other.request.title}</td>
                        <td>
                            <a href="/request/${other.request.id}" class="btn btn-info"><i class="fa fa-info"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</c:if>