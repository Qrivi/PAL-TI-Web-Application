package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.ProfileForm;
import be.peerassistedlearningti.web.model.validator.ProfileValidator;
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
@RequestMapping( value = "/profile" )
public class ProfileController
{

    @Autowired
    private PALService service;

    @Autowired
    private ProfileValidator profileValidator;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView modifyStudentProfile( ModelMap model )
    {
        // TODO : get student object from session (replace)
        ProfileForm profile = new ProfileForm();
        profile.setName( "David Op de Beeck" );
        profile.setEmail( "davidopdebeeck@hotmail.com" );
        return new ModelAndView( "profile", "profile", profile );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result )
    {
        profileValidator.validate( form, result );

        if ( result.hasErrors() )
            return new ModelAndView( "profile" );

        Student student = new Student();

        student.setName( form.getName() );
        student.setEmail( form.getEmail() );

        if ( form.getPassword() != null )
        {
            student.setPassword( form.getPassword() );
        }

        // TODO update session object and update in database

        //service.updateStudent( student );

        return new ModelAndView( "profile" );
    }

}
