package be.peerassistedlearningti.web.model.converter;


import be.peerassistedlearningti.model.RoomType;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching RoomType
 */
public class RoomTypeConverter implements Converter<String, RoomType> {
    public RoomType convert(String s) {
        return RoomType.getByValue(s);
    }
}
