$.ajax({
    url: documentRoot + "/admin/applications/count",
    type: "get",
    success: function (count) {
        if (count != 0) {
            $("#application-count").text(count);
        }
    }
});