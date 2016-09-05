<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<sec:authentication var="auth" property="principal"/>

<spring:message code="Review.content" var="mContent"/>
<spring:message code="Review.tutor" var="mTutor"/>
<spring:message code="Review.engagement" var="mEngagement"/>
<spring:message code="Review.ambiance" var="mAmbiance"/>

<spring:message code="Review.closedBookings" var="mClosedBookings"/>
<spring:message code="Review.finishedLesson" var="mFinish"/>

<spring:message code="Actions.loadMore" var="mLoadMore"/>

<div class="row">
    <c:if test="${empty lessonReviews}">
        <div class="alert alert-info col-sm-4 col-sm-offset-4">
            <h4><i class="icon fa fa-info-circle"></i>${mNoClosedBookings}</h4>
                ${mFinish}
        </div>
    </c:if>
    <c:forEach var="lessonReview" items="${lessonReviews}">
        <c:set var="review" value="${lessonReview.review}"/>
        <c:set var="lesson" value="${lessonReview.lesson}"/>
        <div class="review col-md-12">
            <div class="box box-default">
                <div class="box-header with-border">
                    <div class="user-block">
                        <c:choose>
                            <c:when test="${review == null}">
                                <a href="<c:url value="/reviews/${lesson.id}"/>" class="btn btn-default pull-right">
                                    <i class="fa fa-commenting-o"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value="/reviews/${lesson.id}"/>" class="btn btn-default pull-right">
                                    <i class="fa fa-pencil"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <img class="profile-user-img img-responsive img-circle"
                             src="<c:url value="/resources/students/${lesson.tutor.student.id}/avatar.png"/>"
                             alt="User profile picture">
                        <span class="username"><a
                                href="<c:url value="/profile/${lesson.tutor.student.profileIdentifier}"/>">${lesson.tutor.student.name}</a></span>
                        <span class="description">${lesson.course.name} - <fmt:formatDate
                                pattern="hh:mm dd MMMMMMMMM YYYY"
                                value="${lesson.date}"/></span>
                    </div>
                </div>
                <div class="box-body">
                    <!-- post text -->
                    <strong><c:out value="${lesson.name}"/></strong>
                    <p><c:out value="${lesson.description}"/></p>
                </div>
                <c:if test="${review != null}">
                    <div class="box-footer">
                        <div class="row">
                            <div class="col-md-1">
                                <div class="row">
                                    <div class="col-md-offset-2 col-md-10">
                                        <img class="img-responsive img-circle img-sm"
                                             src="<c:url value="/resources/students/${auth.id}/avatar.png"/>"
                                             alt="Avatar">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-11">
                                <!-- .img-push is used to add margin to elements next to floating images -->
                                <div class="img-push row">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <span class="lead"><c:out value="${review.text}"/></span>
                                        </div>
                                        <div class="col-md-3">
                                            <span>${mTutor}: </span>
                                            <div class="rating" data-rating="${review.engagementScore}"></div>
                                        </div>
                                        <div class="col-md-3">
                                            <span>${mEngagement}: </span>
                                            <div class="rating" data-rating="${review.engagementScore}"></div>
                                        </div>
                                        <div class="col-md-3">
                                            <span>${mAmbiance}: </span>
                                            <div class="rating" data-rating="${review.atmosphereScore}"></div>
                                        </div>
                                        <div class="col-md-3">
                                            <span>${mContent}: </span>
                                            <div class="rating" data-rating="${review.contentScore}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
    <c:if test="${not empty lessonReviews}">
        <div class="load-more col-md-12">
            <div class="text-center">
                <button type="button" class="btn btn-default">${mLoadMore}</button>
            </div>
        </div>
    </c:if>
</div>
