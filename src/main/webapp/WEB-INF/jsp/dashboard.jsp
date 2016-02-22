<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
            <section class="container container-box">
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
                        <div class="nav-tabs-custom">
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
                                        <li class="time-label">
                                            <span class="bg-red">
                                                <%
                                                    Date dNow = new Date();
                                                    SimpleDateFormat ft =
                                                            new SimpleDateFormat("dd MMM. yyyy");
                                                    out.print(ft.format(dNow));
                                                %>
                                            </span>
                                        </li>
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
                                                <td>${review.text}</td></ts>
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
                                        <form:errors element="div" delimiter="<br />" path="*"
                                                     cssClass="alert alert-danger"/>
                                        <div class="form-group">
                                            <label for="name" class="col-sm-2 control-label">Name</label>
                                            <div class="col-sm-10">
                                                <form:input path="name" class="form-control" placeholder="Name"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="email" class="col-sm-2 control-label">Email</label>
                                            <div class="col-sm-10">
                                                <form:input path="email" class="form-control" placeholder="Email"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="password" class="col-sm-2 control-label">Current
                                                password</label>
                                            <div class="col-sm-10">
                                                <form:password path="password" class="form-control"
                                                               placeholder="Password"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="newPassword" class="col-sm-2 control-label">New password</label>
                                            <div class="col-sm-10">
                                                <form:password path="newPassword" class="form-control"
                                                               placeholder="New password"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="newRepeatPassword" class="col-sm-2 control-label">Repeat
                                                password</label>
                                            <div class="col-sm-10">
                                                <form:password path="newRepeatPassword" class="form-control"
                                                               placeholder="Repeat Password"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-default pull-right"
                                                    style="margin-right: 15px">Change
                                            </button>
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
    </body>
</html>
