$.ajax( {
    url     : "/admin/applications/count" ,
    type    : "get" ,
    success : function ( count ) {
        $( "#application-count" ).text( count );
    }
} );