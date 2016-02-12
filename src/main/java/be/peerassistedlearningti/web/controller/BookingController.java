package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.web.model.BookingForm;
import be.peerassistedlearningti.model.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping( value = "/booking" )
public class BookingController {
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
        return new ModelAndView( "booking_add", "booking", new BookingForm() );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeBooking( @PathVariable( value = "id" ) int id )
    {
        Booking b = service.getBookingById( id );
        service.removeBooking( b );
        return "redirect:/booking/overview";
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addBooking(@Valid @ModelAttribute( "booking" ) BookingForm bookingForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "booking_add" );

        service.addBooking( new Booking( bookingForm.getCode(), bookingForm.getName(), bookingForm.getShortName() ) );

        return new ModelAndView( "redirect:/booking/overview" );
    }
}
