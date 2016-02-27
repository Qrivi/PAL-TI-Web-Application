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