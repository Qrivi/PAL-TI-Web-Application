<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL"
       value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>

<spring:message code="Review.review" var="mReview"/>
<spring:message code="Review.courseS" var="mCourseS"/>
<spring:message code="Review.content" var="mContent"/>
<spring:message code="Review.contentScore" var="mContentScore"/>
<spring:message code="Review.tutor" var="mTutor"/>
<spring:message code="Review.tutorScore" var="mTutorScore"/>
<spring:message code="Review.engagement" var="mEngagement"/>
<spring:message code="Review.engagementScore" var="mEngagementScore"/>
<spring:message code="Review.ambiance" var="mAmbiance"/>
<spring:message code="Review.ambianceScore" var="mAmbienceScore"/>
<spring:message code="Review.comment" var="mComment"/>
<spring:message code="Review.anonymous" var="mAnonymous"/>
<spring:message code="Review.postAnonymous" var="mPostAnonymous"/>
<spring:message code="Review.post" var="mPost"/>

<spring:message code="Lesson.description" var="mDescription"/>
<spring:message code="Lesson.lesson" var="mLesson"/>

<spring:message code="Course.course" var="mCourse"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mReview}
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <!-- lesson info -->
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${lesson.name}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- tutor info panel -->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-8 col-sm-8 col-xs-8">
                                            <h4>${mTutor}</h4>
                                            <ul>
                                                <li>${lesson.tutor.student.name}</li>
                                                <li>${lesson.tutor.courses.size()}${' '}${mCourseS}</li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4 col-sm-4 col-xs-4 pull-right">
                                            <a href="<c:url value="/profile/${lesson.tutor.student.profileIdentifier}"/>"
                                               alt="Tutor info">
                                                <img class="img-responsive img-circle"
                                                     src="<c:url value="/resources/students/${lesson.tutor.student.id}/avatar.png"/>"
                                                     alt="Tutor profile picture"
                                                     style="padding:10px;max-width: 80px; max-height: 80px;">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- course info panel -->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>${mCourse}</h4>
                                    <ul>
                                        <li>${lesson.course.code} - ${lesson.course.name}</li>
                                        <li>${lesson.course.curriculum} - ${lesson.course.year}e</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Lesson info panel -->
                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="pull-right">
                                        <span class="label label-primary"><fmt:formatDate value="${lesson.date}"
                                                                                          pattern="hh:mm dd MMMMMMMMM YYYY"/> - ${lesson.duration}min.</span>
                                    </div>
                                    <h4>${mLesson}</h4>
                                    <ul>
                                        <li>${lesson.name}</li>
                                        <li>${lesson.room.name}, ${lesson.room.campus}
                                            or ${lesson.backupRoom.name}, ${lesson.backupRoom.campus}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Lesson description panel -->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>${mDescription}</h4>
                                    <p><c:out value="${lesson.description}"/></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <!-- review form -->
        <div class="col-md-12">
            <div class="box box-primary">
                <form:form method="post" commandName="review"
                           accept-charset="UTF-8"
                           enctype="application/x-www-form-urlencoded">
                    <c:set var="contentScoreError"><form:errors path="contentScore"/></c:set>
                    <c:set var="engagementScoreError"><form:errors path="engagementScore"/></c:set>
                    <c:set var="atmosphereScoreError"><form:errors path="atmosphereScore"/></c:set>
                    <c:set var="tutorScoreError"><form:errors path="tutorScore"/></c:set>
                    <c:set var="textError"><form:errors path="text"/></c:set>
                    <div class="box-body">
                        <div class="row">
                            <!-- contentScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">${mContent}</span>
                                <div class="form-group ${ not empty contentScoreError ? 'has-error' : ''}">
                                    <form:errors path="contentScore" element="label"/>
                                    <div id="contentScore"></div>
                                    <form:input id="contentScoreInput" type="hidden" min="1" max="10"
                                                path="contentScore" class="form-control"
                                                placeholder="${mContentScore}"/>
                                </div>
                            </div>
                            <!-- engagementScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">${mEngagement}</span>
                                <div class="form-group ${ not empty engagementScoreError ? 'has-error' : ''}">
                                    <form:errors path="engagementScore" element="label"/>
                                    <div id="engagementScore"></div>
                                    <form:input id="engagementScoreInput" type="hidden" min="1" max="10"
                                                path="engagementScore" class="form-control rateYo"
                                                placeholder="${mEngagementScore}"/>
                                </div>
                            </div>
                            <!-- AtmosphereScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">${mAmbiance}</span>
                                <div class="form-group ${ not empty atmosphereScoreError ? 'has-error' : ''}">
                                    <form:errors path="atmosphereScore" element="label"/>
                                    <div id="atmosphereScore"></div>
                                    <form:input id="atmosphereScoreInput" type="hidden" min="1" max="10"
                                                path="atmosphereScore" class="form-control rateYo"
                                                placeholder="${mAmbienceScore}"/>
                                </div>
                            </div>
                            <!-- tutorScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">${mTutor}</span>
                                <div class="form-group ${ not empty tutorScoreError ? 'has-error' : ''}">
                                    <form:errors path="tutorScore" element="label"/>
                                    <div id="tutorScore"></div>
                                    <form:input id="tutorScoreInput" type="hidden" min="1" max="10" path="tutorScore"
                                                class="form-control rateYo" placeholder="${mTutorScore}"/>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group ${ not empty textError ? 'has-error' : ''}">
                                    <form:errors path="text" element="label"/>
                                    <form:textarea id="review_text" path="text" maxlength="140" minlength="10"
                                                   class="form-control" placeholder="${mComment}"/>
                                    <div id="review_text_feedback" class="label label-default"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group no-margin">
                                    <div class="checkbox icheck">
                                        <label>
                                            <form:checkbox path="${mAnonymous}" class="form-control "
                                                           placeholder="${mAnonymous}"/> <span>${mPostAnonymous}</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-offset-8 col-md-1">
                                <div class="form-group pull-right no-margin">
                                    <button id="submitReview" type="submit"
                                            class="btn btn-default pull-right">${mPost}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-footer-->
                </form:form>
            </div>
        </div>
    </div>
</section>
