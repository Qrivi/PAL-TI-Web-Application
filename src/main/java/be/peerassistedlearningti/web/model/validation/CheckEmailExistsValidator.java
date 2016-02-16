package be.peerassistedlearningti.web.model.validation;

import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CheckEmailExistsValidator implements ConstraintValidator<CheckEmailExists, String> {

    @Autowired
    private PALService service;
    private boolean allowSessionEmail;

    public void initialize(CheckEmailExists checkEmailExists) {
        this.allowSessionEmail = checkEmailExists.allowSessionEmail();
    }

    public boolean isValid(String email, ConstraintValidatorContext constraintValidatorContext) {
        return service.getStudentByEmail(email)==null || (allowSessionEmail  && SessionAuth.getStudent().getEmail().equals(email));
    }
}
