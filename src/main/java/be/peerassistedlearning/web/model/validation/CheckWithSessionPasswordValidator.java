package be.peerassistedlearning.web.model.validation;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.web.model.util.SessionAuth;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CheckWithSessionPasswordValidator implements ConstraintValidator<CheckWithSessionPassword, String>
{

    public void initialize( CheckWithSessionPassword checkWithSessionPassword ) {}

    public boolean isValid( String password, ConstraintValidatorContext constraintValidatorContext )
    {
        Student current = SessionAuth.getStudent();
        return current.isPasswordValid( password );
    }

}
