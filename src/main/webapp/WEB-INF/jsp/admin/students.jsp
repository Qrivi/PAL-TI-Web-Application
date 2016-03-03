<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Student.student" var="mStudent"/>
<spring:message code="Student.students" var="mStudents"/>
<spring:message code="Student.name" var="mName"/>
<spring:message code="Student.password" var="mPassword"/>
<spring:message code="Student.avatar" var="mAvatar"/>
<spring:message code="Student.email" var="mEmail"/>
<spring:message code="Student.curriculum" var="mCurriculum"/>
<spring:message code="Student.type" var="mType"/>
<spring:message code="Student.userType" var="mUserType"/>
<spring:message code="Student.repeatPassword" var="mRepeatPassword"/>
<spring:message code="Student.overview" var="mOveview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.add" var="mAdd"/>
<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.update" var="mUpdate"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.create" var="mCreate"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mStudents}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOveview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="student-overview" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>${mName}</th>
                                        <th>${mEmail}</th>
                                        <th>${mCurriculum}</th>
                                        <th>${mType}</th>
                                        <th data-orderable="false">${mActions}</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>${mName}</th>
                                        <th>${mEmail}</th>
                                        <th>${mCurriculum}</th>
                                        <th>${mType}</th>
                                        <th>${mActions}</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td>${student.name}</td>
                                            <td>${student.email}</td>
                                            <td>${student.curriculum}</td>
                                            <td>${student.type}</td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/students" />" method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${student.id}"/>
                                                    <button class="btn btn-sm" data-toggle="tooltip" title="${mDelete}">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </form>
                                                <button class="btn btn-sm update" data-id="${student.id}" data-toggle="tooltip" title="${mEdit}">
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
                    <h3 class="box-title">${mCreate}${' '}${mStudent}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="post" commandName="student" enctype="application/x-www-form-urlencoded">
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="emailError"><form:errors path="email"/></c:set>
                                <c:set var="passwordError"><form:errors path="password"/></c:set>
                                <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <form:errors element="div" cssClass="alert alert-danger"/>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                                    <form:errors path="email" element="label"/>
                                    <form:input path="email" class="form-control" placeholder="${mEmail}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
                                    <form:errors path="password" element="label"/>
                                    <form:password path="password" class="form-control" placeholder="${mPassword}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
                                    <form:errors path="repeatPassword" element="label"/>
                                    <form:password path="repeatPassword" class="form-control" placeholder="${mRepeatPassword}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                    <form:errors path="type" element="label"/>
                                    <form:select path="type" class="type form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mUserType}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${userTypes}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:select path="curriculum" class="curriculum form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCurriculum}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${curriculums}"/>
                                    </form:select>
                                </div>
                                <div class="form-group">
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
                    <h3 class="box-title">${mUpdate}${' '}${mStudent}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="put" commandName="updateStudent" enctype="application/x-www-form-urlencoded">
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="emailError"><form:errors path="email"/></c:set>
                                <c:set var="passwordError"><form:errors path="password"/></c:set>
                                <c:set var="repeatPasswordError"><form:errors path="repeatPassword"/></c:set>
                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                <c:set var="curriculumError"><form:errors path="curriculum"/></c:set>
                                <form:errors element="div" cssClass="alert alert-danger"/>
                                <form:hidden path="id" class="form-control"/>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty emailError ? 'has-error' : ''}">
                                    <form:errors path="email" element="label"/>
                                    <form:input path="email" class="form-control" placeholder="${mEmail}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty passwordError ? 'has-error' : ''}">
                                    <form:errors path="password" element="label"/>
                                    <form:password path="password" class="form-control" placeholder="${mPassword}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty repeatPasswordError ? 'has-error' : ''}">
                                    <form:errors path="repeatPassword" element="label"/>
                                    <form:password path="repeatPassword" class="form-control" placeholder="${mRepeatPassword}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                    <form:errors path="type" element="label"/>
                                    <form:select path="type" class="type form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mUserType}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${userTypes}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty curriculumError ? 'has-error' : ''}">
                                    <form:errors path="curriculum" element="label"/>
                                    <form:select path="curriculum" class="curriculum form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCurriculum}" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                        <option></option>
                                        <form:options items="${curriculums}"/>
                                    </form:select>
                                </div>
                                <div class="form-group">
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