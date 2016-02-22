package be.peerassistedlearningti.web.model.validation;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Checks if the given email will be unique in the database
 */
@Target( { METHOD , FIELD , ANNOTATION_TYPE } )
@Retention( RUNTIME )
@Constraint( validatedBy = CheckCodeIsUniqueValidator.class )
@Documented
public @interface CheckCodeIsUnique
{
    String message() default "{constraints.checkcodeexists.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
