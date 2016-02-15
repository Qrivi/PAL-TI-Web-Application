package be.peerassistedlearningti.web.model.validation;

import be.peerassistedlearningti.web.model.validation.CheckWithSessionPasswordValidator;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.*;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Target( { METHOD , FIELD , ANNOTATION_TYPE } )
@Retention( RUNTIME )
@Constraint( validatedBy = CheckWithSessionPasswordValidator.class )
@Documented
public @interface CheckWithSessionPassword
{
    String message() default "{constraints.checkwithsessionpassword}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
    String algorithm() default "SHA-512";
}
