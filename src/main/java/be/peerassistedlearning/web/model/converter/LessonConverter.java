package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Lesson
 */
public class LessonConverter implements Converter<String, Lesson>{
    @Autowired
    private PALService service;

    public Lesson convert( String s ){
        try{
            return service.getLessonById( Integer.parseInt( s ) );
        }catch( Exception e ){
            return null;
        }
    }
}

