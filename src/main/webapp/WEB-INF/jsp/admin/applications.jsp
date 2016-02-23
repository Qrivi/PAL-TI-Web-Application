<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Applications" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="applications" name="title"/>
            </jsp:include>
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Students
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
                                                                    <button class="btn btn-sm btn-success"><i class="fa fa-thumbs-up"></i></button>
                                                                </form>
                                                                <form class="small" action="<c:url value="/admin/applications/reject/${application.id}" />" method="POST">
                                                                    <button class="btn btn-sm btn-danger"><i class="fa fa-thumbs-down"></i></button>
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
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
        <script type="application/javascript">
            $( document ).ready( function () {
                $( "#pending-application-overview" ).DataTable();
                $( "#done-application-overview" ).DataTable();
            } );
        </script>
    </body>
</html>
