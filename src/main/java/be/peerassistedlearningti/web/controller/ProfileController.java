package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.validation.ProfileValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping( value = "/profile" )
@PreAuthorize( "hasRole('ROLE_USER')" )
public class ProfileController
{

    @Autowired
    private PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView modifyStudentProfile( Authentication auth )
    {
        Student current = (Student) auth.getPrincipal();
        ProfileForm profile = new ProfileForm();
        profile.setName( current.getName() );
        profile.setEmail( current.getEmail() );
        return new ModelAndView( "profile", "profile", profile );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result )
    {
        ProfileValidator profileValidator = new ProfileValidator();
        profileValidator.validate( form, result );

        if ( result.hasErrors() )
            return new ModelAndView( "profile" );

        Student student = new Student();

        student.setName( form.getName() );
        student.setEmail( form.getEmail() );

        if ( form.getNewPassword() != null )
        {
            student.setPassword( form.getNewPassword() );
        }

        // TODO update session object

        service.updateStudent( student );

        return new ModelAndView( "profile" );
    }

}
