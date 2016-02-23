package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping( value = "/course" )
public class CourseController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView( "course", "courses", service.getAllCourses() );
    }

    @RequestMapping( value = "/subscribe/{id}", method = RequestMethod.POST )
    public String subscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        Student s = SessionAuth.getStudent();
        c.subscribe( s );
        service.updateCourse( c );
        service.updateStudent( s );
        SessionAuth.setStudent( s );
        return "redirect:/course/overview";
    }

    @RequestMapping( value = "/unsubscribe/{id}", method = RequestMethod.POST )
    public String unsubscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        c.unsubscribe( SessionAuth.getStudent() );
        service.updateCourse( c );
        service.updateStudent( SessionAuth.getStudent() );
        return "redirect:/course/overview";
    }

    /*@RequestMapping( value = "/lessons/course/{id}", method = RequestMethod.GET )
    public String getLessonOfCourse( @PathVariable( value = "id" ) int id )
    {
        return "redirect:/lesson/overview/course/" + id ;
    }*/
}
