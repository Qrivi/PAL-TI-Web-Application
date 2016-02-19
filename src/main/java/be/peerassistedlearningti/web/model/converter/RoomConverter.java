package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Room;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Room
 */
public class RoomConverter implements Converter<String, Room>
{
    @Autowired
    private PALService service;

    public Room convert( String s )
    {
        try
        {
            return service.getRoomById( Integer.parseInt( s ) );
        } catch ( Exception e )
        {
            return null;
        }
    }
}