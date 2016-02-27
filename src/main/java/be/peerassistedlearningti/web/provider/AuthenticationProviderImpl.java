package be.peerassistedlearningti.web.provider;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
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
public class AuthenticationProviderImpl implements AuthenticationProvider
{

    @Autowired
    private PALService service;

    /**
     * Checks if the given Authentication object is valid
     *
     * @param auth Authentication object to validate
     * @return A valid UsernamePasswordAuthenticationToken if the authentication is valid, otherwise null is returned
     * @throws AuthenticationException
     */
    public Authentication authenticate( Authentication auth ) throws AuthenticationException
    {
        final String email = auth.getName().toLowerCase();
        final String password = auth.getCredentials().toString();
        final Student student;

        try
        {
            student = service.getStudentByEmail( email );
        } catch ( Exception e )
        {
            return null;
        }

        if ( student != null && student.isPasswordValid( password ) )
        {
            return new UsernamePasswordAuthenticationToken( student, password, new ArrayList<GrantedAuthority>()
            {
                {
                    add( new SimpleGrantedAuthority( "ROLE_USER" ) );
                    if ( student.getTutor() != null )
                        add( new SimpleGrantedAuthority( "ROLE_TUTOR" ) );
                    if ( student.getType().equals( UserType.ADMIN ) )
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
    public boolean supports( Class<?> type )
    {
        return type.equals( UsernamePasswordAuthenticationToken.class );
    }

}
