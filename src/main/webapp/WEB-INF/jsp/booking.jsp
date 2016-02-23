<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<jsp:include page="include/head.jsp">
    <jsp:param value="Booking" name="title"/>
</jsp:include>
<body class="hold-transition skin-blue">
<div class="wrapper">
    <jsp:include page="include/menu/main-header.jsp"/>
    <jsp:include page="include/menu/sidebar.jsp">
        <jsp:param value="booking" name="title"/>
    </jsp:include>
    <!-- Content header (Page header) -->
    <div class="content-wrapper" style="min-height: 1126px;">
        <section class="content-header">
            <h1>
                Bookings
            </h1>
        </section>
        <!-- main content -->
        <section class="container container-box">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Lessons</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i
                                class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <c:if test="${empty lessons}">
                            <div class="alert alert-warning col-sm-4 col-md-offset-4">
                                <h4><i class="icon fa fa-frown-o"></i>No lessons</h4>
                                There aren't any lessons available.
                            </div>
                        </c:if>
                        <c:if test="${not empty lessons}">
                            <div class="col-sm-12">
                                <table id="lessons-overview" class="table table-striped table-bordered" cellspacing="0"
                                       width="100%">
                                    <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Date</th>
                                        <th>Duration</th>
                                        <th>Participants</th>
                                        <th>Tutor</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                    </thead>
                                    <tfoot>
                                    <tr>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Date</th>
                                        <th>Duration</th>
                                        <th>Participants</th>
                                        <th>Tutor</th>
                                        <th>Actions</th>
                                    </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach var="lesson" items="${lessons}">
                                        <tr>
                                            <td>${lesson.name}</td>
                                            <td>${lesson.course.name}</td>
                                            <td>${lesson.date}</td>
                                            <td>${lesson.duration}</td>
                                            <td>
                                                <div class="progress progress-xs">
                                                    <div class="progress-bar
                                                        <c:set var="percentage" value="${lesson.bookings.size()/lesson.maxParticipants*100}"/>
                                                        <c:choose>
                                                            <c:when test="${percentage < 60}">progress-bar-success</c:when>
                                                            <c:when test="${percentage > 60 and percentage < 100}">progress-bar-warning</c:when>
                                                            <c:when test="${percentage == 100}">progress-bar-danger</c:when>
                                                        </c:choose>"
                                                         style="width: ${lesson.bookings.size()/lesson.maxParticipants*100}%"></div>
                                                </div>
                                                    ${lesson.bookings.size()}/${lesson.maxParticipants}
                                            </td>
                                            <td>${lesson.tutor.student.name}</td>
                                            <td>
                                                <c:if test="${percentage < 100 and not myOpenBookings.contains(lesson)}">
                                                    <form action="<c:url value="/booking/register/${lesson.id}" />"
                                                          method="POST">
                                                        <button type="submit" class="btn btn-block btn-success btn-sm">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${myOpenBookings.contains(lesson)}">
                                                    <form action="<c:url value="/booking/unregister/${lesson.id}" />"
                                                          method="POST">
                                                        <button class="btn btn-block btn-success btn-sm">
                                                            <i class="fa fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script type="application/javascript">
    $(document).ready(function () {
        $("#lessons-overview").DataTable();
    });
</script>
</body>
</html>
