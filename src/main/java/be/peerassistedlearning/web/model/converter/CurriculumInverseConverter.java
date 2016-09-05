package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Curriculum;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Curriculum into the matching String
 */
public class CurriculumInverseConverter implements Converter<Curriculum, String>{
    @Override
    public String convert( Curriculum curriculum ){
        return curriculum.getName();
    }
}
