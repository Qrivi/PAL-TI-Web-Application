package be.peerassistedlearningti.web.model.converter;

import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConverter {
    @Autowired
    private PALService service;

    public Date convert( String s ) {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
        Date date = null;
        try {
            date = dateFormat.parse(s);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
}
