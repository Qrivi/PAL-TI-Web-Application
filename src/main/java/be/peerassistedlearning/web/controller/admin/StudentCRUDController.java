package be.peerassistedlearning.web.controller.admin;

import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.form.StudentForm;
import be.peerassistedlearning.web.model.form.StudentUpdateForm;
import be.peerassistedlearning.web.model.util.StudentUtils;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Date;

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
            model.addAttribute( "userTypes", service.getStudentTypes() );
        if ( model.get( "curriculums" ) == null )
            model.addAttribute( "curriculums", service.getCurriculums() );
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
    public ModelAndView addStudent( @Valid @ModelAttribute( "student" ) StudentForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/students", fillModel( model ) );

        service.addStudent( new Student( form.getName(), form.getPassword(), form.getEmail(), form.getCurriculum(), StudentUtils.createProfileIdentifier( form.getName() ), form.getType() ) );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.StudentCRUDController.Add", new Object[]{ form.getName() } ) );

        return new ModelAndView( "redirect:/admin/students" );
    }

    @RequestMapping( value = "/students", method = RequestMethod.PUT )
    public ModelAndView updateStudent( @Valid @ModelAttribute( "updateStudent" ) StudentUpdateForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
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
        s.setCurriculum( ObjectUtils.defaultIfNull( form.getCurriculum(), s.getCurriculum() ) );

        if ( !StringUtils.isEmpty( password ) )
            s.setPassword( password );

        s.setLastUpdated( new Date() );
        service.updateStudent( s );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.StudentCRUDController.Update", new Object[]{ form.getName() } ) );

        return new ModelAndView( "redirect:/admin/students" );
    }

    @RequestMapping( value = "/students", method = RequestMethod.DELETE )
    public ModelAndView removeStudent( @RequestParam( required = true ) int id, RedirectAttributes redirectAttributes )
    {
        Student s = service.getStudentById( id );
        service.removeStudent( s );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.StudentCRUDController.Remove", new Object[]{ s.getName() } ) );
        return new ModelAndView( "redirect:/admin/students" );
    }
}
