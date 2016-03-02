<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="auth" property="principal"/>
<div class="row">
    <c:if test="${empty reviews}">
        <div class="alert alert-info col-sm-4 col-sm-offset-4">
            <h4><i class="icon fa fa-info-circle"></i>No closed bookings</h4>
            Once you've finished a lesson, you will be able to post a review
            here.
        </div>
    </c:if>
    <c:forEach var="review" items="${reviews}">
        <c:set var="lesson" value="${review.lesson}"/>
        <div class="col-md-12">
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
                                        <!--todo add scores -->
                                        <c:out value="${review.text}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${not empty reviews}">
        <div class="load-more col-md-12">
            <div class="text-center">
                <button type="button" class="btn btn-default">Load More</button>
            </div>
        </div>
    </c:if>
</div>