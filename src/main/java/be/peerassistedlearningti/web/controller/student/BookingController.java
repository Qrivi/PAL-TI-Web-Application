package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.model.Tutor;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearningti.web.model.dto.CalendarDTO;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping( value = "/booking" )
public class BookingController extends StudentController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/table", method = RequestMethod.GET )
    public ModelAndView getTableBookingPage( ModelMap model )
    {
        ModelMap map = new ModelMap();

        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );

        if ( tutor != null )
        {
            Collection<Lesson> lessons = service.getUpcomingLessons();
            lessons.removeAll( service.getLessons( tutor ) );
            model.addAttribute( "lessons", lessons );
        } else
        {
            model.addAttribute( "lessons", service.getUpcomingLessons() );
        }

        model.addAttribute( "myOpenBookings", service.getUpcomingBookings( SessionAuth.getStudent() ) );
        return new ModelAndView( "student/booking/table", map );
    }

    @RequestMapping( value = "/calendar", method = RequestMethod.GET )
    public ModelAndView getCalendarBookingPage( ModelMap model )
    {
        return new ModelAndView( "student/booking/calendar", "courses", service.getCourses( SessionAuth.getStudent() ) );
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
            return new ModelAndView( "redirect:/booking/table" );
        } else
        {
            lesson.addBooking( SessionAuth.getStudent() );
            service.updateLesson( lesson );
            SessionAuth.setStudent( service.getStudentById( SessionAuth.getStudent().getId() ) );
            //TODO:: add success message
            return new ModelAndView( "redirect:/booking/table" );
        }
    }

    @RequestMapping( value = "/unregister/{lessonId}", method = RequestMethod.POST )
    public ModelAndView removeBooking( @PathVariable( value = "lessonId" ) int lessonId )
    {
        Lesson lesson = service.getLessonById( lessonId );
        if ( lesson == null || !service.hasBooking( SessionAuth.getStudent(), lesson ) )
        {
            return new ModelAndView( "redirect:/booking/table" );
        } else
        {
            lesson.removeBooking( SessionAuth.getStudent() );
            service.updateLesson( lesson );
            SessionAuth.setStudent( service.getStudentById( SessionAuth.getStudent().getId() ) );
            //TODO:: add success message
            return new ModelAndView( "redirect:/booking/table" );
        }
    }

    @ResponseBody
    @RequestMapping( value = "/calendar/events", method = RequestMethod.GET )
    public List<CalendarDTO> getBookings( @RequestParam( value = "courses", required = false ) Course[] courses )
    {
        List<CalendarDTO> events = new ArrayList<>();
        Student current = SessionAuth.getStudent();

        if ( courses != null )
        {
            for ( Course course : courses )
                events.addAll( service.getUpcomingLessons( course ).stream().map( lesson -> convert( lesson ) ).collect( Collectors.toList() ) );
        } else
        {
            events.addAll( service.getUpcomingLessons( current ).stream().map( lesson -> convert( lesson ) ).collect( Collectors.toList() ) );
        }

        return events;
    }

    private CalendarDTO convert( Lesson lesson )
    {
        DateFormat dateFormat = new SimpleDateFormat( "YYYY-MM-dd hh:mm:SS" );
        CalendarDTO event = new CalendarDTO();

        boolean registered = lesson.getBookings().contains( SessionAuth.getStudent() );

        event.setId( lesson.getId() );
        event.setTitle( lesson.getName() );
        event.setDescription( lesson.getDescription() );
        event.setStart( dateFormat.format( lesson.getDate() ) );
        event.setEnd( dateFormat.format( new Date( lesson.getDate().getTime() + lesson.getDuration() * 60 * 1000 ) ) );
        event.setTutorName( lesson.getTutor().getStudent().getName() );
        event.setRegistered( lesson.getBookings().contains( SessionAuth.getStudent() ) );
        event.setCourseName( lesson.getCourse().getShortName() );
        event.setColor( ( registered ) ? "#5cb85c" : "#428bca" );

        return event;
    }

}
