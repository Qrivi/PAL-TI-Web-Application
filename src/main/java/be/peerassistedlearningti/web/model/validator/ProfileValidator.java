package be.peerassistedlearningti.web.model.validator;

import be.peerassistedlearningti.web.model.ProfileForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Validator for the ProfileForm class
 */
public class ProfileValidator implements Validator
{

    public boolean supports( Class c )
    {
        return ProfileForm.class.equals( c );
    }

    public void validate( Object target, Errors errors )
    {
        ProfileForm profile = (ProfileForm) target;

        if ( profile.getPassword() != null )
        {
            String password = profile.getPassword();
            if ( !password.equals( profile.getRepeatPassword() ) )
            {
                errors.rejectValue( "repeatPassword", "FieldMatch.ProfileForm.password.repeatPassword" );
            }
        }
    }

}

