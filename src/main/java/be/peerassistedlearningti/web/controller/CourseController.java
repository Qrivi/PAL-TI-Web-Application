package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping( value = "/course" )
public class CourseController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/course/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView( "course", "courses", service.getAllCourses() );
    }

    @RequestMapping( value = "/{id}/subscribe", method = RequestMethod.POST )
    public String subscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        c.subscribe( SessionAuth.getStudent() );
        service.updateCourse( c );
        return "redirect:/review/overview";
    }

    @RequestMapping( value = "/{id}/unsubscribe", method = RequestMethod.POST )
    public String unsubscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        c.unsubscribe( SessionAuth.getStudent() );
        service.updateCourse( c );
        return "redirect:/review/overview";
    }
}
