package be.peerassistedlearning.web.model.util.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;

/**
 * Class used to construct messages
 */
public class MessageFactory
{

    private static MessageSource messageSource;

    /**
     * Sets the message source for this factory
     *
     * @param messageSource The message source for this factory
     */
    @Autowired
    public void setMessageSource( MessageSource messageSource )
    {
        MessageFactory.messageSource = messageSource;
    }

    /**
     * Creates a generic success message, with the translated message code
     *
     * @param msg The message code to be translated
     * @return A generic success message, with the translated message code
     */
    public static GenericMessage createSuccessMessage( String msg )
    {
        msg = messageSource.getMessage( msg, null, LocaleContextHolder.getLocale() );
        return new GenericMessage( msg, GenericMessage.MessageType.success );
    }

    /**
     * Creates a generic success message, with the translated message code and arguments
     *
     * @param msg  The message code to be translated
     * @param args The message arguments
     * @return A generic success message, with the translated message code
     */
    public static GenericMessage createSuccessMessage( String msg, Object[] args )
    {
        msg = messageSource.getMessage( msg, args, LocaleContextHolder.getLocale() );
        return new GenericMessage( msg, GenericMessage.MessageType.success );
    }

    /**
     * Creates a generic danger message, with the translated message code
     *
     * @param msg The message code to be translated
     * @return A generic danger message, with the translated message code
     */
    public static GenericMessage createDangerMessage( String msg )
    {
        msg = messageSource.getMessage( msg, null, LocaleContextHolder.getLocale() );
        return new GenericMessage( msg, GenericMessage.MessageType.danger );
    }

}
