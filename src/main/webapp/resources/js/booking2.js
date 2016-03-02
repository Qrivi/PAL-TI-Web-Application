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
            $( "#results" ).text( parseInt( $( "#results" ).text() ) + 1 );
            element.find( '.fc-title' ).append( "<br/>" + event.description );
        }
    } );

    $( window ).resize( function () {
        var calHeight = window.innerHeight - 90;
        $( '#calendar' ).fullCalendar( 'option' , 'height' , calHeight );
    } );

    setInterval( function () { $( '#calendar' ).fullCalendar( 'refresh' ); } , 60000 );

    $( "#course" ).select2();

    $( "#filter" ).click( function () {
        var courses = $( "#course" ).val();
        console.log( courses.join() );
        $.ajax( {
            url     : "/booking/events" ,
            type    : "get" ,
            data    : {
                courses : courses.join()
            } ,
            success : function ( events ) {
                $( "#results" ).text( "0" );
                $( '#calendar' ).fullCalendar( 'removeEvents' );
                $( '#calendar' ).fullCalendar( 'addEventSource' , events );
                $( '#calendar' ).fullCalendar( 'rerenderEvents' );
            }
        } );
    } );
} );