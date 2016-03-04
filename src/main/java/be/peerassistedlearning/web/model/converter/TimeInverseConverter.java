package be.peerassistedlearning.web.model.converter;

import org.springframework.core.convert.converter.Converter;

import java.time.LocalTime;

/**
 * Converts a LocalTime into the matching String
 */
public class TimeInverseConverter implements Converter<LocalTime, String>
{
    public String convert( LocalTime localTime )
    {
        try
        {
            return localTime.toString();
        } catch ( Exception e )
        {
            return null;
        }
    }
}
