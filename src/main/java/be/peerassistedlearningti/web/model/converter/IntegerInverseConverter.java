package be.peerassistedlearningti.web.model.converter;

import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Integer into the matching String
 */
public class IntegerInverseConverter implements Converter<Integer, String>
{
    public String convert( Integer integer )
    {
        return String.valueOf( integer );
    }
}
