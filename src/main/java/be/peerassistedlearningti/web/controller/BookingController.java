package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.*;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.BookingForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.Date;
import java.util.HashSet;

// TODO change this mapping to lesson/{id}/booking
@Controller
@RequestMapping( value = "/booking" )
public class BookingController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getBookingOverviewPage()
    {
        return new ModelAndView( "booking", "bookings", service.getAllBookings() );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getBookingAddPage()
    {
        // Get from lesson
        final Course course = new Course( "MX2506", ".NET Programeren", ".NET" );
        // Get from session
        final Student student = new Student( "David", "123", "davidopdebeeck@hotmail.com", true );
        // Get from lesson
        Tutor tutor = new Tutor( student, new HashSet<Course>()
        {{ add( course );}} );
        // Get from lesson
        Room room = new Room( "2.25", Campus.PROXIMUS, RoomType.PLAIN );

        Lesson lesson = new Lesson( new Date(), "LINQ", "Working with LINQ.", 60L, course, 5, tutor, room, room );

        service.addCourse( course );
        service.addStudent( student );
        service.addTutor( tutor );
        service.addRoom( room );
        service.addLesson( lesson );

        BookingForm form = new BookingForm();
        form.setStudent( student );
        form.setLesson( lesson );

        ModelMap model = new ModelMap();
        model.addAttribute( "booking", form );

        return new ModelAndView( "booking_add", model );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeBooking( @PathVariable( value = "id" ) int id )
    {
        Booking b = service.getBookingById( id );
        Lesson l = service.getLessonById( 1 );
        l.removeBooking( b );
        service.updateLesson( l );
        return "redirect:/booking/overview";
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addBooking( @Valid @ModelAttribute( "booking" ) BookingForm form, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "booking_add" );

        service.addBooking( new Booking( form.getLesson(), form.getStudent() ) );

        return new ModelAndView( "redirect:/booking/overview" );
    }
}
