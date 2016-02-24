<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Rooms" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="rooms" name="title"/>
            </jsp:include>
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Rooms
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Room overview</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table id="room-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Campus</th>
                                                        <th>Type</th>
                                                        <th data-orderable="false">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Campus</th>
                                                        <th>Type</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <c:forEach var="room" items="${rooms}">
                                                        <tr>
                                                            <td>${room.name}</td>
                                                            <td>${room.campus}</td>
                                                            <td>${room.type}</td>
                                                            <td>
                                                                <form class="small" action="<c:url value="/admin/rooms" />" method="POST">
                                                                    <input type="hidden" name="_method" value="delete"/>
                                                                    <input type="hidden" name="id" value="${room.id}"/>
                                                                    <button class="btn btn-sm" data-toggle="tooltip" title="Delete">
                                                                        <i class="fa fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                                <button class="btn btn-sm update" data-id="${room.id}" data-toggle="tooltip" title="Edit">
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
                                    <h3 class="box-title">Create a Room</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="post" commandName="room" enctype="application/x-www-form-urlencoded">
                                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                                <c:set var="campusError"><form:errors path="campus"/></c:set>
                                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:errors path="name" element="label"/>
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty campusError ? 'has-error' : ''}">
                                                    <form:errors path="campus" element="label"/>
                                                    <form:select path="campus" class="form-control">
                                                        <form:option value="None" label="--- Campus ---"/>
                                                        <form:options items="${campuses}"/>
                                                    </form:select>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                                    <form:errors path="type" element="label"/>
                                                    <form:select path="type" class="form-control">
                                                        <form:option value="None" label="--- Room Type ---"/>
                                                        <form:options items="${roomTypes}"/>
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
                                    <h3 class="box-title">Update a Room</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="put" commandName="updateRoom" enctype="application/x-www-form-urlencoded">
                                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                                <c:set var="campusError"><form:errors path="campus"/></c:set>
                                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                                <form:hidden path="id" class="form-control"/>
                                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:errors path="name" element="label"/>
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty campusError ? 'has-error' : ''}">
                                                    <form:errors path="campus" element="label"/>
                                                    <form:select path="campus" class="form-control">
                                                        <form:option value="None" label="--- Campus ---"/>
                                                        <form:options items="${campuses}"/>
                                                    </form:select>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                                    <form:errors path="type" element="label"/>
                                                    <form:select path="type" class="form-control">
                                                        <form:option value="None" label="--- Room Type ---"/>
                                                        <form:options items="${roomTypes}"/>
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
                $( "#room-overview" ).DataTable();
                $( "#room-overview .update" ).click( function () {
                    var props = $( this ).parent().parent().find( "td" );
                    $( "#updateRoom #id" ).val( $( this ).attr( "data-id" ) );
                    $( "#updateRoom #name" ).val( props[ 0 ].textContent );
                    $( "#updateRoom #campus" ).val( props[ 1 ].textContent );
                    $( "#updateRoom #type" ).val( props[ 2 ].textContent );
                } );
            } );
        </script>
    </body>
</html>