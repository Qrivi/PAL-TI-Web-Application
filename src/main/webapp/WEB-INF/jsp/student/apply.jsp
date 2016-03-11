<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<spring:message code="Application.application" var="mApplication"/>
<spring:message code="Application.applyForTutoring" var="mApplyForTutoring"/>
<spring:message code="Application.submit" var="mSubmit"/>
<spring:message code="Application.course" var="mCourse"/>
<spring:message code="Application.screenshot" var="mScreenshot"/>
<spring:message code="Application.onlyApply" var="mOnlyApply"/>
<spring:message code="Application.mostSubscribedCourses" var="mMostSubscribedCourses"/>
<spring:message code="Application.yourApplications" var="mYourApplications"/>
<spring:message code="Application.startDate" var="mStartDate"/>
<spring:message code="Application.endDate" var="mEndDate"/>
<spring:message code="Application.status" var="mStatus"/>

<spring:message code="Course.code" var="mCode"/>
<spring:message code="Course.name" var="mName"/>
<spring:message code="Course.subscribers" var="mSubscribers"/>

<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mApplyForTutoring}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${mSubmitYourApplication}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="post" commandName="tutorApply" enctype="multipart/form-data">
                                <c:set var="courseError"><form:errors path="course"/></c:set>
                                <c:set var="screenshotError"><form:errors path="screenshot"/></c:set>
                                <div class="form-group has-feedback ${ not empty courseError ? 'has-error' : ''}">
                                    <form:label path="course">${mCourse} : <c:if test="${not empty courseError}"><span
                                            class="text-danger">${courseError}</span></c:if></form:label>
                                    <form:select path="course" class="form-control select2 select2-hidden-accessible"
                                                 data-placeholder="Course" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <form:option value="" label="--- Course ---"/>
                                        <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty screenshotError ? 'has-error' : ''}">
                                    <form:label path="screenshot">${mScreenshot} : <c:if
                                            test="${not empty screenshotError}"><span
                                            class="text-danger">${screenshotError}</span></c:if></form:label>
                                    <form:input path="screenshot" type="file" placeholder="Screenshot"/>
                                    <p class="help-block">${mOnlyApply}</p>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-default pull-right">${mSubmit}</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mMostSubscribedCourses}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>${mCode}</th>
                                <th>${mName}</th>
                                <th>${mSubscribers}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${topSubscribedCourses}">
                                <tr>
                                    <td>${course.code}</td>
                                    <td>${course.name}</td>
                                    <td>${course.subscribers.size()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mYourApplications}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>${mCourse}</th>
                                <th>${mStartDate}</th>
                                <th>${mEndDate}</th>
                                <th>${mStatus}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="application" items="${lastApplications}">
                                <tr>
                                    <td>${application.course.name}</td>
                                    <td>${application.beginDate}</td>
                                    <td>${application.endDate}</td>
                                    <td>${application.state}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>