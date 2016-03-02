<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="content">
    <div class="row">
        <div class="col-md-2">
            <div class="box box-primary no-margin">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label path="course">Course :</label>
                            <select id="course" class="form-control select2 select2-hidden-accessible" multiple="multiple"
                                    data-placeholder="Courses" style="width: 100%;" tabindex="-1" aria-hidden="true">
                                <option value="">--- Course ---</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.id}" selected="selected">${course.shortName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <input id="filter" type="submit" value="Filter" class="form-control btn btn-primary btn-block"/>
                        </div>
                        <div class="col-md-12">
                            <span id="results">0</span> result(s)
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-10">
            <div class="box box-primary no-margin">
                <div class="box-body no-padding">
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
    </div>
</section>
