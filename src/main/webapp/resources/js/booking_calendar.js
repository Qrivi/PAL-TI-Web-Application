$( document ).ready( function () {

    $( "#course" ).select2();

    // Calendar

    var calendar = {
        container     : $( '#calendar' ) ,
        events        : [] ,
        filters       : [] ,
        tutors        : [] ,
        selectedEvent : undefined ,
        fEvents       : function () {
            var filtered = [];
            for ( var j in calendar.filters ) {
                for ( var i in calendar.events ) {
                    var event = calendar.events[ i ];
                    if ( event.tutor_name == calendar.filters[ j ] )
                        filtered.push( event );
                }
            }
            return filtered;
        } ,
        addFilter     : function ( tutor ) {
            var i = calendar.filters.indexOf( tutor );
            if ( i == -1 )
                calendar.filters.push( tutor );
            calendar.refresh();
        } ,
        removeFilter  : function ( tutor ) {
            var i = calendar.filters.indexOf( tutor );
            if ( i > 0 )
                calendar.filters.splice( i , 1 );
            calendar.refresh();
        } ,
        refresh       : function () {
            calendar.container.fullCalendar( 'removeEvents' );
            calendar.container.fullCalendar( 'addEventSource' , calendar.fEvents() );
            calendar.container.fullCalendar( 'rerenderEvents' );
        } ,
        register      : function () {
            if ( calendar.selectedEvent == undefined ) return;
            $.ajax( {
                url     : "/booking/register/" + calendar.selectedEvent.id ,
                type    : "post" ,
                success : function ( response ) {
                    lookup();
                }
            } );
        } ,
        unregister    : function () {
            if ( calendar.selectedEvent == undefined ) return;
            $.ajax( {
                url     : "/booking/unregister/" + calendar.selectedEvent.id ,
                type    : "post" ,
                success : function ( response ) {
                    lookup();
                }
            } );
        }
    };

    // Show calendar

    calendar.container.fullCalendar( {
        header      : {
            left   : 'prev,next today' ,
            center : 'title' ,
            right  : 'month,agendaWeek,agendaDay'
        } ,
        height      : window.innerHeight - 90 ,
        editable    : false ,
        eventLimit  : false ,
        eventRender : function ( event , element ) {
            $( '#results' ).text( calendar.fEvents().length );
            element.find( '.fc-title' ).append( '<br/>' + event.description + '<br />' + event.tutor_name );
            element.click( function () {
                calendar.selectedEvent = event;
                showModal( event );
            } );
        }
    } );

    // Resize calendar

    $( window ).resize( function () {
        var calHeight = window.innerHeight - 90;
        $( '#calendar' ).fullCalendar( 'option' , 'height' , calHeight );
    } );

    // Show modal

    function showModal ( event ) {
        $( '#booking-modal' ).modal( 'show' );
        $( '#booking-title' ).text( event.title );
        $( '#booking-description' ).text( event.description );
        if ( event.registered ) {
            $( '#booking-unregister' ).show();
            $( '#booking-register' ).hide();
            $( '#booking-unregister' ).click( function () {
                calendar.unregister();
            } );
        }
        else {
            $( '#booking-register' ).show();
            $( '#booking-unregister' ).hide();
            $( '#booking-register' ).click( function () {
                calendar.register();
            } );
        }
    }

    function addTutor ( name ) {
        var id = name.replace( /\s/g , "-" ).toLowerCase();
        if ( $( "#" + id ).length == 0 ) {
            var wrapper = $( "<div class='checkbox icheck'></div>" );
            var label = $( "<label for='" + id + "'></label>" );
            var input = $( "<input type='checkbox' id='" + id + "' data-id='" + name + "'/>" );
            var text = $( "<span>" + name + "</span>" );

            input.appendTo( label );
            text.appendTo( label );
            label.appendTo( wrapper );
            wrapper.appendTo( $( "#tutors" ) );

            calendar.addFilter( name );

            $( "#" + id ).iCheck( {
                checkboxClass : 'icheckbox_square-blue' ,
                radioClass    : 'iradio_square-blue' ,
                increaseArea  : '20%'
            } );

            $( "#" + id ).on( 'ifChanged' , function ( e ) { $( e.target ).trigger( 'change' ); } );
            $( "#" + id ).iCheck( 'check' );

            $( "#" + id ).on( 'change' , function ( e ) {
                var tutor = $( e.target ).attr( "data-id" );
                var checked = $( e.target ).is( ':checked' );
                if ( checked )
                    calendar.addFilter( tutor );
                else
                    calendar.removeFilter( tutor );
            } );
        }
        if ( calendar.tutors.indexOf( name ) == -1 )
            calendar.tutors.push( name );
    }

    // Lookup

    function lookup () {
        var courses = $( "#course" ).val();
        $.ajax( {
            url     : "/booking/calendar/events" ,
            type    : "get" ,
            data    : {
                courses : courses.join()
            } ,
            success : function ( events ) {
                calendar.events = events.slice( 0 );
                var tutors = [];
                for ( var index in events ) {
                    var event = events[ index ];
                    addTutor( event.tutor_name );
                    tutors.push( event.tutor_name );
                }
                calendar.tutors.forEach( function ( tutor ) {
                    var index = tutors.indexOf( tutor );
                    if ( index == -1 ) {
                        calendar.removeFilter( tutor );
                        var id = tutor.replace( /\s/g , "-" ).toLowerCase();
                        $( "#" + id ).parent().parent().parent().remove();
                    }
                } );
                calendar.refresh();
            }
        } );
    }

    // Filter

    $( "#course" ).change( function () {
        lookup();
    } );
} );