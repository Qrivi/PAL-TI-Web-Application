<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Review.review" var="mRewiew"/>
<spring:message code="Review.reviews" var="mReviews"/>
<spring:message code="Review.lesson" var="mLesson"/>
<spring:message code="Review.date" var="mDate"/>
<spring:message code="Review.student" var="mStudent"/>
<spring:message code="Review.contentScore" var="mContentScore"/>
<spring:message code="Review.tutorScore" var="mTutorScore"/>
<spring:message code="Review.engagementScore" var="mEngagementScore"/>
<spring:message code="Review.ambianceScore" var="mAmbianceScore"/>
<spring:message code="Review.comment" var="mComment"/>
<spring:message code="Review.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mReviews}
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
                            <table id="review-overview" class="table table-striped table-bordered" cellspacing="0"
                                   width="100%">
                                <thead>
                                <tr>
                                    <th>${mLesson}</th>
                                    <th>${mDate}</th>
                                    <th>${mStudent}</th>
                                    <th>${mContentScore}</th>
                                    <th>${mTutorScore}</th>
                                    <th>${mEngagementScore}</th>
                                    <th>${mAmbianceScore}</th>
                                    <th>${mComment}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mLesson}</th>
                                    <th>${mDate}</th>
                                    <th>${mStudent}</th>
                                    <th>${mContentScore}</th>
                                    <th>${mTutorScore}</th>
                                    <th>${mEngagementScore}</th>
                                    <th>${mAmbianceScore}</th>
                                    <th>${mComment}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="review" items="${reviews}">
                                    <tr>
                                        <td>${review.lesson.name}</td>
                                        <td>${review.date}</td>
                                        <td>${review.student.name}</td>
                                        <td>${review.contentScore}</td>
                                        <td>${review.tutorScore}</td>
                                        <td>${review.engagementScore}</td>
                                        <td>${review.atmosphereScore}</td>
                                        <td>${review.text}</td>
                                        <td>
                                            <form class="small" action="<c:url value="/admin/reviews" />"
                                                  method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${review.id}"/>
                                                <button class="btn btn-sm"><i class="fa fa-trash" data-toggle="tooltip"
                                                                              title="${mDelete}"></i>
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