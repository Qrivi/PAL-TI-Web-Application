$( document ).ready( function () {
    $( "#room-overview" ).DataTable();
    $( ".campus" ).select2();
    $( ".type" ).select2();
    $( "#room-overview .update" ).click( function () {
        var props = $( this ).parent().parent().find( "td" );
        $( "#updateRoom #id" ).val( $( this ).attr( "data-id" ) );
        $( "#updateRoom #name" ).val( props[ 0 ].textContent );
        $( "#updateRoom #campus" ).val( props[ 1 ].textContent );
        $( "#updateRoom #type" ).val( props[ 2 ].textContent );
    } );
} );