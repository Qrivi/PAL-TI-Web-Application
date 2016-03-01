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
                    <tr>
                        <!-- upvotes -->
                        <td><span class="label label-default"><i
                                class="fa fa-thumbs-up"></i> ${other.request.upvotes}</span></td>
                        <!-- title -->
                        <td>${other.request.upvotes.size()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</c:if>