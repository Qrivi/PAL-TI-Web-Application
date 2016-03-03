package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.model.Tutor;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearningti.web.model.dto.CalendarDTO;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping( value = "/calendar" )
public class CalendarController extends StudentController
{
    @Autowired
    PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getCalendar( ModelMap model )
    {
        return new ModelAndView( "student/calendar", model );
    }

    @ResponseBody
    @RequestMapping( value = "/events", method = RequestMethod.GET )
    public List<CalendarDTO> getCalendarEvents()
    {
        Student current = SessionAuth.getStudent();
        Tutor tutor = service.getTutorByStudent( current );
        List<CalendarDTO> events = new ArrayList<>();

        events.addAll( service.getUpcomingBookings( current ).stream().map( lesson -> convert( lesson, "#428bca" ) ).collect( Collectors.toList() ) );
        if ( tutor != null )
            events.addAll( service.getLessons( tutor ).stream().map( lesson -> convert( lesson, "#5cb85c" ) ).collect( Collectors.toList() ) );

        return events;
    }

    private CalendarDTO convert( Lesson lesson, String color )
    {
        DateFormat dateFormat = new SimpleDateFormat( "YYYY-MM-dd hh:mm:SS" );
        CalendarDTO event = new CalendarDTO();

        event.setId( lesson.getId() );
        event.setTitle( lesson.getName() );
        event.setDescription( lesson.getDescription() );
        event.setStart( dateFormat.format( lesson.getDate() ) );
        event.setEnd( dateFormat.format( new Date( lesson.getDate().getTime() + lesson.getDuration() * 60 * 1000 ) ) );
        event.setTutorName( lesson.getTutor().getStudent().getName() );
        event.setCourseName( lesson.getCourse().getShortName() );
        event.setColor( color );

        return event;
    }
}
