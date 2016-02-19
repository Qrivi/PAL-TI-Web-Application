package be.peerassistedlearningti.web.model.converter;

import org.springframework.core.convert.converter.Converter;

import java.time.LocalTime;

/**
 * Converts a String into the matching LocalTime
 */
public class TimeConverter implements Converter<String, LocalTime>
{
    public LocalTime convert( String s )
    {
        try
        {
            return LocalTime.parse( s );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
