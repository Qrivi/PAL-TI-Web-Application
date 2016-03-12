<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<sec:authentication var="auth" property="principal"/>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL"
       value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>

<spring:message code="Request.request" var="mRequest"/>
<spring:message code="Request.allRequests" var="mAllRequests"/>
<spring:message code="Request.newRequest" var="mNewRequest"/>
<spring:message code="Request.lessonRequest" var="mLessonRequest"/>
<spring:message code="Request.title" var="mTitle"/>
<spring:message code="Request.course" var="mCourse"/>
<spring:message code="Request.description" var="mDescription"/>
<spring:message code="Request.upvote" var="mUpvote"/>
<spring:message code="Request.upvotes" var="mUpvotes"/>
<spring:message code="Request.undoUpvote" var="mUndoUpvote"/>
<spring:message code="Request.noUpvotes" var="mNoUpvotes"/>
<spring:message code="Request.noUpvotesYet" var="mNoUpvotesYet"/>

<spring:message code="Actions.info" var="mInfo"/>

<section class="content-header">
    <h1>
        ${mRequest}${' '}${mInfo}
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-default">
                <div class="box-header with-border">
                    <h3 class="box-title">${mRequest}</h3>
                    <div class="pull-right">
                        <c:choose>
                            <c:when test="${requested.upvotes.contains(auth)}">
                                <form action="<c:url value="/request/undovote/${requested.id}" />"
                                      method="POST">
                                    <button type="submit"
                                            class="btn btn-danger btn-sm" data-toggle="tooltip" title="${mUndoUpvote}">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="<c:url value="/request/upvote/${requested.id}" />"
                                      method="POST">
                                    <button type="submit"
                                            class="btn btn-success btn-sm" data-toggle="tooltip" title="${mUpvote}">
                                        <i class="fa fa-thumbs-up"></i>
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <div class="row">
                        <div class="col-md-12">
                            <c:if test="${requested.lesson != null}">
                                <div class="col-md-12">
                                    <div class="info-box bg-gray">
                                        <div class="pull-right">
                                            <c:if test="${lessonIsUpcomming}">
                                                <c:choose>
                                                    <c:when test="${!isBooked}">
                                                        <form action="<c:url value="/booking/register/${requested.lesson.id}" />"
                                                              method="POST">
                                                            <button class="btn btn-flat btn-success"><i
                                                                    class="fa fa-plus"></i></button>
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="<c:url value="/booking/unregister/${requested.lesson.id}" />"
                                                              method="POST">
                                                            <button class="btn btn-flat btn-danger"><i
                                                                    class="fa fa-trash"></i></button>
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </div>
                                        <a href="<c:url value="/profile/${requested.lesson.tutor.student.profileIdentifier}"/>"
                                           alt="Tutor info">
                                                    <span class="info-box-icon">
                                                        <img class="img-circle"
                                                             src="<c:url value="/resources/students/${requested.lesson.tutor.student.id}/avatar.png"/>"
                                                             alt="Tutor profile picture" style="padding:10px;">
                                                    </span>
                                        </a>
                                        <div class="info-box-content">
                                            <span class="info-box-text">${requested.lesson.course.shortName}</span>
                                            <span class="info-box-text">${requested.lesson.name}</span>
                                                <span class="info-box-text"><fmt:formatDate pattern="EEE. dd/MM hh:mm"
                                                                                            value="${requested.lesson.date}"/> - ${requested.lesson.room.name}</span>
                                            <div class="progress">
                                                <div class="progress-bar"
                                                     style="width: ${requested.lesson.bookings.size()/requested.lesson.maxParticipants*100}%"></div>
                                            </div>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>${mTitle}</th>
                                    <th>${mCourse}</th>
                                    <th>${mDescription}</th>
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
                        </div>
                        <div class="col-md-12">
                            <div class="panel no-margin">
                                <div class="panel-heading">
                                    <h4 class="box-title">${mUpvotes}</h4>
                            <span class="label label-default"><i
                                    class="fa fa-thumbs-up"></i> ${requested.upvotes.size()}</span>
                                </div>
                                <div class="panel-body">
                                    <c:if test="${empty requested.upvotes}">
                                        <div class="alert alert-info col-sm-4 col-sm-offset-4">
                                            <h4><i class="icon fa fa-frown-o"></i>${mNoUpvotes}</h4>
                                                ${mNoUpvotesYet}
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
                                                                    <div class="text-center">
                                                                        <span>${student.name}</span></div>
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
        </div>
    </div>
</section>
