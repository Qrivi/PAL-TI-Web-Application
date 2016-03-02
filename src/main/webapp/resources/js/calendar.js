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
        events      : "/calendar/events" ,
        eventRender : function ( event , element ) {
            var title = $( "<span class='title'>" + event.course_name + " - " + element.find( '.fc-title' ).text() + "</span>" );
            element.find( '.fc-title' ).html( title );
            element.find( '.fc-title' ).append( '<br/><br/>' + event.description + '<br/><br/>' + event.tutor_name );
        }
    } );

    $( window ).resize( function () {
        var calHeight = window.innerHeight - 90;
        $( '#calendar' ).fullCalendar( 'option' , 'height' , calHeight );
    } );

    setInterval( function () { $( '#calendar' ).fullCalendar( 'refresh' ); } , 60000 );
} );