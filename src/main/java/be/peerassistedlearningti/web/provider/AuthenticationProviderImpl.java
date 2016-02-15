package be.peerassistedlearningti.web.provider;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.ArrayList;

public class AuthenticationProviderImpl implements AuthenticationProvider
{

    @Autowired
    private PALService service;

    public Authentication authenticate( Authentication auth ) throws AuthenticationException
    {
        String email = auth.getName()
                .toLowerCase();
        String password = auth.getCredentials()
                .toString();
        Student student;

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
                }
            } );
        }

        return null;
    }

    public boolean supports( Class<?> type )
    {
        return type.equals( UsernamePasswordAuthenticationToken.class );
    }

}
