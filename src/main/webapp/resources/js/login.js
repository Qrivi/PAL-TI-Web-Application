/**
 * Enables the ICheck plugin
 */

$( function () {
    $( 'input' ).iCheck( {
        checkboxClass : 'icheckbox_square-blue' ,
        radioClass    : 'iradio_square-blue' ,
        increaseArea  : '20%'
    } );
    $( 'input' ).on( 'ifChanged' , function ( event ) { $( event.target ).trigger( 'change' ); } );
} );

/**
 * Enables the 'Remember Me' functionality
 */

$( document ).ready( function () {
    var rCookie = $.cookie( "remember" ) === 'true';
    var eCookie = ($.cookie( "email" ) === undefined) ? "" : $.cookie( "email" );
    var rElement = $( "#remember-me" );
    var eElement = $( "#email" );

    if ( rElement.length == 0 )
        return;

    if ( rCookie ) {
        $( eElement ).val( eCookie );
        $( 'input' ).iCheck( 'check' );
    }

    $( rElement ).change( function () { remember(); } );
    $( eElement ).change( function () { remember(); } );

    function remember () {
        if ( $( rElement ).is( ':checked' ) ) {
            $.cookie( "email" , $( eElement ).val() , { expires : 14 } );
            $.cookie( "remember" , true , { expires : 14 } );
        }
        else {
            $.cookie( "email" , null );
            $.cookie( "remember" , null );
        }
    }
} );