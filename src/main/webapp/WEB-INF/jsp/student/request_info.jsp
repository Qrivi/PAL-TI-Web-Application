<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="auth" property="principal"/>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL"
       value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>

<section class="content-header">
    <h1>
        Request Info
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-default">
                <div class="box-header with-border">
                    <h3 class="box-title">Request</h3>
                    <div class="pull-right">
                        <c:choose>
                            <c:when test="${requested.upvotes.contains(auth)}">
                                <form action="<c:url value="/request/undovote/${requested.id}" />"
                                      method="POST">
                                    <button type="submit"
                                            class="btn btn-danger btn-sm" data-toggle="tooltip" title="Undo upvote">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="<c:url value="/request/upvote/${requested.id}" />"
                                      method="POST">
                                    <button type="submit"
                                            class="btn btn-success btn-sm" data-toggle="tooltip" title="Upvote">
                                        <i class="fa fa-thumbs-up"></i>
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Course</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${requested.title}</td>
                                <td>${requested.course.code}/${requested.course.name}</td>
                                <td>${requested.description}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="panel no-margin">
                        <div class="panel-heading">
                            <h4 class="box-title">Up-votes</h4>
                            <span class="label label-default"><i
                                    class="fa fa-thumbs-up"></i> ${requested.upvotes.size()}</span>
                        </div>
                        <div class="panel-body">
                            <c:if test="${empty requested.upvotes}">
                                <div class="alert alert-info col-sm-4 col-sm-offset-4">
                                    <h4><i class="icon fa fa-frown-o"></i>No upvotes</h4>
                                    This request doesn't have any up-votes yet.
                                </div>
                            </c:if>
                            <c:if test="${not empty requested.upvotes}">
                                <ul class="row users-list">
                                    <c:forEach var="student" items="${requested.upvotes}">
                                        <div class="col-md-2 col-sm-3 col-xs-6">
                                            <li>
                                                <a class="users-list-name"
                                                   href="<c:url value="/profile/${student.profileIdentifier}"/>">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <img class="profile-user-img img-circle center-block"
                                                                 src="<c:url value="/resources/students/${student.id}/avatar.png"/>"
                                                                 alt="User Image">
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="text-center"><span>${student.name}</span></div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                        </div>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
