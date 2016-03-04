package be.peerassistedlearning.web.controller;

import be.peerassistedlearning.model.*;
import be.peerassistedlearning.service.PALService;
import net.fortuna.ical4j.data.CalendarOutputter;
import net.fortuna.ical4j.model.*;
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
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketException;
import java.net.URI;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;

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
        Image image = service.getAvatar( student );
        byte[] bytes;

        if ( image == null )
        {
            try
            {
                String path = request.getSession().getServletContext().getRealPath( "/resources/img" ) + "/default_profile.jpg";
                InputStream in = new FileSystemResource( new File( path ) ).getInputStream();
                bytes = IOUtils.toByteArray( in );
            } catch ( Exception e )
            {
                bytes = new byte[ 0 ];
            }
        } else
        {
            bytes = image.getBytes();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType( MediaType.IMAGE_JPEG );
        headers.setContentLength( bytes.length );
        headers.setLastModified( ( image == null ) ? new Date( 0 ).getTime() : image.getLastModified().getTime() );
        return new HttpEntity<>( bytes, headers );
    }

    @ResponseBody
    @RequestMapping( value = "/applications/{id}/screenshot.png", method = RequestMethod.GET )
    public HttpEntity<byte[]> getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        Application app = service.getApplicationById( id );
        Image image = service.getScreenshot( app );
        byte[] bytes = image.getBytes();

        if ( bytes == null )
            bytes = new byte[ 0 ];

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType( MediaType.IMAGE_JPEG );
        headers.setContentLength( bytes.length );
        headers.setLastModified( image.getLastModified().getTime() );
        return new HttpEntity<>( bytes, headers );
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
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Bookings Calendar//iCal4j 1.0//EN", service.getUpcomingBookings( s ) );
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
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Lessons Calendar//iCal4j 1.0//EN", service.getUpcomingLessons( tutor ) );

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

            // Add the description
            Description description = new Description( lesson.getDescription() );
            event.getProperties().add( description );

            // Add the rooms as locations
            Location loc = new Location( lesson.getRoom().getCampus() + ", " + lesson.getRoom().getName() + " - " + lesson.getBackupRoom().getCampus() + ", " + lesson.getBackupRoom().getName() );
            event.getProperties().add( loc );

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
