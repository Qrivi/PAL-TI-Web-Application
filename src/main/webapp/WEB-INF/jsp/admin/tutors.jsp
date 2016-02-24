<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Tutors" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="tutors" name="title"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Tutors
                    </h1>
                </section>
                <!-- main content -->
                <section class="container container-box">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Tutor overview</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"
                                                data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table id="tutor-overview" class="table table-striped table-bordered"
                                                   cellspacing="0" width="100%">
                                                <thead>
                                                <tr>
                                                    <th>Tutor</th>
                                                    <th>Course</th>
                                                    <th data-orderable="false">Actions</th>
                                                </tr>
                                                </thead>
                                                <tfoot>
                                                <tr>
                                                    <th>Tutor</th>
                                                    <th>Course</th>
                                                    <th data-orderable="false">Actions</th>
                                                </tr>
                                                </tfoot>
                                                <tbody>
                                                <c:forEach var="tutor" items="${tutors}">
                                                    <tr>
                                                        <td>${tutor.student.name}</td>
                                                        <td>
                                                            <ul>
                                                                <c:forEach var="course" items="${tutor.courses}">
                                                                    <li>${course.name}</li>
                                                                </c:forEach>
                                                            </ul>
                                                        </td>
                                                        <td>
                                                            <form class="small" action="<c:url value="/admin/tutors" />"
                                                                  method="POST">
                                                                <input type="hidden" name="_method" value="delete"/>
                                                                <input type="hidden" name="id" value="${tutor.id}"/>
                                                                <button class="btn btn-sm"><i class="fa fa-trash"></i>
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
            </div>
        </div>
    <jsp:include page="../include/footer.jsp"/>
        <script type="application/javascript">
            $(document).ready(function () {
                $("#tutor-overview").DataTable();
            });
        </script>
    </body>
</html>