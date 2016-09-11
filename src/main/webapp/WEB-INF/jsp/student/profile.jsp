<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<sec:authentication var="auth" property="principal"/>

<c:set var="baseURL"
       value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}"/>

<spring:message code="Profile.profile" var="mProfile"/>
<spring:message code="Profile.upcomingBookings" var="mUpcomingBookings"/>
<spring:message code="Profile.pastBookings" var="mPastBookings"/>
<spring:message code="Profile.subscriptions" var="mSubscriptions"/>
<spring:message code="Profile.saveChanges" var="mSaveChanges"/>
<spring:message code="Profile.timeline" var="mTimeline"/>
<spring:message code="Profile.settings" var="mSettings"/>
<spring:message code="Profile.copy" var="mCopy"/>
<spring:message code="Review.reviews" var="mReviews"/>
<spring:message code="Calendar.calendar" var="mCalendar"/>
<spring:message code="Calendar.bookingCalendar" var="mBookingCalendar"/>
<spring:message code="Calendar.lessonCalendar" var="mLessonCalendar"/>

<spring:message code="Student.name" var="mName"/>
<spring:message code="Student.password" var="mPassword"/>
<spring:message code="Student.avatar" var="mAvatar"/>
<spring:message code="Student.email" var="mEmail"/>
<spring:message code="Student.curriculum" var="mCurriculum"/>
<spring:message code="Student.type" var="mType"/>
<spring:message code="Student.userType" var="mUserType"/>
<spring:message code="Student.repeatPassword" var="mRepeatPassword"/>
<spring:message code="Student.newPassword" var="mNewPassword"/>
<spring:message code="Student.currentPassword" var="mCurrentPassword"/>

<section class="content-header">
    <h1>
        ${mProfile}
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
                    <p class="text-muted text-center"><c:out value="${user.email}"/></p>
                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <b>${mPastBookings}</b> <a class="pull-right"><c:out
                                value="${pastBookings}"/></a>
                        </li>
                        <li class="list-group-item">
                            <b>${mUpcomingBookings}</b> <a class="pull-right"><c:out
                                value="${upcomingBookings}"/></a>
                        </li>
                        <li class="list-group-item">
                            <b>${mSubscriptions}</b> <a class="pull-right"><c:out
                                value="${user.subscriptions == null ? 0 : user.subscriptions.size()}"/></a>
                        </li>
                    </ul>
                    <a href="<c:url value="/calendar"/>" class="btn btn-primary btn-block"><b>${mCalendar}</b></a>
                </div>
            </div>
        </div>
        <!-- tabs -->
        <div class="col-md-9">
            <div id="tabs" class="nav-tabs-custom">
                <!-- tab buttons -->
                <ul class="nav nav-tabs">
                    <!-- reviews tab button-->
                    <c:if test="${user == auth}">
                        <li class="active"><a href="#reviews" data-toggle="tab" aria-expanded="true">${mReviews}</a>
                        </li>
                    </c:if>
                    <!-- timeline tab button-->
                    <li class=""><a href="#timeline" data-toggle="tab" aria-expanded="false">${mTimeline}</a></li>
                    <!-- settings tab button-->
                    <c:if test="${user == auth}">
                        <li><a href="#settings" data-toggle="tab">${mSettings}</a></li>
                    </c:if>
                </ul>
                <!-- tab contents -->
                <section class="tab-content">
                    <c:if test="${user == auth}">
                        <!-- reviews tab content-->
                        <div class="tab-pane" id="reviews">
                            <div class="loading">
                                <i class="fa fa-refresh fa-spin"></i>
                            </div>
                        </div>
                    </c:if>
                    <!-- timeline tab content-->
                    <div class="tab-pane" id="timeline">
                        <div class="loading">
                            <i class="fa fa-refresh fa-spin"></i>
                        </div>
                        <ul class="timeline timeline-inverse" style="display: none">
                            <!-- End timeline items -->
                            <li><i class="timeline-end fa fa-clock-o bg-gray"></i></li>
                        </ul>
                    </div>
                    <!-- settings tab content-->
                    <c:if test="${user == auth}">
                        <div class="tab-pane" id="settings">
                            <div class="row">
                                <div class="col-sm-12">
                                    <form:form class="form-horizontal" method="put" commandName="profile"
                                               accept-charset="UTF-8"
                                               enctype="multipart/form-data">
                                        <form:errors element="div" cssClass="alert alert-danger" path="*"/>

                                        <sec:authorize access="hasRole('ROLE_TUTOR')">
                                            <!-- lesson calendar field -->
                                            <div class="form-group has-feedback">
                                                <label for="lesson-calendar"
                                                       class="col-sm-2 control-label">${mLessonCalendar}</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <input id="lesson-calendar" type="text"
                                                               value="${baseURL}/resources/students/${user.id}/lessons.ics?token=${user.securityToken}"
                                                               class="form-control"/>
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"
                                                                    onclick="copyToClipboard('lesson-calendar')">${mCopy}</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </sec:authorize>
                                        <!-- booking calendar field -->
                                        <div class="form-group has-feedback">
                                            <label for="booking-calendar"
                                                   class="col-sm-2 control-label">${mBookingCalendar}</label>
                                            <div class="col-sm-10">
                                                <div class="input-group">
                                                    <input id="booking-calendar" type="text"
                                                           value="${baseURL}/resources/students/${user.id}/bookings.ics?token=${user.securityToken}"
                                                           class="form-control"/>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button"
                                                                onclick="copyToClipboard('booking-calendar')">${mCopy}</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <hr class="separator"/>
                                        <!-- name field-->
                                        <div class="form-group has-feedback">
                                            <form:label path="avatar"
                                                        class="col-sm-2 control-label">${mAvatar}</form:label>
                                            <div class="col-sm-10">
                                                <form:input path="avatar" type="file" placeholder="${mAvatar}"/>
                                            </div>
                                        </div>
                                        <!-- subscriptions field -->
                                        <div class="form-group has-feedback">
                                            <form:label path="subscriptions"
                                                        class="col-sm-2 control-label">${mSubscriptions}</form:label>
                                            <div class="col-sm-10">
                                                <form:select id="subscriptions" path="subscriptions"
                                                             class="form-control select2 select2-hidden-accessible"
                                                             multiple="multiple" data-placeholder="${mSubscriptions}"
                                                             style="width: 100%;" tabindex="-1" aria-hidden="true">
                                                    <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                                </form:select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-10 col-sm-2">
                                                <button type="submit"
                                                        class="btn btn-default pull-right">${mSaveChanges}</button>
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
