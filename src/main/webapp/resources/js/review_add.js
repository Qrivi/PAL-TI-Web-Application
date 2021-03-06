/**
 * Enables the ICheck plugin
 */

$(function () {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%'
    });
    $('input').on('ifChanged', function (event) {
        $(event.target).trigger('change');
    });
});


$(document).ready(function () {

    /**
     * creates the star rating
     */
    $("#contentScore").rateYo({
        rating: $("#contentScoreInput").val(),
        maxValue: 10,
        halfStar: true
    });
    $("#atmosphereScore").rateYo({
        rating: $("#atmosphereScoreInput").val(),
        maxValue: 10,
        halfStar: true
    });
    $("#tutorScore").rateYo({
        rating: $("#tutorScoreInput").val(),
        maxValue: 10,
        halfStar: true
    });
    $("#engagementScore").rateYo({
        rating: $("#engagementScoreInput").val(),
        maxValue: 10,
        halfStar: true
    });

    $("#submitReview").click(function () {
        var $content = $("#contentScore").rateYo();
        var $atmosphere = $("#atmosphereScore").rateYo();
        var $tutor = $("#tutorScore").rateYo();
        var $engagement = $("#engagementScore").rateYo();

        $("#contentScoreInput").val($content.rateYo("rating"));
        $("#atmosphereScoreInput").val($atmosphere.rateYo("rating"));
        $("#tutorScoreInput").val($tutor.rateYo("rating"));
        $("#engagementScoreInput").val($engagement.rateYo("rating"));
    });

    /**
     * Count characters remaining on the review text field
     */
    var text_max = 140;
    $('#review_text_feedback').html(text_max + ' characters remaining');

    $('#review_text').keyup(function () {
        var text_length = $('#review_text').val().length;
        var text_remaining = text_max - text_length;

        if (text_remaining >= 20) {
            $("#review_text_feedback").removeClass("label-danger");
            $("#review_text_feedback").removeClass("label-warning");
            $("#review_text_feedback").addClass("label-default");
        } else if (text_remaining < 20 && text_remaining != 0) {
            $("#review_text_feedback").removeClass("label-default");
            $("#review_text_feedback").removeClass("label-danger");
            $("#review_text_feedback").addClass("label-warning");
        } else {
            $("#review_text_feedback").removeClass("label-default");
            $("#review_text_feedback").removeClass("label-warning");
            $("#review_text_feedback").addClass("label-danger");
        }

        $('#review_text_feedback').html(text_remaining + ' characters remaining');
    });
});

