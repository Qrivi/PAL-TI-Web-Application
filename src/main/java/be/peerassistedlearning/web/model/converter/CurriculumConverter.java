package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Curriculum
 */
public class CurriculumConverter implements Converter<String, Curriculum>{
    @Autowired
    private PALService service;

    public Curriculum convert( String s ){
        return service.getCurriculumByName( s );
    }
}
