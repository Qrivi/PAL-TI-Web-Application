<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="content-header">
    <h1>
        Lessons
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Lesson overview</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"
                                data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="lesson-overview" class="table table-striped table-bordered"
                                   cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Description</th>
                                        <th>Date</th>
                                        <th>Duration</th>
                                        <th>Maximum Participants</th>
                                        <th>Tutor</th>
                                        <th>Room</th>
                                        <th>Backup room</th>
                                        <th>Registered students</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Description</th>
                                        <th>Date</th>
                                        <th>Duration</th>
                                        <th>Maximum Participants</th>
                                        <th>Tutor</th>
                                        <th>Room</th>
                                        <th>Backup room</th>
                                        <th>Registered students</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="lesson" items="${lessons}">
                                        <tr>
                                            <td>${lesson.name}</td>
                                            <td>${lesson.course.name}</td>
                                            <td>${lesson.description}</td>
                                            <td>${lesson.date}</td>
                                            <td><fmt:formatNumber maxFractionDigits="0" value="${(lesson.duration-0.5)/60}"/>:<fmt:formatNumber value="${lesson.duration%60}" type="number" minIntegerDigits="2"/></td>
                                            <td>${lesson.maxParticipants}</td>
                                            <td>${lesson.tutor.student.name}</td>
                                            <td>${lesson.room.name}</td>
                                            <td>${lesson.backupRoom.name}</td>
                                            <td>${lesson.bookings.size()}</td>
                                            <td>
                                                <form action="<c:url value="/admin/lessons" />" method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${lesson.id}"/>
                                                    <button class="btn btn-sm" data-toggle="tooltip"
                                                            title="Delete">
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