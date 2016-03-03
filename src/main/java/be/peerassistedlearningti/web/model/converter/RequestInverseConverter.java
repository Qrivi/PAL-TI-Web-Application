package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Request;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a Request into the matching String
 */
public class RequestInverseConverter implements Converter<Request, String> {
    public String convert(Request request) {
        try {
            return request.getId()
                    .toString();
        } catch (Exception e) {
            return null;
        }
    }
}
