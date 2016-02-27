<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<section class="content-header">
    <h1>
        Applications
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Pending Applications</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="pending-application-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Course</th>
                                        <th>Date</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Student</th>
                                        <th>Course</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="application" items="${pendingApplications}">
                                        <tr>
                                            <td>${application.student.name}</td>
                                            <td>${application.course.name}</td>
                                            <td>${application.beginDate}</td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/applications/approve/${application.id}" />" method="POST">
                                                    <button class="btn btn-sm btn-success"
                                                            data-toggle="tooltip" title="Approve">
                                                        <i class="fa fa-thumbs-up"></i>
                                                    </button>
                                                </form>
                                                <form class="small" action="<c:url value="/admin/applications/reject/${application.id}" />" method="POST">
                                                    <button class="btn btn-sm btn-danger"
                                                            data-toggle="tooltip" title="Reject">
                                                        <i class="fa fa-thumbs-down"></i>
                                                    </button>
                                                </form>
                                                <button class="btn btn-sm btn-primary screenshot"
                                                        data-toggle="tooltip" title="Screenshot"
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
                    <h3 class="box-title">Done Applications</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="done-application-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Course</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Student</th>
                                        <th>Course</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Status</th>
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
                <h4 class="modal-title">Screenshot</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-primary">You can click on the screenshot to zoom in.</div>
                <a id="screenshot-url">
                    <img id="screenshot" width="100%" height="100%" alt="screenshot"/>
                </a>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
