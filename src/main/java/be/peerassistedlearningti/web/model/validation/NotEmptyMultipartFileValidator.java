package be.peerassistedlearningti.web.model.validation;

import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NotEmptyMultipartFileValidator implements ConstraintValidator<NotEmptyMultipartFile, MultipartFile>
{

    @Autowired
    private PALService service;

    public void initialize( NotEmptyMultipartFile notEmptyMultipartFile ) {}

    public boolean isValid( MultipartFile multipartFile, ConstraintValidatorContext constraintValidatorContext )
    {
        return !multipartFile.isEmpty();
    }
}
