package be.peerassistedlearning.web.model.converter;

import org.springframework.core.convert.converter.Converter;

/**
 * Converts a String into the matching Integer
 */
public class IntegerConverter implements Converter<String, Integer>{
    public Integer convert( String s ){
        try{
            return Integer.parseInt( s );
        }catch( NumberFormatException e ){
            return null;
        }
    }
}
