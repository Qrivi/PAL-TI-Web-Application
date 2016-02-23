package be.peerassistedlearningti.web.model.validation;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Checks if the given MultiPart file is not empty
 */
@Target( { METHOD , FIELD , ANNOTATION_TYPE } )
@Retention( RUNTIME )
@Constraint( validatedBy = NotEmptyMultipartFileValidator.class )
@Documented
public @interface NotEmptyMultipartFile
{
    String message() default "{constraints.notemptymultipartfile.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
