<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="content-header">
    <h1>
        Reviews
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Review overview</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="review-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>Lesson</th>
                                        <th>Date</th>
                                        <th>Student</th>
                                        <th>Content Score</th>
                                        <th>Tutor Score</th>
                                        <th>Engagement Score</th>
                                        <th>Atmosphere Score</th>
                                        <th>Comment</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Lesson</th>
                                        <th>Date</th>
                                        <th>Student</th>
                                        <th>Content Score</th>
                                        <th>Tutor Score</th>
                                        <th>Engagement Score</th>
                                        <th>Atmosphere Score</th>
                                        <th>Comment</th>
                                        <th data-orderable="false">Actions</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="review" items="${reviews}">
                                        <tr>
                                            <td>${review.lesson.name}</td>
                                            <td>${review.date}</td>
                                            <td>${review.student.name}</td>
                                            <td>${review.contentScore}</td>
                                            <td>${review.tutorScore}</td>
                                            <td>${review.engagementScore}</td>
                                            <td>${review.atmosphereScore}</td>
                                            <td>${review.text}</td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/reviews" />"
                                                      method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${review.id}"/>
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