package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Campus;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Campus
 */
public class CampusConverter implements Converter<String, Campus>
{
    @Autowired
    private PALService service;

    public Campus convert( String s )
    {
        return service.getCampusByName( s );
    }
}
