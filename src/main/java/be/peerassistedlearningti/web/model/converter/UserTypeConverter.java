package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.UserType;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching UserType
 */
public class UserTypeConverter implements Converter<String, UserType>
{
    public UserType convert( String s )
    {
        try
        {
            return UserType.getByValue( s );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
