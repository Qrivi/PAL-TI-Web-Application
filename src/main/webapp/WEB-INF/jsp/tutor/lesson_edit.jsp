<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<jsp:include page="../include/head.jsp">
    <jsp:param value="Edit lesson" name="title"/>
</jsp:include>
<body class="hold-transition skin-blue">
<div class="wrapper">
    <jsp:include page="../include/menu/main-header.jsp"/>
    <jsp:include page="../include/menu/sidebar.jsp">
        <jsp:param value="tutor_lessons" name="title"/>
    </jsp:include>
    <!-- Content header (Page header) -->
    <div class="content-wrapper" style="min-height: 1126px;">
        <section class="content-header">
            <h1>
                Edit lesson
            </h1>
        </section>
        <!-- main content -->
        <section class="content container-box">
            <div class="row">
                <img class="col-md-12" src="http://www.cep-amsterdam.nl/website_under_construction1.png"/>
            </div>
        </section>
    </div>
</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>

