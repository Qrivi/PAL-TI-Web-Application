package be.peerassistedlearningti.web.model.converter;


import be.peerassistedlearningti.model.RoomType;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching RoomType
 */
public class RoomTypeConverter implements Converter<String, RoomType>
{
    @Autowired
    private PALService service;

    public RoomType convert( String s )
    {
        try
        {
            return service.getRoomTypeByString( s );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
