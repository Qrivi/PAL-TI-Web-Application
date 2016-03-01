package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collection;

@Controller
@RequestMapping( value = "/booking" )
public class BookingController extends StudentController
{

    @Autowired
    private PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getBookingPage()
    {
        ModelMap map = new ModelMap();

        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );
        // Remove lessons where I am tutor
        if ( tutor != null )
        {
            Collection<Lesson> lessons = service.getUpcomingLessons();
            lessons.removeAll( service.getLessons( tutor ) );
            map.addAttribute( "lessons", lessons );
        } else
        {
            map.addAttribute( "lessons", service.getUpcomingLessons() );
        }

        map.addAttribute( "myOpenBookings", service.getUpcomingBookings( SessionAuth.getStudent() ) );
        return new ModelAndView( "student/booking", map );
    }

    @RequestMapping( value = "/register/{lessonId}", method = RequestMethod.POST )
    public ModelAndView addBooking( @PathVariable( value = "lessonId" ) int lessonId )
    {
        Lesson lesson = service.getLessonById( lessonId );
        if ( lesson == null ||
                service.hasBooking( SessionAuth.getStudent(), lesson ) ||
                lesson.getBookings().size() == lesson.getMaxParticipants() ||
                lesson.getTutor().getStudent().equals( SessionAuth.getStudent() ) )
        {
            return new ModelAndView( "redirect:/booking" );
        } else
        {
            lesson.addBooking( SessionAuth.getStudent() );
            service.updateLesson( lesson );
            SessionAuth.setStudent( service.getStudentById( SessionAuth.getStudent().getId() ) );
            //TODO:: add success message
            return new ModelAndView( "redirect:/booking" );
        }
    }

    @RequestMapping( value = "/unregister/{lessonId}", method = RequestMethod.POST )
    public ModelAndView removeBooking( @PathVariable( value = "lessonId" ) int lessonId )
    {
        Lesson lesson = service.getLessonById( lessonId );
        if ( lesson == null || !service.hasBooking( SessionAuth.getStudent(), lesson ) )
        {
            return new ModelAndView( "redirect:/booking" );
        } else
        {
            lesson.removeBooking( SessionAuth.getStudent() );
            service.updateLesson( lesson );
            SessionAuth.setStudent( service.getStudentById( SessionAuth.getStudent().getId() ) );
            //TODO:: add success message
            return new ModelAndView( "redirect:/booking" );
        }
    }
}
