$(document).ready(function () {
    $("#student-overview").DataTable();
    $(".type").select2();
    $(".curriculum").select2();
    $(document).on("click", "#student-overview .update", function () {
        var props = $(this).parent().parent().find("td");
        $("#updateStudent #id").val($(this).attr("data-id"));
        $("#updateStudent #name").val(props[0].textContent);
        $("#updateStudent #email").val(props[1].textContent);
        $("#updateStudent #curriculum").val(props[2].textContent).trigger("change");
        $("#updateStudent #type").val(props[3].textContent).trigger("change");
    });
});