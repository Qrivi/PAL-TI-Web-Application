<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL" value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>

<section class="content-header">
    <h1>
        Lesson Request
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <!-- New request form -->
            <div class="box box-primary collapsed-box">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-2">
                            <h3 class="box-title">New request</h3>
                        </div>
                        <div id="loading_similar" class="col-md-1"></div>
                        <div class="col-md-1 col-md-offset-8 col-sm-offset-6">
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fa fa-plus"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <form:form action="/request/add" method="POST" commandName="request">
                <c:set var="courseError"><form:errors path="course"/></c:set>
                    <c:set var="titleError"><form:errors path="title"/></c:set>
                <c:set var="descriptionError"><form:errors path="description"/></c:set>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-offset-4 col-md-4">
                                <div class="alert alert-info alert-dismissible">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-info"></i> Info</h4>
                                    Please check if your request doesn't already exist.
                                </div>
                            </div>
                            <div id="similar_requests" class="col-md-offset-2 col-md-8 col-sm-12">
                            </div>
                            <div class="col-md-9 col-sm-12 col-xs-12 form-group">
                                <form:label path="title">Title : <c:if test="${not empty titleError}"><span class="text-danger">${titleError}</span></c:if></form:label>
                                <form:input id="request_title" path="title" maxlength="50" minlength="3" class="form-control" placeholder="title"/>
                                <div id="request_title_feedback" class="label label-default"></div>
                            </div>
                            <div class="col-md-3 col-sm-12 col-xs-12 form-group">
                                <form:label path="course">Course : <c:if test="${not empty courseError}"><span class="text-danger">${courseError}</span></c:if></form:label>
                                <form:select id="request_course" path="course" class="form-control"
                                             placeholder="Course">
                                    <form:option value="" label="--- Course ---"/>
                                    <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                </form:select>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                                <form:label path="description">Description : <c:if test="${not empty descriptionError}"><span class="text-danger">${descriptionError}</span></c:if></form:label>
                                <form:textarea id="request_text" path="description" maxlength="300" minlength="10" class="form-control" placeholder="description"/>
                                <div id="request_text_feedback" class="label label-default"></div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="pull-right">
                            <form:button class="btn btn-default" type="submit">Add Request</form:button>
                        </div>
                    </div>
                </form:form>
            </div>

            <!- Current requests -->
            <!-- todo add current requests -->
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">My requests & up-votes</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!--TODO:: finish displaying current users requests/upvotes -->
                        <div class="alert alert-info col-sm-4 col-sm-offset-4">
                            <h4><i class="icon fa fa-frown-o"></i>No requests or up-votes</h4>
                            <p>You haven't made any requests, nor have you up-voted any.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
