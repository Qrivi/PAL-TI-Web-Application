package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Campus;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Campus
 */
public class CampusConverter implements Converter<String, Campus> {
    public Campus convert(String s) {
        return Campus.getByValue(s);
    }
}
