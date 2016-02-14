package be.peerassistedlearningti.web.model.validator;

import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.validator.annotation.CheckWithSessionPassword;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordValidator implements ConstraintValidator<CheckWithSessionPassword, String> {

    @Autowired
    private PALService service;
    private String algorithm;

    public void initialize(CheckWithSessionPassword checkWithSessionPassword) {
        this.algorithm = checkWithSessionPassword.algorithm();
    }

    public boolean isValid(String password, ConstraintValidatorContext constraintValidatorContext) {
        //TODO: compare session password with given password
        return false;
    }

    /**
     * Hashes the plaintext password
     *
     * @param plainTextPassword The password that will be hashed
     * @return The password in hashed form.
     */
    private String hashPassword( String plainTextPassword, String salt )
    {
        if ( plainTextPassword == null )
            return null;

        MessageDigest digest = null;

        try
        {
            digest = MessageDigest.getInstance( algorithm );
            digest.reset();
        } catch ( NoSuchAlgorithmException e ) { }

        digest.update( plainTextPassword.getBytes() );

        if ( salt != null )
            digest.update( salt.getBytes() );

        return ( new BigInteger( 1, digest.digest() ).toString( 40 ) );
    }
}
