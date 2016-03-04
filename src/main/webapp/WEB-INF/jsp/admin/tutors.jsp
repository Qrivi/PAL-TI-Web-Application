<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="Tutor.tutor" var="mTutor"/>
<spring:message code="Tutor.tutors" var="mTutors"/>
<spring:message code="Tutor.course" var="mCourse"/>
<spring:message code="Tutor.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mTutors}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOverview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"
                                data-toggle="tooltip" title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="tutor-overview" class="table table-striped table-bordered"
                                   cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>${mTutor}</th>
                                        <th>${mCourse}</th>
                                        <th data-orderable="false">${mActions}</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>${mTutor}</th>
                                        <th>${mCourse}</th>
                                        <th>${mActions}</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="tutor" items="${tutors}">
                                        <tr>
                                            <td>${tutor.student.name}</td>
                                            <td>
                                                <ul>
                                                    <c:forEach var="course" items="${tutor.courses}">
                                                        <li>${course.name}</li>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                            <td>
                                                <form class="small" action="<c:url value="/admin/tutors" />"
                                                      method="POST">
                                                    <input type="hidden" name="_method" value="delete"/>
                                                    <input type="hidden" name="id" value="${tutor.id}"/>
                                                    <button class="btn btn-sm"><i class="fa fa-trash" data-toggle="tooltip" title="${mDelete}"></i>
                                                    </button>
                                                </form>
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
</section>