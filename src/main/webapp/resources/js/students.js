$( document ).ready( function () {
    $( "#student-overview" ).DataTable();
    $( ".curriculum" ).select2();
    $( "#student-overview .update" ).click( function () {
        var props = $( this ).parent().parent().find( "td" );
        $( "#updateStudent #id" ).val( $( this ).attr( "data-id" ) );
        $( "#updateStudent #name" ).val( props[ 0 ].textContent );
        $( "#updateStudent #email" ).val( props[ 1 ].textContent );
        $( "#updateStudent #curriculum" ).val( props[ 2 ].textContent );
        $( "#updateStudent #type" ).val( props[ 3 ].textContent );
    } );
} );