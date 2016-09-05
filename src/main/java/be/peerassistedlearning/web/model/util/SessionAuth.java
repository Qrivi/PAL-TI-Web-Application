package be.peerassistedlearning.web.model.util;

import be.peerassistedlearning.model.Student;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Class used to get/set the Authenticated user
 */
public class SessionAuth{

    /**
     * Gets the current authenticated student
     *
     * @return The current authenticated student
     * @see Student
     */
    public static Student getStudent(){
        return (Student)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    /**
     * Sets the current session's authenticated user
     *
     * @param student The new authenticated student
     * @see Student
     */
    public static void setStudent( Student student ){
        Authentication auth = new UsernamePasswordAuthenticationToken( student, student.getPassword(), SecurityContextHolder.getContext().getAuthentication().getAuthorities() );
        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication( auth );
        SecurityContextHolder.setContext( securityContext );
    }
}
