$(document).ready(function() {
    /**
     * Count characters remaining on the review text & title fields
     */
    var text_max = 300;
    var title_max = 50;
    $('#request_text_feedback').html(text_max + ' characters remaining');
    $('#request_title_feedback').html(title_max + ' characters remaining');

    $('#request_text').keyup(function() {
        var text_length = $('#request_text').val().length;
        var text_remaining = text_max - text_length;

        if(text_remaining>=20){
            $("#request_text_feedback").removeClass("label-danger");
            $("#request_text_feedback").removeClass("label-warning");
            $("#request_text_feedback").addClass("label-default");
        }else if(text_remaining<20 && text_remaining!=0){
            $("#request_text_feedback").removeClass("label-default");
            $("#request_text_feedback").removeClass("label-danger");
            $("#request_text_feedback").addClass("label-warning");
        }else {
            $("#request_text_feedback").removeClass("label-default");
            $("#request_text_feedback").removeClass("label-warning");
            $("#request_text_feedback").addClass("label-danger");
        }

        $('#request_text_feedback').html(text_remaining + ' characters remaining');
    });
    $('#request_title').keyup(function() {
        var text_length = $('#request_title').val().length;
        var text_remaining = title_max - text_length;
        if(text_remaining>=5){
            $("#request_title_feedback").removeClass("label-danger");
            $("#request_title_feedback").removeClass("label-warning");
            $("#request_title_feedback").addClass("label-default");
        }else if(text_remaining<5 && text_remaining!=0){
            $("#request_title_feedback").removeClass("label-default");
            $("#request_title_feedback").removeClass("label-danger");
            $("#request_title_feedback").addClass("label-warning");
        }else {
            $("#request_title_feedback").removeClass("label-default");
            $("#request_title_feedback").removeClass("label-warning");
            $("#request_title_feedback").addClass("label-danger");
        }

        $('#request_title_feedback').html(text_remaining + ' characters remaining');
    });
    $('#request_title').focusout(validRequestCheck);
    $('#request_course').focusout(validRequestCheck);


});

function validRequestCheck () {
    var text_length = $('#request_title').val().length;
    if (text_length >= 5 && $("#request_course").val() != "") {
        updateSimilarRequests();
    }
}

function updateSimilarRequests() {
    //Animate loading
    var loading_html = "<div class=\"loading\">\n<i class=\"fa fa-refresh fa-spin\"></i>\n</div>";
    $("#similar_requests").empty();
    $(loading_html).hide().appendTo("#similar_requests").fadeIn(500);

    var request = {
        title: $("#request_title").val(),
        course: $("#request_course").val()
    };
    //Do ajax
    $.ajax({
        url: "/request/similar",
        type: 'POST',
        dataType: 'html',
        data: request,
        success: function (html) {
            $("#similar_requests").find(".loading").fadeOut(1000);
            $(html).hide().appendTo("#similar_requests").fadeIn(1000);
        }
    });
}