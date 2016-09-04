package be.peerassistedlearning.web.model.util;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Class used for student specific actions
 */
public class StudentUtils
{

    private static PALService service;

    /**
     * Sets the service for this class
     *
     * @param service The service for this class
     */
    @Autowired
    public void setPALService( PALService service )
    {
        StudentUtils.service = service;
    }

    /**
     * Creates a valid profile identifier using the specified string
     *
     * @param identifier The string to get a valid identifier from
     * @return A valid profile identifier using the specified string
     */
    public static String createProfileIdentifier( String identifier )
    {
        // Check if a student exists with the identifier
        Student student = service.getStudentByProfileIdentifier( identifier );

        // If no student found return the identifier because it is valid
        if ( student == null )
            return identifier;

        // If the last character is a digit we add 1 to it als we add '.1' to it
        if ( Character.isDigit( identifier.charAt( identifier.length() - 1 ) ) )
        {
            int i = Character.getNumericValue( identifier.charAt( identifier.length() - 1 ) );
            identifier = identifier.substring( 0, identifier.length() - 1 );
            return identifier + ( i + 1 );
        } else
        {
            return createProfileIdentifier( identifier + ".1" );
        }
    }

}
