package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.controller.student.StudentController;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

// TODO change this mapping to lesson/{id}/booking
@Controller
@RequestMapping( value = "/booking" )
public class BookingController extends StudentController
{

    @Autowired
    private PALService service;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getBookingPage()
    {
        ModelMap map = new ModelMap();
        map.addAttribute("lessons", service.getUpcomingLessons());
        map.addAttribute("myOpenBookings", SessionAuth.getStudent().getOpenBookings());

        return new ModelAndView("booking", map);
    }

    @RequestMapping(value = "/register/{lessonId}", method = RequestMethod.POST)
    public ModelAndView addBooking(@PathVariable(value = "lessonId") int lessonId) {
        Lesson lesson = service.getLessonById(lessonId);
        if (lesson == null) {
            return new ModelAndView("redirect:/booking");
        } else if (SessionAuth.getStudent().getBookings().contains(lesson)) {
            return new ModelAndView("redirect:/booking");
        } else {
            lesson.addBooking(SessionAuth.getStudent());
            service.updateLesson(lesson);
            SessionAuth.setStudent(service.getStudentById(SessionAuth.getStudent().getId()));
            //TODO:: add success message
            return new ModelAndView("redirect:/booking");
        }
    }

    @RequestMapping(value = "/unregister/{lessonId}", method = RequestMethod.POST)
    public ModelAndView removeBooking(@PathVariable(value = "lessonId") int lessonId) {
        Lesson lesson = service.getLessonById(lessonId);
        if (lesson == null) {
            return new ModelAndView("redirect:/booking");
        } else if (!SessionAuth.getStudent().getBookings().contains(lesson)) {
            return new ModelAndView("redirect:/booking");
        } else {
            lesson.removeBooking(SessionAuth.getStudent());
            service.updateLesson(lesson);
            SessionAuth.setStudent(service.getStudentById(SessionAuth.getStudent().getId()));
            //TODO:: add success message
            return new ModelAndView("redirect:/booking");
        }
    }
/*
    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeBooking( @PathVariable( value = "id" ) int id )
    {
        Booking b = service.getBookingById( id );
        //Lesson l = service.getLessonById( 1 );
        //l.removeBooking( b );
        service.removeBooking( b );
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
*/
}
