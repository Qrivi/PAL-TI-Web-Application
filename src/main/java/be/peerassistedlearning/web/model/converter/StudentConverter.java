package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Student
 */
public class StudentConverter implements Converter<String, Student>{
    @Autowired
    private PALService service;

    public Student convert( String s ){
        try{
            return service.getStudentById( Integer.parseInt( s ) );
        }catch( Exception e ){
            return null;
        }
    }
}
