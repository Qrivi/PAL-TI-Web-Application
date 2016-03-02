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
        url     : "/profile/timeline" ,
        success : function ( html ) {
            $( "#timeline" ).find( ".loading" ).fadeOut( 1000 );
            $( html ).hide().appendTo( ".timeline" ).fadeIn( 1000 );
        }
    } );
    $.ajax( {
        url     : "/profile/reviews" ,
        success : function ( html ) {
            $( "#activity" ).find( ".loading" ).fadeOut( 1000 );
            $( html ).hide().appendTo( "#activity" ).fadeIn( 1000 );
        }
    } );
} );
function copyToClipboard ( elementId ) {
    document.getElementById( elementId ).select();
    document.execCommand( "copy" );
}