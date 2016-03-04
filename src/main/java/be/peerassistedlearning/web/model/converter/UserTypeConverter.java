package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.UserType;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching UserType
 */
public class UserTypeConverter implements Converter<String, UserType>
{
    @Autowired
    PALService service;

    public UserType convert( String s )
    {
        try
        {
            return service.getStudentTypeByString( s );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
