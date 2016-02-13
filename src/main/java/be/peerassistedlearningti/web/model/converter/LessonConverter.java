package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Lesson
 */
public class LessonConverter implements Converter<String, Lesson>
{
    @Autowired
    private PALService service;

    public Lesson convert( String s )
    {
        return service.getLessonById( Integer.parseInt( s ) );
    }
}

