package be.peerassistedlearning.web.model.validation;

import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CheckEmailIsUniqueValidator implements ConstraintValidator<CheckEmailIsUnique, String>{

    @Autowired
    private PALService service;

    private boolean allowSessionEmail, inverted;

    public void initialize( CheckEmailIsUnique checkEmailIsUnique ){
        allowSessionEmail = checkEmailIsUnique.allowSessionEmail();
        inverted = checkEmailIsUnique.inverted();
    }

    public boolean isValid( String email, ConstraintValidatorContext constraintValidatorContext ){
        return inverted != ( service.getStudentByEmail( email ) == null || ( allowSessionEmail && SessionAuth.getStudent()
                .getEmail()
                .equals( email ) ) );
    }
}
