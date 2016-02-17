package be.peerassistedlearningti.web.model.validation;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target( { METHOD , FIELD , ANNOTATION_TYPE } )
@Retention( RUNTIME )
@Constraint( validatedBy = CheckEmailExistsValidator.class )
@Documented
public @interface CheckEmailExists
{
    String message() default "{constraints.checkemailexists.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
    public boolean allowSessionEmail() default false;
}
