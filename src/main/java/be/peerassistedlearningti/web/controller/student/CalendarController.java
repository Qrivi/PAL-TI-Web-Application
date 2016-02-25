package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping( value = "/calendar" )
public class CalendarController extends StudentController
{

    @Autowired
    private PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getCalendar( ModelMap model )
    {
        return new ModelAndView( "student/calendar", "bookings", SessionAuth.getStudent()
                .getOpenBookings() );
    }

}
