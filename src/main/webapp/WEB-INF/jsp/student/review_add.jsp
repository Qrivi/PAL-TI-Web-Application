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
            <!-- todo add lesson info -->
        </div>
        <!-- review form -->
        <div class="col-md-12">
            <div class="box">
                <form:form method="post" commandName="review" enctype="application/x-www-form-urlencoded">
                    <div class="box-body">
                        <div class="row">
                            <!-- contentScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Content</span>
                                <div class="form-group" >
                                    <div id="contentScore" ></div>
                                    <form:input  id="contentScoreInput" type="hidden" min="1" max="10" path="contentScore" class="form-control" placeholder="Content score"/>
                                </div>
                            </div>
                            <!-- engagementScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Engagement</span>
                                <div class="form-group" >
                                    <div id="engagementScore" ></div>
                                    <form:input id="engagementScoreInput" type="hidden" min="1" max="10" path="engagementScore" class="form-control rateYo" placeholder="Engagement score"/>
                                </div>
                            </div>
                            <!-- AtmosphereScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Atmosphere</span>
                                <div class="form-group" >
                                    <div id="atmosphereScore" ></div>
                                    <form:input id="atmosphereScoreInput" type="hidden" min="1" max="10" path="AtmosphereScore" class="form-control rateYo" placeholder="Atmosphere score"/>
                                </div>
                            </div>
                            <!-- tutorScore field -->
                            <div class="col-md-3 col-sm-6">
                                <span class="control-label">Tutor</span>
                                <div class="form-group" >
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
                                    <button  id="submitReview" type="button" class="btn btn-default pull-right">Add</button>
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
