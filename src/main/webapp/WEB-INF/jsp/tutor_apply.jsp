<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<form:form method="post" commandName="tutorApply" enctype="multipart/form-data">
    <form:errors element="div" delimiter="<br />" path="*" cssClass="alert alert-danger"/>
    <div class="form-group">
        <form:select path="course" class="form-control">
            <form:options items="${courses}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>
    <div>
        <form:input path="screenshot" type="file" class="form-control" placeholder="Screenshot"/>
    </div>
    <div class="form-group">
        <button type="submit" class="btn btn-default pull-right">Apply</button>
    </div>
</form:form>
