<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Students" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="students" name="title"/>
            </jsp:include>
            <div class="content-wrapper">
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
                                                        <th data-orderable="false">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Type</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <c:forEach var="student" items="${students}">
                                                        <tr>
                                                            <td>${student.name}</td>
                                                            <td>${student.email}</td>
                                                            <td>${student.type}</td>
                                                            <td>
                                                                <form class="small" action="<c:url value="/admin/students" />" method="POST">
                                                                    <input type="hidden" name="_method" value="delete"/>
                                                                    <input type="hidden" name="id" value="${student.id}"/>
                                                                    <button class="btn btn-sm" data-toggle="tooltip"
                                                                            title="Delete">
                                                                        <i class="fa fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                                <button class="btn btn-sm update"
                                                                        data-id="${student.id}" data-toggle="tooltip"
                                                                        title="Edit">
                                                                    <i class="fa fa-pencil"></i>
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
                        <div class="col-md-6">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Create a Student</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="post" commandName="student" enctype="application/x-www-form-urlencoded">
                                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                                <c:set var="emailError"><form:errors path="email"/></c:set>
                                                <c:set var="passwordError"><form:errors path="password"/></c:set>
                                                <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
                                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                                <form:errors element="div" cssClass="alert alert-danger"/>
                                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:errors path="name" element="label"/>
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                                                    <form:errors path="email" element="label"/>
                                                    <form:input path="email" class="form-control" placeholder="Email"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
                                                    <form:errors path="password" element="label"/>
                                                    <form:password path="password" class="form-control" placeholder="Password"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
                                                    <form:errors path="repeatPassword" element="label"/>
                                                    <form:password path="repeatPassword" class="form-control" placeholder="Repeat Password"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                                    <form:errors path="type" element="label"/>
                                                    <form:select path="type" class="form-control">
                                                        <form:option value="None" label="--- Select ---"/>
                                                        <form:options items="${userTypes}"/>
                                                    </form:select>
                                                </div>
                                                <div class="form-group">
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
                                    <h3 class="box-title">Update a Student</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="put" commandName="updateStudent" enctype="application/x-www-form-urlencoded">
                                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                                <c:set var="emailError"><form:errors path="email"/></c:set>
                                                <c:set var="passwordError"><form:errors path="password"/></c:set>
                                                <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
                                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                                <form:errors element="div" cssClass="alert alert-danger"/>
                                                <form:hidden path="id" class="form-control"/>
                                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:errors path="name" element="label"/>
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                                                    <form:errors path="email" element="label"/>
                                                    <form:input path="email" class="form-control" placeholder="Email"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
                                                    <form:errors path="password" element="label"/>
                                                    <form:password path="password" class="form-control" placeholder="Password"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
                                                    <form:errors path="repeatPassword" element="label"/>
                                                    <form:password path="repeatPassword" class="form-control" placeholder="Repeat Password"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                                    <form:errors path="type" element="label"/>
                                                    <form:select path="type" class="form-control">
                                                        <form:option value="None" label="--- Select ---"/>
                                                        <form:options items="${userTypes}"/>
                                                    </form:select>
                                                </div>
                                                <div class="form-group">
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
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
        <script type="application/javascript">
            $( document ).ready( function () {
                $( "#student-overview" ).DataTable();
                $( "#student-overview .update" ).click( function () {
                    var props = $( this ).parent().parent().find( "td" );
                    $( "#updateStudent #id" ).val( $( this ).attr( "data-id" ) );
                    $( "#updateStudent #name" ).val( props[ 0 ].textContent );
                    $( "#updateStudent #email" ).val( props[ 1 ].textContent );
                    $( "#updateStudent #type" ).val( props[ 2 ].textContent );
                } );
            } );
        </script>
    </body>
</html>