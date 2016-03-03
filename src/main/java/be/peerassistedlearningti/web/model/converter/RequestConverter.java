package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.model.Request;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

public class RequestConverter implements Converter<String, Request> {
    @Autowired
    private PALService service;

    public Request convert(String s) {
        try {
            return service.getRequestById(Integer.parseInt(s));
        } catch (Exception e) {
            return null;
        }
    }
}
