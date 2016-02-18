package be.peerassistedlearningti.web.model.util;

/**
 * Class used to send generic messages between pages
 */
public class GenericMessage
{

    private String message;
    private MessageType type;

    /**
     * Constructs the message
     *
     * @param message The message string
     * @param type    The type of message
     */
    public GenericMessage( String message, MessageType type )
    {
        this.message = message;
        this.type = type;
    }

    /**
     * Sets the message
     *
     * @param message The message
     */
    public void setMessage( String message )
    {
        this.message = message;
    }

    /**
     * Sets the type of the message
     *
     * @param type The type of the message
     */
    public void setType( MessageType type )
    {
        this.type = type;
    }

    /**
     * @return The message
     */
    public String getMessage()
    {
        return message;
    }

    /**
     * @return The type of the message
     */
    public MessageType getType()
    {
        return type;
    }

    /**
     * Enum for the type of messages
     */
    public enum MessageType
    {
        danger,
        info,
        warning,
        success
    }
}
