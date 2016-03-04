<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Course.course" var="mCourse"/>
<spring:message code="Course.courses" var="mCourses"/>
<spring:message code="Course.code" var="mCode"/>
<spring:message code="Course.name" var="mName"/>
<spring:message code="Course.shortName" var="mShortName"/>
<spring:message code="Course.curriculum" var="mCurriculum"/>
<spring:message code="Course.year" var="mYear"/>
<spring:message code="Course.subscribers" var="mSubscribers"/>
<spring:message code="Course.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.add" var="mAdd"/>
<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.update" var="mUpdate"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.create" var="mCreate"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mCourses}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOverview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="course-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>${mCode}</th>
                                        <th>${mName}</th>
                                        <th>${mShortName}</th>
                                        <th>${mCurriculum}</th>
                                        <th>${mYear}</th>
                                        <th>${mSubscribers}</th>
                                        <th data-orderable="false">${mActions}</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>${mCode}</th>
                                        <th>${mName}</th>
                                        <th>${mShortName}</th>
                                        <th>${mCurriculum}</th>
                                        <th>${mYear}</th>
                                        <th>${mSubscribers}</th>
                                        <th>${mActions}</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="course" items="${courses}">
                                        <tr>
                                            <td>${course.code}</td>
                                            <td>${course.name}</td>
                                            <td>${course.shortName}</td>
                                            <td>${course.curriculum}</td>
                                            <td>${course.year}</td>
                                            <td>${course.subscribers.size()}</td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/courses" />" method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${course.id}"/>
                                                    <button class="btn btn-sm" data-toggle="tooltip" title="${mDelete}">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </form>
                                                <button class="btn btn-sm update" data-id="${course.id}" data-toggle="tooltip" title="${mEdit}">
                                                    <i class="fa fa-pencil"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mCreate}${' '}${mCourse}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="post" commandName="course" enctype="application/x-www-form-urlencoded">
                                <c:set var="codeError"><form:errors path="code"/></c:set>
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="shortNameError"><form:errors path="shortName"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <c:set var="yearError"><form:errors path="year"/></c:set>
                                <div class="form-group has-feedback ${ not empty codeError ? 'has-error' : ''}">
                                    <form:errors path="code" element="label"/>
                                    <form:input path="code" class="form-control" placeholder="${mCode}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty shortNameError ? 'has-error' : ''}">
                                    <form:errors path="shortName" element="label"/>
                                    <form:input path="shortName" class="form-control" placeholder="${mShortName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:select path="curriculum" class="curriculum form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCurriculum}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${curriculums}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty yearError ? 'has-error' : ''}">
                                    <form:errors path="year" element="label"/>
                                    <form:input path="year" type="number" min="1" class="form-control" value="null" placeholder="${mYear}"/>
                                </div>
                                <div class="form-group has-feedback">
                                    <button type="submit" class="btn btn-default pull-right">${mAdd}</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mUpdate}${' '}${mCourse}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="put" commandName="updateCourse" enctype="application/x-www-form-urlencoded">
                                <c:set var="codeError"><form:errors path="code"/></c:set>
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="shortNameError"><form:errors path="shortName"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <c:set var="yearError"><form:errors path="year"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <form:hidden path="id" class="form-control"/>
                                <div class="form-group has-feedback ${ not empty codeError ? 'has-error' : ''}">
                                    <form:errors path="code" element="label"/>
                                    <form:input path="code" class="form-control" placeholder="${mCode}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty shortNameError ? 'has-error' : ''}">
                                    <form:errors path="shortName" element="label"/>
                                    <form:input path="shortName" class="form-control" placeholder="${mShortName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:select path="curriculum" class="curriculum form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCurriculum}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${curriculums}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty yearError ? 'has-error' : ''}">
                                    <form:errors path="year" element="label"/>
                                    <form:input path="year" type="number" min="1" class="form-control" value="null" placeholder="${mYear}"/>
                                </div>
                                <div class="form-group has-feedback">
                                    <button type="submit" class="btn btn-default pull-right">${mUpdate}</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>