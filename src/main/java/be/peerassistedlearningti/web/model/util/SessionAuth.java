package be.peerassistedlearningti.web.model.util;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.List;

/**
 * Class used to get/set the Authenticated user
 */
public class SessionAuth
{

    /**
     * Sets the current session's authenticated user
     *
     * @param student The new authenticated student
     * @see Student
     */
    public static void setStudent( Student student )
    {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add( new SimpleGrantedAuthority( "ROLE_USER" ) );

        if ( student.getType().equals( UserType.ADMIN ) )
            authorities.add( new SimpleGrantedAuthority( "ROLE_ADMIN" ) );
        if ( student.getTutor() != null )
            authorities.add( new SimpleGrantedAuthority( "ROLE_TUTOR" ) );
        Authentication auth = new UsernamePasswordAuthenticationToken( student, student.getPassword(), authorities );

        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication( auth );
        SecurityContextHolder.setContext( securityContext );
    }

    /**
     * Gets the current authenticated student
     *
     * @return The current authenticated student
     * @see Student
     */
    public static Student getStudent()
    {
        return (Student) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
    }
}
