<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Tutors" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="tutors" name="title"/>
            </jsp:include>
            <!-- Content header (Page header) -->
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Tutors
                    </h1>
                </section>
                <!-- main content -->
                <section class="container container-box">
                    <div id=table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Tutor</th>
                                    <th>Course</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tutor" items="${tutors}">
                                    <tr>
                                        <td>${tutor.student.name}</td>
                                        <td>
                                            <ol>
                                                <c:forEach var="course" items="${tutor.courses}">
                                                    <li>${course.name}</li>
                                                </c:forEach>
                                            </ol>
                                        </td>
                                        <td>
                                            <form id="command" action="<c:url value="/booking/remove/${tutor.id}" />" method="POST">
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