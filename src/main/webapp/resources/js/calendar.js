$( document ).ready( function () {
    $( '#calendar' ).fullCalendar( {
        header     : {
            left   : 'prev,next today' ,
            center : 'title' ,
            right  : 'month,agendaWeek,agendaDay'
        } ,
        editable   : false ,
        eventLimit : true ,
        events     : "/calendar/events"
    } );
    setInterval( function () { $( '#calendar' ).fullCalendar( 'refresh' ); } , 60000 );
} );