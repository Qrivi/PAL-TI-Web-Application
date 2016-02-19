package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Course;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Course into the matching String
 */
public class CourseInverseConverter implements Converter<Course, String>
{
    public String convert( Course course )
    {
        try
        {
            return course.getId()
                    .toString();
        } catch ( Exception e )
        {
            return null;
        }
    }
}