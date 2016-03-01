<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row">
    <c:if test="${empty lessonReviews}">
        <div class="alert alert-info col-sm-4 col-sm-offset-4">
            <h4><i class="icon fa fa-info-circle"></i>No closed bookings</h4>
            Once you've finished a lesson, you will be able to post a review
            here.
        </div>
    </c:if>
    <c:forEach var="lessonReview" items="${lessonReviews}">
        <div class="col-md-12">
            <div class="box box-default">
                <div class="box-header with-border">
                    <div class="user-block">
                        <c:choose>
                            <c:when test="${lessonReview.review == null}">
                                <a href="<c:url value="/reviews/${lessonReview.lesson.id}"/>" class="btn btn-default pull-right">
                                    <i class="fa fa-commenting-o"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value="/reviews/${lessonReview.lesson.id}"/>" class="btn btn-default pull-right">
                                    <i class="fa fa-pencil"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <img class="profile-user-img img-responsive img-circle"
                             src="<c:url value="/resources/students/${lessonReview.lesson.tutor.student.id}/avatar.png"/>"
                             alt="User profile picture">
                        <span class="username"><a
                                href="<c:url value="/profile/${lessonReview.lesson.tutor.student.profileIdentifier}"/>">${lessonReview.lesson.tutor.student.name}</a></span>
                        <span class="description">${lessonReview.lesson.course.name} - <fmt:formatDate
                                pattern="HH:mm dd MMMMMMMMM YYYY"
                                value="${lessonReview.lesson.date}"/> </span>
                    </div>
                </div>
                <div class="box-body">
                    <!-- post text -->
                    <strong>${lessonReview.lesson.name}</strong>
                    <p>${lessonReview.lesson.description}</p>
                </div>
                <div class="box-footer">
                    <div class="row">
                        <div class="col-md-1">
                            <div class="row">
                                <div class="col-md-offset-2 col-md-10">
                                    <img class="img-responsive img-circle img-sm"
                                         src="<c:url value="/resources/students/${student.id}/avatar.png"/>"
                                         alt="Alt Text">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-11">
                            <!-- .img-push is used to add margin to elements next to floating images -->
                            <div class="img-push row">
                                <div class="row">
                                    <div class="col-md-12">
                                        <!--todo add scores -->
                                            ${lessonReview.review.text}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>