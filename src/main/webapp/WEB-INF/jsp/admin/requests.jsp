<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Request.requests" var="mRequests"/>
<spring:message code="Request.title" var="mTitle"/>
<spring:message code="Request.course" var="mCourse"/>
<spring:message code="Request.student" var="mStudent"/>
<spring:message code="Request.description" var="mDescription"/>
<spring:message code="Request.creationDate" var="mCreationDate"/>
<spring:message code="Request.upvotes" var="mUpvotes"/>
<spring:message code="Request.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mRequests}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOverview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="request-overview" class="table table-striped table-bordered" cellspacing="0"
                                   width="100%">
                                <thead>
                                <tr>
                                    <th>${mTitle}</th>
                                    <th>${mCourse}</th>
                                    <th>${mStudent}</th>
                                    <th>${mDescription}</th>
                                    <th>${mCreationDate}</th>
                                    <th>${mUpvotes}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mTitle}</th>
                                    <th>${mCourse}</th>
                                    <th>${mStudent}</th>
                                    <th>${mDescription}</th>
                                    <th>${mCreationDate}</th>
                                    <th>${mUpvotes}</th>
                                    <th>${mActions}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="request" items="${requests}">
                                    <tr>
                                        <td>${request.title}</td>
                                        <td>${request.course.name}</td>
                                        <td>${request.student.name}</td>
                                        <td>${request.description}</td>
                                        <td>${request.creationDate}</td>
                                        <td>${request.upvotes.size()}</td>
                                        <td>
                                            <form class="small" action="<c:url value="/admin/requests" />"
                                                  method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${request.id}"/>
                                                <button class="btn btn-sm" data-toggle="tooltip" title="${mDelete}">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>