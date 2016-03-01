$( document ).ready( function () {
    $( '#calendar' ).fullCalendar( {
        header      : {
            left   : 'prev,next today' ,
            center : 'title' ,
            right  : 'month,agendaWeek,agendaDay'
        } ,
        height      : window.innerHeight - 90 ,
        editable    : false ,
        eventLimit  : true ,
        events      : "/booking/events" ,
        eventRender : function ( event , element ) {
            element.find( '.fc-title' ).append( "<br/>" + event.description );
        }
    } );

    $( window ).resize( function () {
        var calHeight = window.innerHeight - 90;
        $( '#calendar' ).fullCalendar( 'option' , 'height' , calHeight );
    } );

    setInterval( function () { $( '#calendar' ).fullCalendar( 'refresh' ); } , 60000 );
} );