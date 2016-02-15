package be.peerassistedlearningti.web.model.validation;

import be.peerassistedlearningti.model.Student;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CheckWithSessionPasswordValidator implements ConstraintValidator<CheckWithSessionPassword, String>
{

    public void initialize( CheckWithSessionPassword checkWithSessionPassword )
    {}

    public boolean isValid( String password, ConstraintValidatorContext constraintValidatorContext )
    {
        Student current = (Student) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
        return current.isPasswordValid( password );
    }

}
