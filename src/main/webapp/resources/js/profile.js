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
    $.ajax( {
        url     : window.location.href + "/timeline" ,
        type    : "get" ,
        data    : {
            "offset" : 0 ,
            "limit"  : 2
        } ,
        success : function ( html ) {
            $( "#timeline" ).find( ".loading" ).fadeOut( 1000 );
            $( html ).hide().appendTo( ".timeline" ).fadeIn( 1000 );
        }
    } );

    var reviewOffset = 0;
    loadReviews( reviewOffset );

    $( "#reviews" ).on( "click" , ".load-more button" , function () {
        console.log( "zezeze" );
        loadReviews( reviewOffset );
        reviewOffset += 1;
    } );

    function loadReviews ( offset ) {
        $.ajax( {
            url     : "/profile/reviews" ,
            type    : "get" ,
            data    : {
                "offset" : offset ,
                "limit"  : 1
            } ,
            success : function ( html ) {
                $( "#reviews" ).find( ".loading" ).fadeOut( 1000 );
                $( "#reviews" ).find( ".load-more" ).remove();
                $( html ).hide().appendTo( "#reviews" ).fadeIn( 1000 );
            }
        } );
    }
} );
function copyToClipboard ( elementId ) {
    document.getElementById( elementId ).select();
    document.execCommand( "copy" );
}