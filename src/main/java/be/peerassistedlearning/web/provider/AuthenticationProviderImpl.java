package be.peerassistedlearning.web.provider;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.model.Tutor;
import be.peerassistedlearning.model.UserType;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.ArrayList;

/**
 * Class used to authenticate students
 */
public class AuthenticationProviderImpl implements AuthenticationProvider{

    @Autowired
    private PALService service;

    /**
     * Checks if the given Authentication object is valid
     *
     * @param auth Authentication object to validate
     * @return A valid UsernamePasswordAuthenticationToken if the authentication is valid, otherwise null is returned
     * @throws AuthenticationException This exception is never thrown
     */
    public Authentication authenticate( Authentication auth ) throws AuthenticationException{
        final String email = auth.getName().toLowerCase();
        final String password = auth.getCredentials().toString();
        final Student student;
        final Tutor tutor;

        try{
            student = service.getStudentByEmail( email );
            tutor = service.getTutorByStudent( student );
        }catch( Exception e ){
            return null;
        }

        if( student != null && student.isPasswordValid( password ) ){
            return new UsernamePasswordAuthenticationToken( student, password, new ArrayList<GrantedAuthority>(){
                {
                    add( new SimpleGrantedAuthority( "ROLE_USER" ) );
                    if( tutor != null )
                        add( new SimpleGrantedAuthority( "ROLE_TUTOR" ) );
                    if( student.getType().equals( UserType.ADMIN ) )
                        add( new SimpleGrantedAuthority( "ROLE_ADMIN" ) );
                }
            } );
        }

        return null;
    }

    /**
     * Checks if the provider supports the specified class
     *
     * @param type The class to check
     * @return If the class equals UsernamePasswordAuthenticationToken
     */
    public boolean supports( Class<?> type ){
        return type.equals( UsernamePasswordAuthenticationToken.class );
    }

}
