$( document ).ready( function () {
    $( "#pending-application-overview" ).DataTable();
    $( "#done-application-overview" ).DataTable();
    $( "#pending-application-overview .screenshot" ).click( function () {
        $( '#screenshot-modal' ).modal( 'show' );
        var url = $( this ).attr( "data-url" );
        $( "#screenshot" ).attr( "src" , url );
        $( "#screenshot-url" ).attr( "href" , url );
    } );
    $( "#screenshot" ).fancybox( {
        afterClose : function () {
            $( "#screenshot" ).css( "display" , "block" );
        }
    } );
} );