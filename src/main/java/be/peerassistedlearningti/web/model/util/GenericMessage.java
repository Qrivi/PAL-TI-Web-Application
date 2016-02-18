package be.peerassistedlearningti.web.model.util;


public class GenericMessage {
    private String message;
    private MessageType type;

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
