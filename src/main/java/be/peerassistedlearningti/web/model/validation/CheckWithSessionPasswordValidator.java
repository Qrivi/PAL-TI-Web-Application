package be.peerassistedlearningti.web.model.validation;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.security.core.context.SecurityContextHolder;

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
