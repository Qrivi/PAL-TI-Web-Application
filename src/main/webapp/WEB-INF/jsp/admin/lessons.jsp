<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Dashboard" name="Lessons"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="dashboard" name="Lessons"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Lessons
                    </h1>
                </section>
                <!-- main content -->
                <section class="container container-box">
                    <div id="table">
                        <table>
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
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lesson" items="${lessons}">
                                    <tr>
                                        <td>${lesson.name}</td>
                                        <td>${lesson.course.name}</td>
                                        <td>${lesson.description}</td>
                                        <td>${lesson.date}</td>
                                        <td>${lesson.duration}</td>
                                        <td>${lesson.maxParticipants}</td>
                                        <td>${lesson.tutor.student.name}</td>
                                        <td>${lesson.room.name}</td>
                                        <td>${lesson.backupRoom.name}</td>
                                        <td>${lesson.bookings.size()}</td>
                                        <td>
                                            <form action="<c:url value="/lesson/remove/${lesson.id}" />" method="POST">
                                                <input type="submit" value="Delete"/>
                                            </form>
                                        </td>
                                        <td></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
    </body>
</html>
