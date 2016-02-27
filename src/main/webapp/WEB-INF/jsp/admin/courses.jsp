<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<section class="content-header">
    <h1>
        Courses
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Course overview</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="course-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Short name</th>
                                        <th>Curriculum</th>
                                        <th>Year</th>
                                        <th>Subscribers</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Short name</th>
                                        <th>Curriculum</th>
                                        <th>Year</th>
                                        <th>Subscribers</th>
                                        <th>Actions</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="course" items="${courses}">
                                        <tr>
                                            <td>${course.code}</td>
                                            <td>${course.name}</td>
                                            <td>${course.shortName}</td>
                                            <td>${course.curriculum}</td>
                                            <td>${course.year}</td>
                                            <td>${course.subscribers.size()}</td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/courses" />" method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${course.id}"/>
                                                    <button class="btn btn-sm"><i class="fa fa-trash"></i></button>
                                                </form>
                                                <button class="btn btn-sm update" data-id="${course.id}"><i class="fa fa-pencil"></i></button>
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
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Create a Course</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
                                <c:set var="codeError"><form:errors path="code"/></c:set>
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="shortNameError"><form:errors path="shortName"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <c:set var="yearError"><form:errors path="year"/></c:set>
                                <div class="form-group has-feedback ${ not empty codeError ? 'has-error' : ''}">
                                    <form:errors path="code" element="label"/>
                                    <form:input path="code" class="form-control" placeholder="Course code"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="Course name"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty shortNameError ? 'has-error' : ''}">
                                    <form:errors path="shortName" element="label"/>
                                    <form:input path="shortName" class="form-control" placeholder="Course short name"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:input path="curriculum" class="form-control" placeholder="Course curriculum"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty yearError ? 'has-error' : ''}">
                                    <form:errors path="year" element="label"/>
                                    <form:input path="year" type="number" min="1" class="form-control" value="null" placeholder="Course year"/>
                                </div>
                                <div class="form-group has-feedback">
                                    <button type="submit" class="btn btn-default pull-right">Add</button>
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
                    <h3 class="box-title">Update a Course</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="put" commandName="updateCourse" enctype="application/x-www-form-urlencoded">
                                <c:set var="codeError"><form:errors path="code"/></c:set>
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="shortNameError"><form:errors path="shortName"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <c:set var="yearError"><form:errors path="year"/></c:set>
                                <form:hidden path="id" class="form-control"/>
                                <div class="form-group has-feedback ${ not empty codeError ? 'has-error' : ''}">
                                    <form:errors path="code" element="label"/>
                                    <form:input path="code" class="form-control" placeholder="Course code"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="Course name"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty shortNameError ? 'has-error' : ''}">
                                    <form:errors path="shortName" element="label"/>
                                    <form:input path="shortName" class="form-control" placeholder="Course short name"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:input path="curriculum" class="form-control" placeholder="Course curriculum"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty yearError ? 'has-error' : ''}">
                                    <form:errors path="year" element="label"/>
                                    <form:input path="year" type="number" min="1" class="form-control" value="null" placeholder="Course year"/>
                                </div>
                                <div class="form-group has-feedback">
                                    <button type="submit" class="btn btn-default pull-right">Update</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>