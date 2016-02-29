$( document ).ready( function () {
    $( "#subscriptions" ).select2();
    $( function () {
        $( 'a[data-toggle="tab"]' ).on( 'click' , function ( e ) {
            $.cookie( 'last_tab' , $( e.target ).attr( 'href' ) );
        } );
        var lastTab = $.cookie( 'last_tab' );
        if ( lastTab ) {
            $( 'ul.nav-tabs' ).children().removeClass( 'active' );
            $( 'a[href="' + lastTab + '"]' ).parents( 'li:first' ).addClass( 'active' );
            $( 'div.tab-content' ).children().removeClass( 'active' );
            $( lastTab ).addClass( 'active' );
        }
    } );
    $.ajax( {
        url     : "/profile/timeline" ,
        success : function ( timeline ) {
            for ( var index in timeline ) {
                var item = timeline[ index ];
                var html;
                var date = $( "<li class='time-label'><span class='bg-red'>" + moment( new Date( item.archive_date ) ).format( 'DD MMM YYYY' ) + "</span></li>" );
                date.hide().appendTo( ".timeline" ).fadeIn( 1000 );
                if ( item.type == "lesson" )
                    html = $( "<li><i class='fa fa-calendar-check-o bg-blue'></i><div class='timeline-item'><span class='time'><i class='fa fa-clock-o'></i> " + moment( new Date( item.archive_date ) ).format( 'HH:mm' ) + "</span> <h3 class='timeline-header'>Went to " + item.lesson_name + "</h3> <div class='timeline-body'> <div class='row'><div class='col-md-6 col-sm-6 col-xs-12'> <div class='small-box bg-purple'> <div class='inner'> <h3>Course</h3> <p>" + item.course_name + "</p> </div> <div class='icon'> <i class='fa fa-book'></i> </div> </div> </div><div class='col-md-6 col-sm-6 col-xs-12'> <div class='small-box bg-blue'> <div class='inner'> <h3>Tutor</h3> <p>" + item.tutor_name + "</p> </div> <div class='icon'> <i class='fa fa-user'></i> </div> </div> </div><div class='col-md-12 col-sm-12 col-xs-12'> <p>" + item.lesson_description + "</p> </div> </div> </div> </div> </li>" );
                html.hide().appendTo( ".timeline" ).fadeIn( 1000 );
            }
            $( "<li><i class='fa fa-clock-o bg-gray'></i></li>" ).hide().appendTo( ".timeline" ).fadeIn( 1000 );
        }
    } );
    $.ajax( {
        url     : "/profile/reviews" ,
        success : function ( reviews ) {
            for ( var index in reviews ) {
                var review = reviews[ index ];
                var icon = review.done ? "<i class='fa fa-pencil'></i>" : "<i class='fa fa-commenting-o'></i>";
                var footer = review.text != null ? " <div class='box-footer'> <div class='row'> <div class='col-md-1'> <div class='row'> <div class='col-md-offset-2 col-md-10'> <img class='img-responsive img-circle img-sm' src='/resources/students/" + review.student_id + "/avatar.png' alt='Alt Text'> </div> </div> </div> <div class='col-md-11'> <div class='img-push row'> <div class='row'> <div class='col-md-12'> " + review.text + " </div> </div> </div> </div> </div> </div>" : "";
                var html = $( "<div class='row'> <div class='col-md-12'> <div class='box box-default'> <div class='box-header with-border'> <div class='user-block'> <a href='/profile/lesson/" + review.lesson_id + "/reviews/add' class='btn btn-default pull-right'>" + icon + "</a> <img class='profile-user-img img-responsive img-circle' src='/resources/students/" + review.tutor_id + "/avatar.png' alt='User profile picture'> <span class='username'><a href='/profile/" + review.tutor_profile_identifier + "'>" + review.tutor_name + "</a></span> <span class='description'>" + review.course_name + " " + moment( new Date( review.lesson_date ) ).format( 'HH:mm DD MMMM YYYY' ) + "</span> </div></div> <div class='box-body'><strong>" + review.lesson_name + "</strong> <p>" + review.lesson_description + "</p> </div>" + footer + "</div> </div> </div>" );
                html.hide().appendTo( "#activity" ).fadeIn( 1000 );
            }
        }
    } );
} );
function copyToClipboard ( elementId ) {
    document.getElementById( elementId ).select();
    document.execCommand( "copy" );
}