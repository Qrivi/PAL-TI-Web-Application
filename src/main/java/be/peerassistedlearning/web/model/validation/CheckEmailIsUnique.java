package be.peerassistedlearning.web.model.validation;


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
@Target( {METHOD, FIELD, ANNOTATION_TYPE} )
@Retention( RUNTIME )
@Constraint( validatedBy = CheckEmailIsUniqueValidator.class )
@Documented
public @interface CheckEmailIsUnique{
    String message() default "{constraints.checkemailexists.message}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    /**
     * Specifies if the current session student's email is allowed
     *
     * @return True if the given email must not be unique if it equals the current session student's email
     */
    boolean allowSessionEmail() default false;

    /**
     * Specifies if the check must be inverted
     *
     * @return True if the check must look whether the given email will not be unique
     */
    boolean inverted() default false;
}
