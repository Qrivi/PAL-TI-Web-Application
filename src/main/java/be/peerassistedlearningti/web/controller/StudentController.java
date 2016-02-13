package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.StudentForm;
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
@RequestMapping( value = "/student" )
public class StudentController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView( "student", "students", service.getAllStudents() );
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getStudentPage( ModelMap model )
    {
        model.addAttribute( "student", new StudentForm() );
        return new ModelAndView( "student_add", model );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView addStudentPage( @Valid @ModelAttribute( "student" ) StudentForm studentForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student_add" );

        service.addStudent( new Student( studentForm.getName(), studentForm.getPassword(), studentForm.getEmail(), studentForm.isAdmin() ) );

        return new ModelAndView( "student_add" );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeStudent( @PathVariable( value = "id" ) int id )
    {
        Student s = service.getStudentById( id );
        service.removeStudent( s );
        return "redirect:/student/overview";
    }
}
