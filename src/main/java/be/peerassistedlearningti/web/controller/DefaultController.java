package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.web.model.CourseForm;
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

        // TODO add course to service

        return new ModelAndView( "course" );
    }

}
