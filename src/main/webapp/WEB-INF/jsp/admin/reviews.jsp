<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Reviews" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="reviews" name="title"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Reviews
                    </h1>
                </section>
                <!-- main content -->
                <section class="container container-box">
                    <div id="table">
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
                </section>
            </div>
        </div>
    <jsp:include page="../include/footer.jsp"/>
    </body>
</html>
