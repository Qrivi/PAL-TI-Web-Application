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
        url     : "/profile/reviews" ,
        success : function ( reviews ) {
            for ( var index in reviews ) {
                var review = reviews[ index ];
                // containers
                var row = $( "<div class='row'></div>" );
                var col = $( "<div class='col-md-12'></div>" );
                // box
                var box = $( "<div class='box box-default'></div>" );
                var box_header = $( "<div class='box-header with-border'></div>" );
                var box_body = $( "<div class='box-body'></div>" );
                var box_footer = $( "<div class='box-footer'></div>" );

                // box-header
                var user_block = $( "<div class='user-block'></div>" );
                var user_img = $( "<img class='profile-user-img img-responsive img-circle' alt='Tutor profile picture'/>" );
                user_img.attr( "src" , "/resources/students/" + review.tutor_id + "/avatar.png" );
                var user_name = $( "<span class='username'><a href='#'>" + review.tutor_name + "</a></span>" );
                var user_desc = $( "<span class='description'>" + review.course_name + " " + moment( new Date( review.lesson_date ) ).format( 'HH:mm DD MMMM  YYYY' ) + "</span>" );
                var user_link = $( "<a class='btn btn-default pull-right'></a>" );
                user_link.attr( "href" , "/profile/reviews/" + review.lesson_id );
                var user_link_icon = review.done ? $( "<i class='fa fa-pencil'></i>" ) : $( "<i class='fa fa-commenting-o'></i>" );

                user_link.append( user_link_icon );
                user_block.append( user_link );
                user_block.append( user_img );
                user_block.append( user_name );
                user_block.append( user_desc );
                box_header.append( user_block );

                // box-body
                var body_title = $( "<strong>" + review.lesson_name + "</strong>" );
                var body_desc = $( "<p>" + review.lesson_description + "</p>" );

                box_body.append( body_title );
                box_body.append( body_desc );

                // box-footer
                if ( review.text != null ) {
                    var footer_row = $( "<div class='row'></div>" );
                    var footer_col_1 = $( "<div class='col-md-1'></div>" );
                    var footer_col_1_row = $( "<div class='row'></div>" );
                    var footer_col_1_row_col = $( "<div class='col-md-offset-2 col-md-10'></div>" );
                    var footer_img = $( "<img class='img-responsive img-circle img-sm'alt='Profile picture'>" );
                    footer_img.attr( "src" , "/resources/students/" + review.student_id + "/avatar.png" );
                    var footer_col_11 = $( "<div class='col-md-11'></div>" );
                    var footer_col_11_row = $( "<div class='img-push row'></div>" );
                    var footer_col_11_row_row = $( "<div class='row'></div>" );
                    var footer_col_11_row_row_col = $( "<div class='col-md-12'></div>" );
                    var footer_text = review.text;

                    footer_col_1_row_col.append( footer_img );
                    footer_col_1_row.append( footer_col_1_row_col );
                    footer_col_1.append( footer_col_1_row );
                    footer_row.append( footer_col_1 );
                    box_footer.append( footer_row );

                    footer_col_11_row_row_col.append( footer_text );
                    footer_col_11_row_row.append( footer_col_11_row_row_col );
                    footer_col_11_row.append( footer_col_11_row_row );
                    footer_col_11.append( footer_col_11_row );

                    footer_row.append( footer_col_1 );
                    footer_row.append( footer_col_11 );
                    box_footer.append( footer_row );
                }

                box.append( box_header );
                box.append( box_body );
                box.append( box_footer );

                col.append( box );
                row.append( col );

                row.hide().appendTo( "#activity" ).fadeIn( 1000 );
            }
        }
    } );
} );
function copyToClipboard ( elementId ) {
    document.getElementById( elementId ).select();
    document.execCommand( "copy" );
}