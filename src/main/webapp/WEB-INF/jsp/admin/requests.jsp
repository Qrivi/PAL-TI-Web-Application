<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<section class="content-header">
    <h1>
        Requests
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Request overview</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="request-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Course</th>
                                    <th>Student</th>
                                    <th>Description</th>
                                    <th>Creation Date</th>
                                    <th>Upvotes</th>
                                    <th data-orderable="false">Actions</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>Title</th>
                                    <th>Course</th>
                                    <th>Student</th>
                                    <th>Description</th>
                                    <th>Creation Date</th>
                                    <th>Upvotes</th>
                                    <th>Actions</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="request" items="${requests}">
                                    <tr>
                                        <td>${request.title}</td>
                                        <td>${request.course.name}</td>
                                        <td>${request.student.name}</td>
                                        <td>${request.description}</td>
                                        <td>${request.creationDate}</td>
                                        <td>${request.upvotes.size()}</td>
                                        <td>
                                            <form class="small" action="<c:url value="/admin/requests" />" method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${request.id}"/>
                                                <button class="btn btn-sm" data-toggle="tooltip" title="Delete">
                                                    <i class="fa fa-trash"></i>
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