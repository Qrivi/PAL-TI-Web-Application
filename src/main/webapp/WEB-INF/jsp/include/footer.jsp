<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="<c:url value="/resources/global.js"/>"></script>
<script>
    $( function () {
        $( "#datetimepicker1" ).datetimepicker( {
            locale : 'nl'
        } );
    } );
</script>