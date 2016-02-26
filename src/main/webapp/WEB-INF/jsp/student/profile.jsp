<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="auth" property="principal"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Profile" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="profile" name="title"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Profile
                    </h1>
                </section>
                <!-- main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="box box-primary">
                                <div class="box-body box-profile">
                                    <img class="profile-user-img img-responsive img-circle"
                                         src="<c:url value="/resources/students/${user.id}/avatar.png"/>" alt="User profile picture">

                                    <h3 class="profile-username text-center"><c:out value="${user.name}"/></h3>

                                    <p class="text-muted text-center">User: <c:out value="${user.type}"/></p>

                                    <ul class="list-group list-group-unbordered">
                                        <li class="list-group-item">
                                            <b>Closed bookings</b> <a class="pull-right"><c:out
                                                value="${user.getClosedBookings().size()}"/></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>Open bookings</b> <a class="pull-right"><c:out
                                                value="${user.getOpenBookings().size()}"/></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>Subscriptions</b> <a class="pull-right"><c:out
                                                value="${user.getSubscriptions().size()}"/></a>
                                        </li>
                                    </ul>
                                    <!-- todo:: link to students agenda -->
                                    <a href="<c:url value="/calendar"/>" class="btn btn-primary btn-block"><b>Calendar</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div id="tabs" class="nav-tabs-custom">
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
                                <section class="tab-content">
                                    <!-- activity tab content-->
                                    <c:if test="${user == auth}">
                                        <div class="tab-pane active" id="activity">
                                        <c:forEach var="lesson" items="${user.closedBookings}">
                                            <div class="box box-widget">
                                                <div class="box-header with-border">
                                                    <div class="user-block">
                                                        <!-- class="img-circle" ? -->
                                                        <img class="profile-user-img img-responsive img-circle"
                                                             src="<c:url value="/resources/students/${lesson.tutor.student.id}/avatar.png"/>"
                                                             alt="User profile picture">
                                                        <span class="username"><a href="#">${lesson.tutor.student.name}</a></span>
                                                        <span class="description">${lesson.name} - ${lesson.date}</span>
                                                    </div>
                                                    <!-- /.user-block -->
                                                    <div class="box-tools">
                                                        <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="Mark as read">
                                                            <i class="fa fa-circle-o"></i></button>
                                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                                        </button>
                                                        <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
                                                    </div>
                                                    <!-- /.box-tools -->
                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <!-- post text -->
                                                    <p>${lesson.description}</p>
                                                    <!-- Social sharing buttons -->
                                                    <button type="button" class="btn btn-default btn-xs"><i class="fa fa-comment-o"></i> Give review</button>
                                                    <span class="pull-right text-muted">${lesson.reviews.size()} reviews</span>
                                                </div>
                                                <!-- /.box-body -->
                                                <div class="box-footer box-comments">
                                                    <!-- /.box-comment -->
                                                    <c:forEach var="review" items="${lesson.reviews}">
                                                    <div class="box-comment">
                                                        <!-- User image -->
                                                        <img class="profile-user-img img-responsive img-circle" src="<c:url value="/profile/${review.student.id}/avatar.png"/>" alt="User profile picture">

                                                        <div class="comment-text">
                                                                    <span class="username">

                                                                        <span class="text-muted pull-right">8:03 PM Today</span>
                                                                    </span><!-- /.username -->
                                                            Content: ${review.contentScore}
                                                            Tutor: ${review.tutorScore}
                                                            Engagement: ${review.engagementScore}
                                                            Atmosphere: ${review.atmosphereScore}
                                                                ${review.text}
                                                        </div>
                                                        <!-- /.comment-text -->
                                                    </div>
                                                    <!-- /.box-comment -->
                                                </div>
                                                </c:forEach>
                                                <!-- /.box-footer -->
                                                <div class="box-footer">
                                                    <form action="#" method="post">
                                                        <img class="img-responsive img-circle img-sm" src="../dist/img/user4-128x128.jpg" alt="Alt Text">
                                                        <!-- .img-push is used to add margin to elements next to floating images -->
                                                        <div class="img-push">
                                                            <input type="text" class="form-control input-sm" placeholder="Press enter to post comment">
                                                        </div>
                                                    </form>
                                                </div>
                                                <!-- /.box-footer -->
                                            </div>
                                        </c:forEach>
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
                                            <form:form class="form-horizontal" method="put" action="/profile" commandName="profile"
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
                                                <div class="form-group ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:label path="avatar"
                                                                class="col-sm-2 control-label">Avatar</form:label>
                                                    <div class="col-sm-10">
                                                        <form:input path="avatar" type="file" placeholder="Avatar"/>
                                                    </div>
                                                </div>
                                                <div class="form-group ${ not empty nameError ? 'has-error' : ''}">
                                                    <form:label path="name" class="col-sm-2 control-label">Name</form:label>
                                                    <div class="col-sm-10">
                                                        <form:input path="name" class="form-control" placeholder="Name"/>
                                                    </div>
                                                </div>
                                                <!-- email field-->
                                                <div class="form-group ${ not empty emailError ? 'has-error' : ''}">
                                                    <form:label path="email"
                                                                class="col-sm-2 control-label">Email</form:label>
                                                    <div class="col-sm-10">
                                                        <form:input path="email" class="form-control" placeholder="Email"/>
                                                    </div>
                                                </div>
                                                <hr class="separator"/>
                                                <!-- subscriptions field -->
                                                <div class="form-group ${ not empty subscriptionsError ? 'has-error' : ''}">
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
                                                <!-- new password field -->
                                                <div class="form-group ${ not empty newPasswordError ? 'has-error' : ''}">
                                                    <form:label path="newPassword"
                                                                class="col-sm-2 control-label">New password</form:label>
                                                    <div class="col-sm-10">
                                                        <form:password path="newPassword" class="form-control"
                                                                       placeholder="New password"/>
                                                    </div>
                                                </div>
                                                <!-- new password repeat field -->
                                                <div class="form-group ${ not empty newRepeatPasswordError ? 'has-error' : ''}">
                                                    <form:label path="newRepeatPassword"
                                                                class="col-sm-2 control-label">Repeat Password</form:label>
                                                    <div class="col-sm-10">
                                                        <form:password path="newRepeatPassword" class="form-control"
                                                                       placeholder="Repeat Password"/>
                                                    </div>
                                                </div>
                                                <hr class="separator"/>
                                                <!-- password field -->
                                                <div class="form-group ${ not empty passwordError ? 'has-error' : ''}">
                                                    <form:label path="password"
                                                                class="col-sm-2 control-label">Current Password</form:label>
                                                    <div class="col-sm-10">
                                                        <form:password path="password" class="form-control"
                                                                       placeholder="Current Password"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-10 col-sm-2">
                                                        <button type="submit" class="btn btn-default pull-right">Change</button>
                                                    </div>
                                                </div>
                                            </form:form>
                                        </div>
                                    </c:if>
                                </section>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
        <script>
            $( document ).ready( function () {
                $( "#subscriptions" ).select2();
                $( function () {
                    $( 'a[data-toggle="tab"]' ).on( 'click' , function ( e ) {
                        console.log( $( e.target ).attr( 'href' ) );
                        $.cookie( 'last_tab' , $( e.target ).attr( 'href' ) );
                    } );
                    var lastTab = $.cookie( 'last_tab' );
                    if ( lastTab ) {
                        $( 'ul.nav-tabs' ).children().removeClass( 'active' );
                        $( 'a[href="' + lastTab + '"]' ).parents( 'li:first' ).addClass( 'active' );
                        $( 'div.tab-content' ).children().removeClass( 'active' );
                        $( lastTab ).addClass( 'active' );
                    }
                } );
            } );
        </script>
    </body>
</html>
