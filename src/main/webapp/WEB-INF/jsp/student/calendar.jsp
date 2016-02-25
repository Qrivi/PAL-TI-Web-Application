<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="../include/head.jsp">
        <jsp:param value="Calendar" name="title"/>
    </jsp:include>
    <body class="hold-transition skin-blue">
        <div class="wrapper">
            <jsp:include page="../include/menu/main-header.jsp"/>
            <jsp:include page="../include/menu/sidebar.jsp">
                <jsp:param value="calendar" name="title"/>
            </jsp:include>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Calendar
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-body no-padding">
                                    <div id="calendar"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp"/>
        <script type="application/javascript">
            $( document ).ready( function () {
                $( '#calendar' ).fullCalendar( {
                    header     : {
                        left   : 'prev,next today' ,
                        center : 'title' ,
                        right  : 'month,agendaWeek,agendaDay'
                    } ,
                    editable   : false ,
                    eventLimit : true ,
                    events     : [
                        <c:forEach var="item" items="${bookings}" varStatus="loop">
                        <jsp:useBean id="dateValue" class="java.util.Date"/>
                        <jsp:setProperty name="dateValue" property="time" value="${(item.date.time + item.duration*60*1000)}"/>
                        <fmt:formatDate var="start" pattern="YYYY-MM-dd HH:mm:SS" value="${item.date}"/>
                        <fmt:formatDate var="end" pattern="YYYY-MM-dd HH:mm:SS" value="${dateValue}"/>
                        {
                            title : '${item.name}' ,
                            start : '${start}' ,
                            end   : '${end}'
                        }
                        <c:if test="${loop.index < bookings.size() - 1}"> ,
                        </c:if>
                        </c:forEach>
                    ]
                } );
            } );
        </script>
    </body>
</html>