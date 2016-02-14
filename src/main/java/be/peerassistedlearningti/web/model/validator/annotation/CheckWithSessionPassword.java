package be.peerassistedlearningti.web.model.validator.annotation;

import be.peerassistedlearningti.web.model.validator.PasswordValidator;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.*;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Target( { METHOD, FIELD, ANNOTATION_TYPE })
@Retention(RUNTIME)
@Constraint(validatedBy = PasswordValidator.class)
@Documented
public @interface CheckWithSessionPassword {
    String message() default "{constraint.checkwithsessionpassword.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
    String algorithm() default "SHA-512";
}
