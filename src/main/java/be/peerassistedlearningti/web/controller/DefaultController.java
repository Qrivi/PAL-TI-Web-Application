package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.common.model.jpa.*;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.CourseForm;
import be.peerassistedlearningti.web.model.StudentForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
public class DefaultController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/course", method = RequestMethod.GET )
    public ModelAndView getCoursePage( ModelMap model )
    {
        model.addAttribute( "course", new CourseForm() );
        return new ModelAndView( "course", model );
    }

    @RequestMapping( value = "/course", method = RequestMethod.POST )
    public ModelAndView addCoursePage( @Valid @ModelAttribute( "course" ) CourseForm courseForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "course" );

        service.addCourse( new Course( courseForm.getCode(), courseForm.getName(), courseForm.getShortName() ) );

        return new ModelAndView( "course" );
    }

    @RequestMapping( value = "/student", method = RequestMethod.GET )
    public ModelAndView getStudentPage( ModelMap model )
    {
        model.addAttribute( "student", new StudentForm() );
        return new ModelAndView( "student", model );
    }

    @RequestMapping( value = "/student", method = RequestMethod.POST )
    public ModelAndView addStudentPage( @Valid @ModelAttribute( "student" ) StudentForm studentForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student" );

        service.addStudent( new Student( studentForm.getName(), studentForm.getPassword(), studentForm.getEmail(), studentForm.isAdmin() ) );

        return new ModelAndView( "student" );
    }

    @RequestMapping( value = "/lesson", method = RequestMethod.GET )
    public ModelAndView getLessonPage( ModelMap model )
    {
        model.addAttribute( "lesson", new lessonForm() );
        return new ModelAndView( "lesson", model );
    }

    @RequestMapping( value = "/lesson", method = RequestMethod.POST )
    public ModelAndView addlessonPage( @Valid @ModelAttribute( "lesson" ) lessonForm lessonForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "lesson" );

        service.addLesson( new Lesson( lessonForm.getCode(), lessonForm.getName(), lessonForm.getShortName() ) );

        return new ModelAndView( "lesson" );
    }
}
