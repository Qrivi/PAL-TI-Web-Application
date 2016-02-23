<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Apply as a tutor" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="apply" name="title"/>
            </jsp:include>
            <div class="content-wrapper" style="min-height: 1126px;">
                <section class="content-header">
                    <h1>
                        Apply as a tutor
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Apply as a tutor</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                            <i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <form:form method="post" commandName="tutorApply" enctype="multipart/form-data">
                                                <c:set var="courseError"><form:errors path="course"/></c:set>
                                                <c:set var="screenshotError"><form:errors path="screenshot"/></c:set>
                                                <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
                                                <div class="form-group has-feedback ${ not empty courseError ? 'has-error' : ''}">
                                                    <form:errors path="course" element="label"/>
                                                    <form:select path="course" class="form-control">
                                                        <form:options items="${courses}" itemValue="id" itemLabel="name"/>
                                                    </form:select>
                                                </div>
                                                <div class="form-group has-feedback ${ not empty screenshotError ? 'has-error' : ''}">
                                                    <form:errors path="screenshot" element="label"/>
                                                    <form:input path="screenshot" type="file" class="form-control" placeholder="Screenshot"/>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-primary pull-right">Apply</button>
                                                </div>
                                            </form:form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
    </body>
</html>