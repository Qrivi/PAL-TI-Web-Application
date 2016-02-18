package be.peerassistedlearningti.web.model.validation;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target( { METHOD , FIELD , ANNOTATION_TYPE } )
@Retention( RUNTIME )
@Constraint( validatedBy = CheckEmailIsUniqueValidator.class )
@Documented
public @interface CheckEmailIsUnique
{
    String message() default "{constraints.checkemailexists.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
    boolean allowSessionEmail() default false;
    boolean inverted() default false;
}
