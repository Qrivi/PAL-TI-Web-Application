package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.StudentForm;
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
public class StudentCRUDController extends AdminController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/student/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView( "student/student", "students", service.getAllStudents() );
    }

    @RequestMapping( value = "/student/add", method = RequestMethod.GET )
    public ModelAndView getStudentPage( ModelMap model )
    {
        model.addAttribute( "student", new StudentForm() );
        model.addAttribute( "userTypes", UserType.values() );
        return new ModelAndView( "student/student_add", model );
    }

    @RequestMapping( value = "/student/add", method = RequestMethod.POST )
    public ModelAndView addStudentPage( @Valid @ModelAttribute( "student" ) StudentForm studentForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/student_add" );

        service.addStudent( new Student( studentForm.getName(), studentForm.getPassword(), studentForm.getEmail(), studentForm.getType() ) );

        return new ModelAndView( "redirect:/admin/student/overview" );
    }

    @RequestMapping( value = "/student/remove/{id}", method = RequestMethod.POST )
    public String removeStudent( @PathVariable( value = "id" ) int id )
    {
        Student s = service.getStudentById( id );
        service.removeStudent( s );
        return "redirect:/admin/student/overview";
    }
}
