package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.CourseForm;
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

@Controller
@RequestMapping( value = "/course" )
public class CourseController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView( "course_overview", "courses", service.getAllCourses() );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getCourseDetailPage( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        return new ModelAndView( "course", "course", service.getCourseById( id ) );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getCourseAddPage( ModelMap model )
    {
        return new ModelAndView( "course", "course", new CourseForm() );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        service.removeCourse( c );
        return "redirect:/course/overview";
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addCourse( @Valid @ModelAttribute( "course" ) CourseForm courseForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "course" );

        service.addCourse( new Course( courseForm.getCode(), courseForm.getName(), courseForm.getShortName() ) );

        return new ModelAndView( "redirect:/course/overview" );
    }

}
