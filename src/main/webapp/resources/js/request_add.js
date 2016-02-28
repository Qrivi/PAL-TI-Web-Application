$(document).ready(function() {
    /**
     * Count characters remaining on the review text field
     */
    var text_max = 300;
    $('#review_text_feedback').html(text_max + ' characters remaining');

    $('#review_text').keyup(function() {
        var text_length = $('#review_text').val().length;
        var text_remaining = text_max - text_length;

        $('#review_text_feedback').html(text_remaining + ' characters remaining');
    });
}