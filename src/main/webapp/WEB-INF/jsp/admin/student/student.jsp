<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../../include/head.jsp">
        <jsp:param value="Student Overview" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../../include/menu/sidebar.jsp"/>
            <div class="content-wrapper" style="min-height: 1126px;">
                <!-- content-header -->
                <section class="content-header">
                    <h1>
                        Student overview
                    </h1>
                </section>
                <!-- content -->
                <section class="content">
                    <!-- box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Student overview</h3>
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="student-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Type</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Type</th>
                                                <th>Delete</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="student" items="${students}">
                                                <tr>
                                                    <td>${student.name}</td>
                                                    <td>${student.email}</td>
                                                    <td>${student.type}</td>
                                                    <td>
                                                        <form id="command" action="<c:url value="/admin/student/remove/${student.id}" />" method="POST">
                                                            <button class="btn btn-sm">Delete</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
            </div>
        </div>
        <jsp:include page="../../include/footer.jsp"/>
        <script type="application/javascript">
            $( document ).ready( function () {
                $( '#student-overview' ).DataTable();
            } );
        </script>
    </body>
</html>