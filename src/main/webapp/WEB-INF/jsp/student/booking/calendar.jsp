<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="content">
    <div class="row">
        <div class="col-md-3">
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h4 class="box-title">Filter</h4>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="course">Course :</label>
                            <select id="course" class="form-control select2 select2-hidden-accessible" multiple="multiple"
                                    data-placeholder="Courses" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                <option value="">--- Course ---</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.id}">${course.shortName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <label for="tutors">Tutors :</label>
                            <div id="tutors"></div>
                        </div>
                        <div class="col-md-12">
                            <span id="results">0</span> result(s)
                        </div>
                    </div>
                </div>
            </div>
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h4 class="box-title">Legend</h4>
                </div>
                <div class="box-body">
                    <div id="external-events">
                        <div class="bg-green legend-item">Registered</div>
                        <div class="bg-light-blue legend-item">Unregistered</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="box box-primary no-margin">
                <div class="box-body no-padding">
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal" id="booking-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 id="booking-title" class="modal-title">Booking</h4>
            </div>
            <div class="modal-body">
                <p id="booking-description"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button id="booking-unregister" type="button" class="btn btn-primary" data-dismiss="modal">Unregister</button>
                <button id="booking-register" type="button" class="btn btn-primary" data-dismiss="modal">Register</button>
            </div>
        </div>
    </div>
</div>
