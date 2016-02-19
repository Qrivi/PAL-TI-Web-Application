package be.peerassistedlearningti.web.model.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;

/**
 * Converts a String into the matching LocalTime
 */
public class TimeInverseConverter implements Converter<LocalTime, String>
{
    public String convert( LocalTime t )
    {
        try
        {
            DateFormat dateFormat = new SimpleDateFormat( "hh:mm" );
            return dateFormat.format( t );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
