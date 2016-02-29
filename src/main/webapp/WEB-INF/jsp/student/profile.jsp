<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="auth" property="principal"/>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="baseURL" value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}"/>
<c:set var="disabled" value="${editable ? '' : 'disabled'}"/>
<section class="content-header">
    <h1>
        Profile
    </h1>
</section>
<!-- main content -->
<section class="content">
    <div class="row">
        <!-- user profile info bar -->
        <div class="col-md-3">
            <div class="box box-primary">
                <div class="box-body box-profile">
                    <img class="profile-user-img img-responsive img-circle"
                         src="<c:url value="/resources/students/${user.id}/avatar.png"/>" alt="User profile picture">

                    <h3 class="profile-username text-center"><c:out value="${user.name}"/></h3>

                    <p class="text-muted text-center">User: <c:out value="${user.type}"/></p>

                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <b>Past bookings</b> <a class="pull-right"><c:out
                                value="${pastBookings}"/></a>
                        </li>
                        <li class="list-group-item">
                            <b>Upcoming bookings</b> <a class="pull-right"><c:out
                                value="${upcomingBookings}"/></a>
                        </li>
                        <li class="list-group-item">
                            <b>Subscriptions</b> <a class="pull-right"><c:out
                                value="${user.subscriptions == null ? 0 : user.subscriptions.size()}"/></a>
                        </li>
                    </ul>
                    <a href="<c:url value="/calendar"/>" class="btn btn-primary btn-block"><b>Calendar</b></a>
                </div>
            </div>
        </div>
        <!-- tabs -->
        <div class="col-md-9">
            <div id="tabs" class="nav-tabs-custom">
                <!-- tab buttons -->
                <ul class="nav nav-tabs">
                    <!-- activity tab button-->
                    <c:if test="${user == auth}">
                        <li class="active"><a href="#activity" data-toggle="tab" aria-expanded="true">Activity</a>
                        </li>
                    </c:if>
                    <!-- timeline tab button-->
                    <li class=""><a href="#timeline" data-toggle="tab" aria-expanded="false">Timeline</a></li>
                    <!-- settings tab button-->
                    <c:if test="${user == auth}">
                        <li><a href="#settings" data-toggle="tab">Settings</a></li>
                    </c:if>
                </ul>
                <!-- tab contents -->
                <section class="tab-content">
                    <!-- activity tab content-->
                    <c:if test="${user == auth}">
                        <div class="tab-pane" id="activity">
                            <div class="row">
                                <c:if test="${empty lessonReviews}">
                                    <div class="alert alert-info col-sm-4 col-sm-offset-4">
                                        <h4><i class="icon fa fa-info-circle"></i>No closed bookings</h4>
                                        Once you've finished a lesson, you will be able to post a review
                                        here.
                                    </div>
                                </c:if>
                                <c:forEach var="lessonReview" items="${lessonReviews}">
                                    <div class="col-md-12">
                                        <div class="box box-default">
                                            <div class="box-header with-border">
                                                <div class="user-block">
                                                    <img class="profile-user-img img-responsive img-circle"
                                                         src="<c:url value="/resources/students/${lessonReview.lesson.tutor.student.id}/avatar.png"/>"
                                                         alt="User profile picture">
                                                            <span class="username"><a
                                                                    href="#">${lessonReview.lesson.tutor.student.name}</a></span>
                                                            <span class="description">${lessonReview.lesson.course.name} - <fmt:formatDate
                                                                    pattern="HH:mm dd MMMMMMMMM YYYY"
                                                                    value="${lessonReview.lesson.date}"/> </span>
                                                </div>
                                                <div class="box-tools">
                                                    <button type="button" class="btn btn-box-tool"
                                                            data-widget="collapse">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="box-body">
                                                <!-- post text -->
                                                <strong>${lessonReview.lesson.name}</strong>
                                                <p>${lessonReview.lesson.description}</p>
                                            </div>
                                            <div class="box-footer">
                                                <div class="row">
                                                    <div class="col-md-1">
                                                        <div class="row">
                                                            <div class="col-md-offset-2 col-md-10">
                                                                <img class="img-responsive img-circle img-sm"
                                                                     src="<c:url value="/resources/students/${auth.id}/avatar.png"/>"
                                                                     alt="Alt Text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-11">
                                                        <!-- .img-push is used to add margin to elements next to floating images -->
                                                        <div class="img-push row">
                                                            <c:choose>
                                                                <c:when test="${lessonReview.review != null}">
                                                                    <div class="row">
                                                                        <div class="col-md-10">
                                                                            <!--todo add scores -->
                                                                                ${lessonReview.review.text}
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <a href="/profile/lesson/${lessonReview.lesson.id}/reviews/add" class="btn btn-default pull-right">
                                                                                <i class="fa fa-commenting-o"> Edit review</i>
                                                                            </a>
                                                                        </div>

                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="/profile/lesson/${lessonReview.lesson.id}/reviews/add" class="btn btn-default pull-right">
                                                                        <i class="fa fa-commenting-o"> Add review</i>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        </div>
                    </c:if>
                    <!-- timeline tab content-->
                    <div class="tab-pane" id="timeline">
                        <ul class="timeline timeline-inverse">
                            <!-- Empty Timeline -->
                            <c:if test="${empty timeline.archivables}">
                                <li>
                                    <i class="fa fa-info bg-gray"></i>
                                    <div class="timeline-item">
                                        <h3 class="timeline-header">Timeline info</h3>
                                        <div class="timeline-body"><p>This page will show you your history,
                                            This doesn't only contains all the lessons you went to but also
                                            contains all the reviews you've posted.</p></div>
                                    </div>
                                    </i>
                                </li>
                            </c:if>

                            <c:forEach var="archivable" items="${timeline.archivables}">
                                <li class="time-label">
                                                <span class="bg-red">
                                                    <fmt:formatDate pattern="dd MMM. YYYY"
                                                                    value="${archivable.getArchiveDate()}"/>
                                                </span>
                                </li>
                                <li>
                                    <c:choose>
                                        <c:when test="${archivable.class.simpleName == 'Lesson'}">
                                            <!-- Is a Lesson object -->
                                            <i class="fa fa-calendar-check-o bg-blue"></i>
                                            <div class="timeline-item">
                                                                <span class="time">
                                                                    <i class="fa fa-clock-o"></i>
                                                                    <fmt:formatDate pattern="HH:mm"
                                                                                    value="${archivable.getArchiveDate()}"/>
                                                                </span>
                                                <h3 class="timeline-header">Went to <c:out
                                                        value="${archivable.name}"/></h3>
                                                <div class="timeline-body">
                                                    <div class="row">
                                                        <!-- lesson name -->
                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                            <div class="small-box bg-purple">
                                                                <div class="inner">
                                                                    <h3>Course</h3>
                                                                    <p><c:out
                                                                            value="${archivable.course.name}"/></p>
                                                                </div>
                                                                <div class="icon">
                                                                    <i class="fa fa-book"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- tutor -->
                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                            <div class="small-box bg-blue">
                                                                <div class="inner">
                                                                    <h3>Tutor</h3>
                                                                    <p><c:out
                                                                            value="${archivable.tutor.student.name}"/></p>
                                                                </div>
                                                                <div class="icon">
                                                                    <i class="fa fa-user"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- description -->
                                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                                            <p><c:out
                                                                    value="${archivable.description}"/></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${archivable.class.simpleName == 'Review'}">
                                            <!-- TODO add review timeline object -->
                                        </c:when>
                                    </c:choose>
                                </li>
                            </c:forEach>


                            <!-- End timeline items -->
                            <li><i class="fa fa-clock-o bg-gray"></i></li>
                        </ul>
                    </div>
                    <!-- settings tab content-->
                    <c:if test="${user == auth}">
                        <div class="tab-pane" id="settings">
                            <div class="row">
                                <div class="col-sm-12">
                                    <form:form class="form-horizontal" method="put" commandName="profile"
                                               enctype="multipart/form-data">
                                        <c:set var="nameError"><form:errors path="name"/></c:set>
                                        <c:set var="emailError"><form:errors path="email"/></c:set>
                                        <c:set var="subscriptionsError"><form:errors path="subscriptions"/></c:set>
                                        <c:set var="nameError"><form:errors path="name"/></c:set>
                                        <c:set var="passwordError"><form:errors path="password"/></c:set>
                                        <c:set var="newPasswordError"><form:errors path="newPassword"/><form:errors/></c:set>
                                        <c:set var="newRepeatPasswordError"><form:errors path="newRepeatPassword"/><form:errors/></c:set>
                                        <form:errors element="div" cssClass="alert alert-danger"/>
                                        <!-- name field-->
                                        <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                            <form:label path="avatar"
                                                        class="col-sm-2 control-label">Avatar</form:label>
                                            <div class="col-sm-10">
                                                <form:input path="avatar" type="file" placeholder="Avatar"/>
                                            </div>
                                        </div>
                                        <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                            <form:label path="name" class="col-sm-2 control-label">Name</form:label>
                                            <div class="col-sm-10">
                                                <form:input path="name" class="form-control" placeholder="Name"/>
                                            </div>
                                        </div>
                                        <!-- email field-->
                                        <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                                            <form:label path="email"
                                                        class="col-sm-2 control-label">Email</form:label>
                                            <div class="col-sm-10">
                                                <form:input path="email" class="form-control" placeholder="Email"/>
                                            </div>
                                        </div>
                                        <hr class="separator"/>
                                        <!-- subscriptions field -->
                                        <div class="form-group has-feedback ${ not empty subscriptionsError ? 'has-error' : ''}">
                                            <form:label path="subscriptions"
                                                        class="col-sm-2 control-label">Subscriptions</form:label>
                                            <div class="col-sm-10">
                                                <form:select id="subscriptions" path="subscriptions"
                                                             class="form-control select2 select2-hidden-accessible"
                                                             multiple="multiple" data-placeholder="Subscriptions"
                                                             style="width: 100%;" tabindex="-1" aria-hidden="true">
                                                    <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                                </form:select>
                                            </div>
                                        </div>
                                        <hr class="separator"/>
                                        <c:if test="${user.tutor != null}">
                                            <!-- lesson calendar field -->
                                            <div class="form-group has-feedback">
                                                <label for="lesson-calendar" class="col-sm-2 control-label">Lesson Calendar</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <input id="lesson-calendar" type="text" value="${baseURL}resources/students/${user.id}/lessons.ics?token=${user.securityToken}" class="form-control"/>
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button" onclick="copyToClipboard('lesson-calendar')">Copy</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <!-- booking calendar field -->
                                        <div class="form-group has-feedback">
                                            <label for="booking-calendar" class="col-sm-2 control-label">Booking Calendar</label>
                                            <div class="col-sm-10">
                                                <div class="input-group">
                                                    <input id="booking-calendar" type="text" value="${baseURL}resources/students/${user.id}/bookings.ics?token=${user.securityToken}" class="form-control"/>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button" onclick="copyToClipboard('booking-calendar')">Copy</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <hr class="separator"/>
                                        <!-- new password field -->
                                        <div class="form-group has-feedback ${ not empty newPasswordError ? 'has-error' : ''}">
                                            <form:label path="newPassword"
                                                        class="col-sm-2 control-label">New password</form:label>
                                            <div class="col-sm-10">
                                                <form:password path="newPassword" class="form-control"
                                                               placeholder="New password"/>
                                            </div>
                                        </div>
                                        <!-- new password repeat field -->
                                        <div class="form-group has-feedback ${ not empty newRepeatPasswordError ? 'has-error' : ''}">
                                            <form:label path="newRepeatPassword"
                                                        class="col-sm-2 control-label">Repeat Password</form:label>
                                            <div class="col-sm-10">
                                                <form:password path="newRepeatPassword" class="form-control"
                                                               placeholder="Repeat Password"/>
                                            </div>
                                        </div>
                                        <hr class="separator"/>
                                        <!-- password field -->
                                        <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
                                            <form:label path="password"
                                                        class="col-sm-2 control-label">Current Password</form:label>
                                            <div class="col-sm-10">
                                                <form:password path="password" class="form-control"
                                                               placeholder="Current Password"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-10 col-sm-2">
                                                <button type="submit" class="btn btn-default pull-right">Save changes</button>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </section>
            </div>
        </div>
    </div>
</section>
