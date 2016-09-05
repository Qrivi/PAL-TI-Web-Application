<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="Room.room" var="mRoom"/>
<spring:message code="Room.rooms" var="mRooms"/>
<spring:message code="Room.name" var="mName"/>
<spring:message code="Room.campus" var="mCampus"/>
<spring:message code="Room.campuses" var="mCampuses"/>
<spring:message code="Room.type" var="mType"/>
<spring:message code="Room.roomTypes" var="mRoomTypes"/>
<spring:message code="Room.overview" var="mOverview"/>

<spring:message code="Actions.actions" var="mActions"/>
<spring:message code="Actions.add" var="mAdd"/>
<spring:message code="Actions.edit" var="mEdit"/>
<spring:message code="Actions.update" var="mUpdate"/>
<spring:message code="Actions.delete" var="mDelete"/>
<spring:message code="Actions.create" var="mCreate"/>
<spring:message code="Actions.collapse" var="mCollapse"/>

<section class="content-header">
    <h1>
        ${mRooms}
    </h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${mOverview}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="room-overview" class="table table-striped table-bordered" cellspacing="0"
                                   width="100%">
                                <thead>
                                <tr>
                                    <th>${mName}</th>
                                    <th>${mCampus}</th>
                                    <th>${mType}</th>
                                    <th data-orderable="false">${mActions}</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>${mName}</th>
                                    <th>${mCampus}</th>
                                    <th>${mType}</th>
                                    <th>${mActions}</th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td>${room.name}</td>
                                        <td>${room.campus}</td>
                                        <td>${room.type}</td>
                                        <td>
                                            <form class="small" action="<c:url value="/admin/rooms" />" method="POST">
                                                <input type="hidden" name="_method" value="delete"/>
                                                <input type="hidden" name="id" value="${room.id}"/>
                                                <button class="btn btn-sm" data-toggle="tooltip"
                                                        title="${mDelete}">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </form>
                                            <button class="btn btn-sm update" data-id="${room.id}"
                                                    data-toggle="tooltip" title="${mEdit}">
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
                    <h3 class="box-title">${mCreate}${' '}${mRoom}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="post" commandName="room" enctype="application/x-www-form-urlencoded">
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="campusError"><form:errors path="campus"/></c:set>
                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty campusError ? 'has-error' : ''}">
                                    <form:errors path="campus" element="label"/>
                                    <form:select path="campus"
                                                 class="campus form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCampuses}" style="width: 100%;" tabindex="-1"
                                                 aria-hidden="true">
                                        <option></option>
                                        <form:options items="${campuses}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                    <form:errors path="type" element="label"/>
                                    <form:select path="type" class="type form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mRoomTypes}" style="width: 100%;" tabindex="-1"
                                                 aria-hidden="true">
                                        <option></option>
                                        <form:options items="${roomTypes}"/>
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
                    <h3 class="box-title">${mUpdate}${' '}${mRoom}</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                                title="${mCollapse}">
                            <i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form method="put" commandName="updateRoom"
                                       enctype="application/x-www-form-urlencoded">
                                <c:set var="nameError"><form:errors path="name"/></c:set>
                                <c:set var="campusError"><form:errors path="campus"/></c:set>
                                <c:set var="typeError"><form:errors path="type"/></c:set>
                                <form:hidden path="id" class="form-control"/>
                                <div class="form-group has-feedback ${ not empty nameError ? 'has-error' : ''}">
                                    <form:errors path="name" element="label"/>
                                    <form:input path="name" class="form-control" placeholder="${mName}"/>
                                </div>
                                <div class="form-group has-feedback ${ not empty campusError ? 'has-error' : ''}">
                                    <form:errors path="campus" element="label"/>
                                    <form:select path="campus"
                                                 class="campus form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mCampuses}" style="width: 100%;" tabindex="-1"
                                                 aria-hidden="true">
                                        <option></option>
                                        <form:options items="${campuses}"/>
                                    </form:select>
                                </div>
                                <div class="form-group has-feedback ${ not empty typeError ? 'has-error' : ''}">
                                    <form:errors path="type" element="label"/>
                                    <form:select path="type" class="type form-control select2 select2-hidden-accessible"
                                                 data-placeholder="${mRoomTypes}" style="width: 100%;" tabindex="-1"
                                                 aria-hidden="true">
                                        <option></option>
                                        <form:options items="${roomTypes}"/>
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