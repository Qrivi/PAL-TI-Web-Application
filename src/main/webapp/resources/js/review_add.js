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
 * Count characters remaining on the review text field
 */
$(document).ready(function() {
    var text_max = 140;
    $('#review_text_feedback').html(text_max + ' characters remaining');

    $('#review_text').keyup(function() {
        var text_length = $('#review_text').val().length;
        var text_remaining = text_max - text_length;

        $('#review_text_feedback').html(text_remaining + ' characters remaining');
    });
});