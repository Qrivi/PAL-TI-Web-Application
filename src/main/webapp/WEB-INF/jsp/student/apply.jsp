<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<section class="content-header">
    <h1>
        Apply for Tutoring
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Submit your application</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
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
                                    <form:label path="course">Course : <c:if test="${not empty courseError}"><span class="text-danger">${courseError}</span></c:if></form:label>
                                    <form:select path="course" class="form-control select2 select2-hidden-accessible"
                                                 data-placeholder="Course" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <form:option value="" label="--- Course ---"/>
                                        <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty screenshotError ? 'has-error' : ''}">
                                    <form:label path="screenshot">Screenshot : <c:if test="${not empty screenshotError}"><span class="text-danger">${screenshotError}</span></c:if></form:label>
                                    <form:input path="screenshot" type="file" placeholder="Screenshot"/>
                                    <p class="help-block">You can only apply for tutoring when you submit a screenshot of your point for that specific course!</p>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-default pull-right">Submit application</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Most subscribed courses</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Name</th>
                                <th>Subscribers</th>
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
                    <h3 class="box-title">Your applications</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Course</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
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