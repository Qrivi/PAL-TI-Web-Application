<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL" value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>

<section class="content-header">
    <h1>
        New Review
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <!-- lesson info -->
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${lesson.name}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- tutor info panel -->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-8 col-sm-8 col-xs-8">
                                            <h4>Tutor</h4>
                                            <ul>
                                                <li>${lesson.tutor.student.name}</li>
                                                <li>${lesson.tutor.courses.size()} course${lesson.tutor.courses.size() >1 ?'s' : ''}</li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4 col-sm-4 col-xs-4 pull-right">
                                            <a href="<c:url value="/profile/${lesson.tutor.student.id}"/>" alt="Tutor info">
                                                <img class="img-responsive img-circle" src="<c:url value="/resources/students/${lesson.tutor.student.id}/avatar.png"/>" alt="Tutor profile picture" style="padding:10px;max-width: 80px; max-height: 80px;">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- course info panel -->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>Course</h4>
                                    <ul>
                                        <li>${lesson.course.code} - ${lesson.course.name}</li>
                                        <li>${lesson.course.curriculum} - ${lesson.course.year}e</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Lesson info panel -->
                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="pull-right">
                                        <span class="label label-primary"><fmt:formatDate value="${lesson.date}" pattern="HH:mm dd MMMMMMMMM YYYY"/> - ${lesson.duration}min.</span>
                                    </div>
                                    <h4>Lesson</h4>
                                    <ul>
                                        <li>${lesson.name}</li>
                                        <li>${lesson.room.name}, ${lesson.room.campus} or ${lesson.backupRoom.name}, ${lesson.backupRoom.campus}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Lesson description panel -->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>Description</h4>
                                    <p><c:out value="${lesson.description}"/></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <!-- review form -->
        <div class="col-md-12">
            <div class="box box-primary">
                <form:form method="post" commandName="review" enctype="application/x-www-form-urlencoded">
                    <div class="box-body">
                        <div class="row">
                            <!-- contentScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Content</span>
                                <div class="form-group">
                                    <div id="contentScore"></div>
                                    <form:input id="contentScoreInput" type="hidden" min="1" max="10" path="contentScore" class="form-control" placeholder="Content score"/>
                                </div>
                            </div>
                            <!-- engagementScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Engagement</span>
                                <div class="form-group">
                                    <div id="engagementScore"></div>
                                    <form:input id="engagementScoreInput" type="hidden" min="1" max="10" path="engagementScore" class="form-control rateYo" placeholder="Engagement score"/>
                                </div>
                            </div>
                            <!-- AtmosphereScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Atmosphere</span>
                                <div class="form-group">
                                    <div id="atmosphereScore"></div>
                                    <form:input id="atmosphereScoreInput" type="hidden" min="1" max="10" path="AtmosphereScore" class="form-control rateYo" placeholder="Atmosphere score"/>
                                </div>
                            </div>
                            <!-- tutorScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Tutor</span>
                                <div class="form-group">
                                    <div id="tutorScore"></div>
                                    <form:input id="tutorScoreInput" type="hidden" min="1" max="10" path="tutorScore" class="form-control rateYo" placeholder="Tutor score"/>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
                                <div class="form-group">
                                    <form:textarea id="review_text" path="text" maxlength="140" minlength="10" class="form-control" placeholder="Comment"/>
                                    <div id="review_text_feedback" class="label label-default"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <div class="checkbox icheck">
                                        <label>
                                            <form:checkbox path="Anonymous" class="form-control " placeholder="Anonymous"/> <span>Post anonymous</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-offset-8 col-md-1">
                                <div class="form-group pull-right">
                                    <button id="submitReview" type="submit" class="btn btn-default pull-right">Add</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-footer-->
                </form:form>
            </div>
        </div>
    </div>
</section>
