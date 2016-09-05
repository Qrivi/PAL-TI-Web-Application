$(document).ready(function () {
    $("#subscriptions").select2();
    $(function () {
        $('a[data-toggle="tab"]').on('click', function (e) {
            $.cookie('last_tab', $(e.target).attr('href'));
        });
        var lastTab = $.cookie('last_tab');

        if (lastTab && $('a[href="' + lastTab + '"]').length > 0)
            setActiveTab(lastTab);
        else {
            setActiveTab("#timeline");
        }
    });

    function setActiveTab(tab) {
        $('ul.nav-tabs').children().removeClass('active');
        $('a[href="' + tab + '"]').parents('li:first').addClass('active');
        $('div.tab-content').children().removeClass('active');
        $(tab).addClass('active');
    }

    var timelineTotal = 4;
    var timelineLimit = 3;
    var timelineElement;

    loadTimeline();

    $("#timeline").on("click", ".load-more button", function () {
        loadTimeline();
    });

    function loadTimeline() {
        $("#timeline").find(".loading").show();
        $("#timeline").find(".timeline").hide();
        $.ajax({
            url: window.location.href.split('?')[0] + "/timeline",
            type: "get",
            data: {
                "offset": 0,
                "limit": timelineTotal + timelineLimit
            },
            success: function (html) {
                var items = $(html).find(".timeline-item").length;

                $("#timeline").find(".loading").fadeOut(1000);
                $("#timeline").find(".timeline").delay(1000).fadeIn(1000);

                $(timelineElement).remove();
                timelineElement = $(html);
                $(timelineElement).hide().prependTo(".timeline").delay(1000).fadeIn(1000);

                if (items <= timelineTotal) {
                    $("#timeline").find(".load-more").remove();
                }
                else {
                    timelineTotal = items;
                }
                $(".rating").each(function () {
                    $(this).rateYo({
                        rating: $(this).data("rating"),
                        maxValue: 10,
                        halfStar: true,
                        readOnly: true
                    });
                });
            }
        });
    }


    var reviewsTotal = 0;
    var reviewsLimit = 4;

    loadReviews();

    $("#reviews").on("click", ".load-more button", function () {
        loadReviews();
    });

    function loadReviews() {
        $.ajax({
            url: documentRoot + "/profile/reviews",
            type: "get",
            data: {
                "offset": reviewsTotal,
                "limit": reviewsLimit
            },
            success: function (html) {
                var reviews = $(html).find(".review").length;
                if (reviews > 0) {
                    reviewsTotal += reviews;
                    $("#reviews").find(".loading").fadeOut(1000);
                    $("#reviews").find(".load-more").remove();
                    $(html).hide().appendTo("#reviews").delay(1000).fadeIn(1000);
                }
                else if (reviewsTotal == 0) {
                    $("#reviews").find(".loading").fadeOut(1000);
                    $(html).hide().appendTo("#reviews").delay(1000).fadeIn(1000);
                }
                else {
                    $("#reviews").find(".load-more").remove();
                }
                if (reviews < reviewsLimit) {
                    $("#reviews").find(".load-more").remove();
                }
                $(".rating").each(function () {
                    $(this).rateYo({
                        rating: $(this).data("rating"),
                        maxValue: 10,
                        halfStar: true,
                        readOnly: true
                    });
                });
            }
        });
    }
});
function copyToClipboard(elementId) {
    document.getElementById(elementId).select();
    document.execCommand("copy");
}