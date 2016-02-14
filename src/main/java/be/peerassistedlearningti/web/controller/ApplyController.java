package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.file.FileManager;
import be.peerassistedlearningti.web.model.form.TutorApplyForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping( value = "/apply" )
public class ApplyController
{

    @Autowired
    private PALService service;

    @Autowired
    private FileManager fileManager;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView applyTutor( ModelMap model )
    {
        model.addAttribute( "tutorApply", new TutorApplyForm() );
        model.addAttribute( "courses", service.getAllCourses() );
        return new ModelAndView( "tutor_apply", model );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView applyTutor( @Valid @ModelAttribute( "tutorApply" ) TutorApplyForm form, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "tutor_apply" );

        Student david = new Student( "David", "123", "davidopdebeeck@hotmail.com", true );

        service.addStudent( david );

        String path = fileManager.saveFile( form.getScreenshot() );

        if ( path == null )
        {
            result.reject( "SaveFile.TutorApplyForm.screenshot" );
        } else
        {
            service.addApplication( new Application( david, form.getCourse(), path ) );
        }

        return new ModelAndView( "tutor_apply" );
    }

}
