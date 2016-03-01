package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import net.fortuna.ical4j.data.CalendarOutputter;
import net.fortuna.ical4j.model.*;
import net.fortuna.ical4j.model.TimeZone;
import net.fortuna.ical4j.model.component.VEvent;
import net.fortuna.ical4j.model.component.VTimeZone;
import net.fortuna.ical4j.model.parameter.Cn;
import net.fortuna.ical4j.model.parameter.Role;
import net.fortuna.ical4j.model.property.*;
import net.fortuna.ical4j.util.UidGenerator;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.SocketException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

@Controller
@RequestMapping( "/resources" )
public class ResourceController
{

    @Autowired
    private PALService service;

    @ResponseBody
    @RequestMapping( value = "/students/{id}/avatar.png", method = RequestMethod.GET )
    public HttpEntity<byte[]> getAvatar( @PathVariable( "id" ) int id, HttpServletRequest request, HttpServletResponse response )
    {
        Student student = service.getStudentById( id );
        byte[] img = student.getAvatar();

        if ( img == null )
        {
            try
            {
                String path = request.getSession().getServletContext().getRealPath( "/resources/img" ) + "/default_profile.jpg";
                InputStream in = new FileSystemResource( new File( path ) ).getInputStream();
                img = IOUtils.toByteArray( in );
            } catch ( Exception e )
            {
                img = new byte[ 0 ];
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType( MediaType.IMAGE_JPEG );
        headers.setContentLength( img.length );
        headers.setLastModified( student.getLastUpdated().getTime() );
        return new HttpEntity<>( img, headers );
    }

    @ResponseBody
    @RequestMapping( value = "/applications/{id}/screenshot.png", method = RequestMethod.GET )
    public HttpEntity<byte[]> getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        Application app = service.getApplicationById( id );
        byte[] img = app.getScreenshot();

        if ( img == null )
        {
            img = new byte[ 0 ];
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType( MediaType.IMAGE_JPEG );
        headers.setContentLength( img.length );
        headers.setLastModified( app.getBeginDate().getTime() );
        return new HttpEntity<>( img, headers );
    }

    @ResponseBody
    @RequestMapping( value = "/students/{id}/bookings.ics", method = RequestMethod.GET )
    public void getBookingsICal( @PathVariable( value = "id" ) int id, @RequestParam( value = "token", required = true ) String token, HttpServletResponse response )
    {
        Student s = service.getStudentById( id );

        if ( s == null )
            return;

        if ( !s.getSecurityToken().equals( token ) )
            return;

        try
        {
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Bookings Calendar//iCal4j 1.0//EN", service.getPastBookings( s ) );
            CalendarOutputter outputter = new CalendarOutputter();
            outputter.setValidating( false );
            outputter.output( calendar, response.getOutputStream() );
        } catch ( IOException | ValidationException e ) {}
    }

    @ResponseBody
    @RequestMapping( value = "/students/{id}/lessons.ics", method = RequestMethod.GET )
    public void getLessonsICal( @PathVariable( value = "id" ) int id, @RequestParam( value = "token", required = true ) String token, HttpServletResponse response )
    {
        Student s = service.getStudentById( id );

        if ( s == null )
            return;

        if ( !s.getSecurityToken().equals( token ) )
            return;

        Tutor tutor = service.getTutorByStudent( s );

        if ( tutor == null )
            return;

        try
        {
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Lessons Calendar//iCal4j 1.0//EN", service.getLessons( tutor ) );

            CalendarOutputter outputter = new CalendarOutputter();
            outputter.setValidating( false );
            outputter.output( calendar, response.getOutputStream() );
        } catch ( IOException | ValidationException e ) {}
    }

    /**
     * Generates a calendar with the specified id and using the specified lessons
     *
     * @param id    The product id of the calendar
     * @param items The lessons of the calendar
     * @return A calendar with the specified id and using the specified lessons
     */
    private net.fortuna.ical4j.model.Calendar generateCalendar( String id, Collection<Lesson> items )
    {
        // Set the timezone to 'Europe/Brussels'
        TimeZoneRegistry registry = TimeZoneRegistryFactory.getInstance().createRegistry();
        TimeZone timezone = registry.getTimeZone( "Europe/Brussels" );
        VTimeZone tz = timezone.getVTimeZone();

        // Set the product id
        net.fortuna.ical4j.model.Calendar icsCalendar = new net.fortuna.ical4j.model.Calendar();
        icsCalendar.getProperties().add( new ProdId( id ) );
        icsCalendar.getProperties().add( CalScale.GREGORIAN );

        // Iterate over the lessons
        for ( Lesson lesson : items )
        {
            // Set the start date
            java.util.Calendar startDate = new GregorianCalendar();
            startDate.setTimeZone( timezone );
            startDate.setTime( lesson.getDate() );

            // Set the end date
            java.util.Calendar endDate = new GregorianCalendar();
            endDate.setTimeZone( timezone );
            endDate.setTime( new Date( lesson.getDate().getTime() + lesson.getDuration() * 60 * 1000 ) );

            // Create the event
            String eventName = lesson.getName();
            DateTime start = new DateTime( startDate.getTime() );
            DateTime end = new DateTime( endDate.getTime() );
            VEvent event = new VEvent( start, end, eventName );

            // Add timezone info to the event
            event.getProperties().add( tz.getTimeZoneId() );

            // Generate unique identifier for the event
            UidGenerator ug = null;
            try
            {
                ug = new UidGenerator( "uidGen" );
            } catch ( SocketException e ) { }

            Uid uid = ug.generateUid();
            event.getProperties().add( uid );

            // Add the tutor as an organizer
            Student tutor = lesson.getTutor().getStudent();
            Organizer organizer = new Organizer( URI.create( "mailto:" + tutor.getEmail() ) );
            organizer.getParameters().add( Role.REQ_PARTICIPANT );
            organizer.getParameters().add( new Cn( tutor.getName() ) );
            event.getProperties().add( organizer );

            // Iterate over the bookings
            for ( Student s : lesson.getBookings() )
            {
                // Add the student as a participant
                Attendee attendee = new Attendee( URI.create( "mailto:" + s.getEmail() ) );
                attendee.getParameters().add( Role.REQ_PARTICIPANT );
                attendee.getParameters().add( new Cn( s.getName() ) );
                event.getProperties().add( attendee );
            }

            // Add the event to the calendar
            icsCalendar.getComponents().add( event );
        }
        return icsCalendar;
    }

}
