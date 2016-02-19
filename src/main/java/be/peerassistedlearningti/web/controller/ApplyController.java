package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.TutorApplyForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping( value = "/apply" )
public class ApplyController
{

    @Autowired
    private PALService service;

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

        try
        {
            MultipartFile screenshot = form.getScreenshot();
            service.addApplication( new Application( SessionAuth.getStudent(), form.getCourse(), screenshot.getBytes() ) );
        } catch ( Exception e )
        {
            result.reject( "SaveFile.TutorApplyForm.screenshot" );
        }

        return new ModelAndView( "tutor_apply" );
    }

}
