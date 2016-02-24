<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="include/head.jsp">
        <jsp:param value="Dashboard" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="include/menu/main-header.jsp"/>
            <jsp:include page="include/menu/sidebar.jsp">
                <jsp:param value="dashboard" name="title"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        User Profile
                    </h1>
                </section>
                <!-- main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="box box-primary">
                                <div class="box-body box-profile">
                                    <img class="profile-user-img img-responsive img-circle"
                                         src="<c:url value="/resources/img/profile_pic.jpg"/>" alt="User profile picture">

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
                                    <a href="#" class="btn btn-primary btn-block"><b>Agenda</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div id="tabs" class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#activity" data-toggle="tab"
                                                          aria-expanded="true">Activity</a></li>
                                    <li class=""><a href="#timeline" data-toggle="tab" aria-expanded="false">Timeline</a>
                                    </li>
                                    <li><a href="#settings" data-toggle="tab">Settings</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="activity">
                                        <!-- todo:: show some info -->
                                    </div>
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
                                    <div class="tab-pane" id="reviews">
                                        <table>
                                            <thead>
                                                <th>Lesson</th>
                                                <th>Date</th>
                                                <th>Student</th>
                                                <th>Content Score</th>
                                                <th>Tutor Score</th>
                                                <th>Engagement Score</th>
                                                <th>Atmosphere Score</th>
                                                <th>Comment</th>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="review" items="${reviews}">
                                                    <tr>
                                                        <td>${review.lesson.name}</td>
                                                        <td>${review.date}</td>
                                                        <td>
                                                            <c:when test="${review.anonymous}">Anonymous</c:when>
                                                            <c:otherwise>${review.student.name}</c:otherwise>
                                                        </td>
                                                        <td>${review.contentScore}</td>
                                                        <td>${review.tutorScore}</td>
                                                        <td>${review.engagementScore}</td>
                                                        <td>${review.atmosphereScore}</td>
                                                        <td>${review.text}</td>
                                                        </ts>
                                                        <td>
                                                            <form id="command" action="<c:url value="/review/remove/${review.id}" />" method="POST">
                                                                <input type="submit" value="Delete"/>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="settings">
                                        <form:form class="form-horizontal" method="post" commandName="profile"
                                                   enctype="application/x-www-form-urlencoded">
                                            <c:set var="nameError"><form:errors path="name"/></c:set>
                                            <c:set var="emailError"><form:errors path="email"/></c:set>
                                            <c:set var="nameError"><form:errors path="name"/></c:set>
                                            <c:set var="passwordError"><form:errors path="password"/></c:set>
                                            <c:set var="newPasswordError"><form:errors path="newPassword"/><form:errors/></c:set>
                                            <c:set var="newRepeatPasswordError"><form:errors path="newRepeatPassword"/><form:errors/></c:set>
                                            <form:errors element="div" cssClass="alert alert-danger"/>
                                            <div class="form-group ${ not empty nameError ? 'has-error' : ''}">
                                                <label for="name" class="col-sm-2 control-label">Name</label>
                                                <div class="col-sm-10">
                                                    <form:input path="name" class="form-control" placeholder="Name"/>
                                                </div>
                                            </div>
                                            <div class="form-group ${ not empty emailError ? 'has-error' : ''}">
                                                <label for="email" class="col-sm-2 control-label">Email</label>
                                                <div class="col-sm-10">
                                                    <form:input path="email" class="form-control" placeholder="Email"/>
                                                </div>
                                            </div>
                                            <div class="form-group ${ not empty passwordError ? 'has-error' : ''}">
                                                <label for="password" class="col-sm-2 control-label">Current
                                                    password</label>
                                                <div class="col-sm-10">
                                                    <form:password path="password" class="form-control"
                                                                   placeholder="Password"/>
                                                </div>
                                            </div>
                                            <div class="form-group ${ not empty newPasswordError ? 'has-error' : ''}">
                                                <label for="newPassword" class="col-sm-2 control-label">New password</label>
                                                <div class="col-sm-10">
                                                    <form:password path="newPassword" class="form-control"
                                                                   placeholder="New password"/>
                                                </div>
                                            </div>
                                            <div class="form-group ${ not empty newRepeatPasswordError ? 'has-error' : ''}">
                                                <label for="newRepeatPassword" class="col-sm-2 control-label">Repeat
                                                    password</label>
                                                <div class="col-sm-10">
                                                    <form:password path="newRepeatPassword" class="form-control"
                                                                   placeholder="Repeat Password"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-10 col-sm-2">
                                                    <button type="submit" class="btn btn-default pull-right">Change</button>
                                                </div>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="include/footer.jsp"/>
        <script>
            $( document ).ready( function () {
                $( function () {
                    $( 'a[data-toggle="tab"]' ).on( 'click' , function ( e ) {
                        console.log( $( e.target ).attr( 'href' ) );
                        //save the latest tab using a cookie:
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
