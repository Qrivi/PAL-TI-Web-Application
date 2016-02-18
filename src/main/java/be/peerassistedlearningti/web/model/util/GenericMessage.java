package be.peerassistedlearningti.web.model.util;


/**
 * Class used to send generic messages between pages
 */
public class GenericMessage {

    private String message;
    private MessageType type;

    /**
     * Constructs the message
     *
     * @param message The message string
     * @param type    The type of message
     */
    public GenericMessage(String message, MessageType type) {
        this.message = message;
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public MessageType getType() {
        return type;
    }

    public void setType(MessageType type) {
        this.type = type;
    }

    public enum MessageType {
        danger, info, warning, success
    }
}
