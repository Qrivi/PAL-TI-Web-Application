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

/**
 * Enables the 'Remember Me' functionality
 */

$(document).ready(function () {
    if ($('#remember-me').length == 0)
        return;

    if ($.cookie('remember') !== undefined) {
        $('#studentId').val($.cookie('remember'));
        $('input').iCheck('check');
    }

    $('#studentId, #remember-me').change(function () {
        if ($('#remember-me').is(':checked'))
            $.cookie('remember', $('#studentId').val(), {expires: 14});
        else
            $.removeCookie('remember');
    });
});