$( document ).ready( function () {
    $( "#course-overview" ).DataTable();
    $( "#course-overview .update" ).click( function () {
        var props = $( this ).parent().parent().find( "td" );
        $( "#updateCourse #id" ).val( $( this ).attr( "data-id" ) );
        $( "#updateCourse #code" ).val( props[ 0 ].textContent );
        $( "#updateCourse #name" ).val( props[ 1 ].textContent );
        $( "#updateCourse #shortName" ).val( props[ 2 ].textContent );
        $( "#updateCourse #curriculum" ).val( props[ 3 ].textContent );
        $( "#updateCourse #year" ).val( props[ 4 ].textContent );
    } );
} );