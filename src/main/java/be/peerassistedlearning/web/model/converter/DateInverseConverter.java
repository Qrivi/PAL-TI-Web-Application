package be.peerassistedlearning.web.model.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Converts a Date into the matching String
 */
public class DateInverseConverter implements Converter<Date, String>{

    public String convert( Date d ){
        try{
            DateFormat dateFormat = new SimpleDateFormat( "dd-MM-yyyy hh:mm" );
            return dateFormat.format( d );
        }catch( Exception e ){
            return null;
        }
    }
}
