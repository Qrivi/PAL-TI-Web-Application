package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Student;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Student into the matching String
 */
public class StudentInverseConverter implements Converter<Student, String>
{
    public String convert( Student student )
    {
        return student.getId()
                .toString();
    }
}
