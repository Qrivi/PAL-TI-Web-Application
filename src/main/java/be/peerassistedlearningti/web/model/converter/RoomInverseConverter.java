package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Room;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Room into the matching String
 */
public class RoomInverseConverter implements Converter<Room, String>
{
    public String convert( Room room )
    {
        return room.getId()
                .toString();
    }
}