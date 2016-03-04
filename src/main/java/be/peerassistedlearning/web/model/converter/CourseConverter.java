package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Room
 */
public class CourseConverter implements Converter<String, Course>
{
    @Autowired
    private PALService service;

    public Course convert( String s )
    {
        try
        {
            return service.getCourseById( Integer.parseInt( s ) );
        } catch ( Exception e )
        {
            return null;
        }
    }
}
