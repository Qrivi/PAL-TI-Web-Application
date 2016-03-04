package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Room;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Room into the matching String
 */
public class RoomInverseConverter implements Converter<Room, String>
{
    public String convert( Room room )
    {
        try
        {
            return room.getId()
                    .toString();
        } catch ( Exception e )
        {
            return null;
        }
    }
}