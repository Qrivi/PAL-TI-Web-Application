package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Student;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.SocketException;
import java.net.URI;
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
    public void getAvatar( @PathVariable( "id" ) int id, HttpServletRequest request, HttpServletResponse response )
    {
        InputStream in = null;
        try
        {
            Student student = service.getStudentById( id );
            byte[] img = student.getAvatar();

            if ( img == null )
            {
                String path = request.getSession()
                        .getServletContext()
                        .getRealPath( "/resources/img" ) + "/default_profile.jpg";
                in = new FileSystemResource( new File( path ) ).getInputStream();
            } else
            {
                in = new ByteArrayInputStream( img );
            }
            response.setContentType( "image/jpeg" );
            IOUtils.copy( in, response.getOutputStream() );
        } catch ( Exception e ) { System.out.println( e.getMessage() );} finally
        {
            if ( in != null )
                IOUtils.closeQuietly( in );
        }
    }

    @ResponseBody
    @RequestMapping( value = "/applications/{id}/screenshot.png", method = RequestMethod.GET )
    public void getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        InputStream in = null;
        try
        {
            Application app = service.getApplicationById( id );
            byte[] img = app.getScreenshot();

            in = new ByteArrayInputStream( img );
            response.setContentType( "image/jpeg" );
            IOUtils.copy( in, response.getOutputStream() );
        } catch ( Exception e ) {} finally
        {
            if ( in != null )
                IOUtils.closeQuietly( in );
        }
    }

    @ResponseBody
    @RequestMapping( value = "/students/{id}/bookings.ics", method = RequestMethod.GET )
    public void getBookingsICal( @PathVariable( value = "id" ) int id, @RequestParam( value = "token", required = true ) String token, HttpServletResponse response )
    {
        Student s = service.getStudentById( id );

        if ( s == null )
            return;

        if ( !s.getSecurityToken()
                .equals( token ) )
            return;

        try
        {
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Bookings Calendar//iCal4j 1.0//EN", s.getOpenBookings() );
            outputCalendar( calendar, response.getOutputStream() );
        } catch ( IOException e ) {}
    }

    @ResponseBody
    @RequestMapping( value = "/students/{id}/lessons.ics", method = RequestMethod.GET )
    public void getLessonsICal( @PathVariable( value = "id" ) int id, @RequestParam( value = "token", required = true ) String token, HttpServletResponse response )
    {
        Student s = service.getStudentById( id );

        if ( s == null )
            return;

        if ( !s.getSecurityToken()
                .equals( token ) )
            return;

        if ( s.getTutor() == null )
            return;

        try
        {
            net.fortuna.ical4j.model.Calendar calendar = generateCalendar( "-//PAL Lessons Calendar//iCal4j 1.0//EN", s.getTutor()
                    .getLessons() );
            outputCalendar( calendar, response.getOutputStream() );
        } catch ( IOException e ) {}
    }

    private net.fortuna.ical4j.model.Calendar generateCalendar( String id, Set<Lesson> items )
    {
        TimeZoneRegistry registry = TimeZoneRegistryFactory.getInstance()
                .createRegistry();
        TimeZone timezone = registry.getTimeZone( "Europe/Brussels" );
        VTimeZone tz = timezone.getVTimeZone();

        net.fortuna.ical4j.model.Calendar icsCalendar = new net.fortuna.ical4j.model.Calendar();
        icsCalendar.getProperties()
                .add( new ProdId( id ) );
        icsCalendar.getProperties()
                .add( CalScale.GREGORIAN );

        for ( Lesson lesson : items )
        {
            java.util.Calendar startDate = new GregorianCalendar();
            startDate.setTimeZone( timezone );
            startDate.setTime( lesson.getDate() );

            java.util.Calendar endDate = new GregorianCalendar();
            endDate.setTimeZone( timezone );
            endDate.setTime( new Date( lesson.getDate()
                    .getTime() + lesson.getDuration() * 60 * 1000 ) );

            String eventName = lesson.getName();
            DateTime start = new DateTime( startDate.getTime() );
            DateTime end = new DateTime( endDate.getTime() );
            VEvent booking = new VEvent( start, end, eventName );

            // add timezone info..
            booking.getProperties()
                    .add( tz.getTimeZoneId() );

            // generate unique identifier..
            UidGenerator ug = null;
            try
            {
                ug = new UidGenerator( "uidGen" );
            } catch ( SocketException e ) { }

            Uid uid = ug.generateUid();
            booking.getProperties()
                    .add( uid );

            Student tutor = lesson.getTutor()
                    .getStudent();
            Organizer organizer = new Organizer( URI.create( "mailto:" + tutor.getEmail() ) );
            organizer.getParameters()
                    .add( Role.REQ_PARTICIPANT );
            organizer.getParameters()
                    .add( new Cn( tutor.getName() ) );
            booking.getProperties()
                    .add( organizer );

            for ( Student s : lesson.getBookings() )
            {
                Attendee attendee = new Attendee( URI.create( "mailto:" + s.getEmail() ) );
                attendee.getParameters()
                        .add( Role.REQ_PARTICIPANT );
                attendee.getParameters()
                        .add( new Cn( s.getName() ) );
                booking.getProperties()
                        .add( attendee );
            }

            icsCalendar.getComponents()
                    .add( booking );
        }
        return icsCalendar;
    }

    private void outputCalendar( net.fortuna.ical4j.model.Calendar calendar, OutputStream out )
    {
        try
        {
            CalendarOutputter outputter = new CalendarOutputter();
            outputter.setValidating( false );
            outputter.output( calendar, out );
        } catch ( IOException | ValidationException e ) {}
    }
}
