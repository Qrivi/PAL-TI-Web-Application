package be.peerassistedlearningti.web.model.converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Converts a String into the matching Date
 */
public class DateConverter
{
    public Date convert( String s )
    {
        try
        {
            DateFormat dateFormat = new SimpleDateFormat( "MM/dd/yyyy hh:mm a" );
            return dateFormat.parse( s );
        } catch ( ParseException e )
        {
            return null;
        }
    }
}
