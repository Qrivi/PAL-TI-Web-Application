$( document ).ready( function () {
    $( "#subscriptions" ).select2();
    $( function () {
        $( 'a[data-toggle="tab"]' ).on( 'click' , function ( e ) {
            $.cookie( 'last_tab' , $( e.target ).attr( 'href' ) );
        } );
        var lastTab = $.cookie( 'last_tab' );
        if ( lastTab ) {
            $( 'ul.nav-tabs' ).children().removeClass( 'active' );
            if ( $( 'a[href="' + lastTab + '"]' ).length == 0 )
                lastTab = "#timeline";
            $( 'a[href="' + lastTab + '"]' ).parents( 'li:first' ).addClass( 'active' );
            $( 'div.tab-content' ).children().removeClass( 'active' );
            $( lastTab ).addClass( 'active' );
        }
    } );


    var totalTimeline = 1;
    var timeline;
    loadTimeline();

    $( "#timeline" ).on( "click" , ".load-more button" , function () {
        loadTimeline();
    } );

    function loadTimeline () {
        $.ajax( {
            url     : window.location.href + "/timeline" ,
            type    : "get" ,
            data    : {
                "offset" : 0 ,
                "limit"  : totalTimeline + 1
            } ,
            success : function ( html ) {
                $( "#timeline" ).find( ".loading" ).fadeOut( 1000 );
                var count = $( $.parseHTML( html ) ).find( ".timeline-item" ).length;
                console.log( count + " " + totalTimeline );
                $( timeline ).remove();
                timeline = $( html );
                $( timeline ).hide().prependTo( ".timeline" ).fadeIn( 1000 );
                if ( count == totalTimeline ) {
                    console.log( $( "#timeline" ).find( ".load-more" ) );
                    $( "#timeline" ).find( ".load-more" ).remove();
                }
                else {
                    totalTimeline = count;
                }
                $( ".rating" ).each( function () {
                    $( this ).rateYo( {
                        rating   : $( this ).data( "rating" ) ,
                        maxValue : 10 ,
                        halfStar : true ,
                        readOnly : true
                    } );
                } );
            }
        } );
    }


    var totalReviews = 0;
    loadReviews();

    $( "#reviews" ).on( "click" , ".load-more button" , function () {
        loadReviews();
    } );

    function loadReviews () {
        $.ajax( {
            url     : "/profile/reviews" ,
            type    : "get" ,
            data    : {
                "offset" : totalReviews ,
                "limit"  : 4
            } ,
            success : function ( html ) {
                var reviews = $( $.parseHTML( html ) ).find( ".review" ).length;
                if ( reviews > 0 ) {
                    totalReviews += reviews;
                    $( "#reviews" ).find( ".loading" ).fadeOut( 1000 );
                    $( "#reviews" ).find( ".load-more" ).remove();
                    $( html ).hide().appendTo( "#reviews" ).fadeIn( 1000 );
                }
                else if ( totalReviews == 0 ) {
                    $( "#reviews" ).find( ".loading" ).fadeOut( 1000 );
                    $( html ).hide().appendTo( "#reviews" ).fadeIn( 1000 );
                }
                else {
                    $( "#reviews" ).find( ".load-more" ).remove();
                }
            }
        } );
    }
} );
function copyToClipboard ( elementId ) {
    document.getElementById( elementId ).select();
    document.execCommand( "copy" );
}