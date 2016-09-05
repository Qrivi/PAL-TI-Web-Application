package be.peerassistedlearning.web.model.converter;

import be.peerassistedlearning.model.Request;
import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Request
 */
public class RequestConverter implements Converter<String, Request>{
    @Autowired
    private PALService service;

    public Request convert( String s ){
        try{
            return service.getRequestById( Integer.parseInt( s ) );
        }catch( Exception e ){
            return null;
        }
    }
}
