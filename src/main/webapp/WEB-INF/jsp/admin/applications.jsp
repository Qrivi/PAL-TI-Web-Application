<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<spring:message code="Application.application" var="mApplication"/>
<spring:message code="Application.applications" var="mApplications"/>
<spring:message code="Application.student" var="mStudent"/>
<spring:message code="Application.course" var="mCourse"/>
<spring:message code="Application.date" var="mDate"/>
<spring:message code="Application.startDate" var="mStartDate"/>
<spring:message code="Application.endDate" var="mEndDate"/>
<spring:message code="Application.status" var="mStatus"/>
<spring:message code="Application.apply" var="mApply"/>
<spring:message code="Application.approve" var="mApprove"/>
<spring:message code="Application.approved" var="mApproved"/>
<spring:message code="Application.reject" var="mReject"/>
<spring:message code="Application.rejected" var="mRejected"/>
<spring:message code="Application.screenshot" var="mScreenshot"/>
<spring:message code="Application.pendingApplications" var="mPendingApplications"/>
<spring:message code="Application.doneApplications" var="mDoneApplications"/>
<spring:message code="Application.zoom" var="mZoom"/>
<spring:message code="Application.close" var="mClose"/>
<spring:message code="Student.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.add" var="mAdd"/>
<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.update" var="mUpdate"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.create" var="mCreate"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mApplications}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mPendingApplications}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="pending-application-overview" class="table table-striped table-bordered"
                                   cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>${mStudent}</th>
                                    <th>${mCourse}</th>
                                    <th>${mDate}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mStudent}</th>
                                    <th>${mCourse}</th>
                                    <th>${mDate}</th>
                                    <th>${mActions}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="application" items="${pendingApplications}">
                                    <tr>
                                        <td>${application.student.name}</td>
                                        <td>${application.course.name}</td>
                                        <td>${application.beginDate}</td>
                                        <td>
                                            <form class="small"
                                                  action="<c:url value="/admin/applications/approve/${application.id}" />"
                                                  method="POST">
                                                <button class="btn btn-sm btn-success"
                                                        data-toggle="tooltip" title="${mApprove}">
                                                    <i class="fa fa-thumbs-up"></i>
                                                </button>
                                            </form>
                                            <form class="small"
                                                  action="<c:url value="/admin/applications/reject/${application.id}" />"
                                                  method="POST">
                                                <button class="btn btn-sm btn-danger"
                                                        data-toggle="tooltip" title="${mReject}">
                                                    <i class="fa fa-thumbs-down"></i>
                                                </button>
                                            </form>
                                            <button class="btn btn-sm btn-primary screenshot"
                                                    data-toggle="tooltip" title="${mScreenshot}"
                                                    data-url="<c:url value="/resources/applications/${application.id}/screenshot.png"/>">
                                                <i class="fa fa-picture-o"></i>
                                            </button>
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
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mDoneApplications}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="done-application-overview" class="table table-striped table-bordered"
                                   cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>${mStudent}</th>
                                    <th>${mCourse}</th>
                                    <th>${mStartDate}</th>
                                    <th>${mEndDate}</th>
                                    <th>${mStatus}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mStudent}</th>
                                    <th>${mCourse}</th>
                                    <th>${mStartDate}</th>
                                    <th>${mEndDate}</th>
                                    <th>${mStatus}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="application" items="${doneApplications}">
                                    <tr>
                                        <td>${application.student.name}</td>
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
        </div>
    </div>
</section>
<div class="modal" id="screenshot-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">${mScreenshot}</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">${mZoom}</div>
                <a id="screenshot-url">
                    <img id="screenshot" width="100%" height="100%" alt="screenshot"/>
                </a>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">${mClose}</button>
            </div>
        </div>
    </div>
</div>
