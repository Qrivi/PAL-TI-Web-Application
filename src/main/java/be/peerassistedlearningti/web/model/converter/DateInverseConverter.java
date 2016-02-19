package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Converts a Date into the matching String
 */
public class DateInverseConverter implements Converter<Date, String>
{

    public String convert( Date d )
    {
        try
        {
            DateFormat dateFormat = new SimpleDateFormat( "dd-MM-yyyy hh:mm" );
            return dateFormat.format( d );
        } catch ( Exception e )
        {
            e.printStackTrace();
            return null;
        }
    }
}
