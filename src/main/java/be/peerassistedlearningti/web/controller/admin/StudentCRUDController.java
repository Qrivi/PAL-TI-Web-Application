package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.StudentForm;
import be.peerassistedlearningti.web.model.form.StudentUpdateForm;
import be.peerassistedlearningti.web.model.util.StudentUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
public class StudentCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        if ( model.get( "student" ) == null )
            model.addAttribute( "student", new StudentForm() );
        if ( model.get( "updateStudent" ) == null )
            model.addAttribute( "updateStudent", new StudentUpdateForm() );
        if ( model.get( "userTypes" ) == null )
            model.addAttribute( "userTypes", UserType.values() );
        if ( model.get( "students" ) == null )
            model.addAttribute( "students", service.getAllStudents() );
        return model;
    }

    @RequestMapping( value = "/students", method = RequestMethod.GET )
    public ModelAndView getStudentOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/students", fillModel( model ) );
    }

    @RequestMapping( value = "/students", method = RequestMethod.POST )
    public ModelAndView addStudent( @Valid @ModelAttribute( "student" ) StudentForm studentForm, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/students", fillModel( model ) );

        service.addStudent( new Student( studentForm.getName(), studentForm.getPassword(), studentForm.getEmail(), StudentUtils.createProfileIdentifier( studentForm.getName() ), studentForm
                .getType() ) );

        return new ModelAndView( "redirect:/admin/students" );
    }

    @RequestMapping( value = "/students", method = RequestMethod.PUT )
    public ModelAndView updateStudent( @Valid @ModelAttribute( "updateStudent" ) StudentUpdateForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/students", fillModel( model ) );

        Integer id = form.getId();

        if ( id == null )
            return new ModelAndView( "admin/students", fillModel( model ) );

        Student s = service.getStudentById( id );

        if ( s == null )
            return new ModelAndView( "admin/students", fillModel( model ) );

        String email = form.getEmail();

        if ( !StringUtils.isEmpty( email ) )
        {
            Student s2 = service.getStudentByEmail( email );
            if ( s2 != null && !s.equals( s2 ) )
            {
                result.reject( "CheckEmailIsUnique.StudentUpdateForm.email" );
                return new ModelAndView( "admin/students", fillModel( model ) );
            }
        }

        String password = form.getPassword();

        s.setName( StringUtils.defaultIfEmpty( form.getName(), s.getName() ) );
        s.setEmail( StringUtils.defaultIfEmpty( email, s.getEmail() ) );
        s.setType( ObjectUtils.defaultIfNull( form.getType(), s.getType() ) );

        if ( !StringUtils.isEmpty( password ) )
            s.setPassword( password );

        service.updateStudent( s );
        return new ModelAndView( "redirect:/admin/students" );
    }

    @RequestMapping( value = "/students", method = RequestMethod.DELETE )
    public ModelAndView removeStudent( @RequestParam( required = true ) int id )
    {
        Student s = service.getStudentById( id );
        service.removeStudent( s );
        return new ModelAndView( "redirect:/admin/students" );
    }
}
