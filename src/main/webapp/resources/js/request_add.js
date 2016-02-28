$(document).ready(function() {
    /**
     * Count characters remaining on the review text field
     */
    var text_max = 300;
    $('#request_text_feedback').html(text_max + ' characters remaining');

    $('#request_text').keyup(function() {
        var text_length = $('#request_text').val().length;
        var text_remaining = text_max - text_length;

        $('#request_text_feedback').html(text_remaining + ' characters remaining');
    });
}