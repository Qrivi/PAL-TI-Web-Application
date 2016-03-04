package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Student;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Student into the matching String
 */
public class StudentInverseConverter implements Converter<Student, String>
{
    public String convert( Student student )
    {
        try
        {
            return student.getId()
                    .toString();
        } catch ( Exception e )
        {
            return null;
        }
    }
}
