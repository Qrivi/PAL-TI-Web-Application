package be.peerassistedlearning.web.model.validation;

import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CheckCodeIsUniqueValidator implements ConstraintValidator<CheckCodeIsUnique, String>{

    @Autowired
    private PALService service;

    public void initialize( CheckCodeIsUnique checkCodeIsUnique ){
    }

    public boolean isValid( String code, ConstraintValidatorContext constraintValidatorContext ){
        return service.getCourseByCode( code ) == null;
    }
}
