<!DOCTYPE HTML>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<tiles:importAttribute name="stylesheets"/>

<c:set var="page_title">
    <tiles:insertAttribute name="page_title" ignore="true"/>
</c:set>
<spring:message code="${page_title}" var="mTitle"/>

<html>
<head>
    <title>${mTitle} - PAL</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="<c:url value="${css}"/>">
    </c:forEach>

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition error">
<div class="wrapper">
    <main class="container">
        <div class="error-page">
            <tiles:insertAttribute name="content"/>
        </div>
    </main>
</div>
</body>
</html>