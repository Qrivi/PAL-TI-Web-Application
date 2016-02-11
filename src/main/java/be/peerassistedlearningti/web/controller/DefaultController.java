package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.LessonForm;
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

    @RequestMapping( value = "/lesson", method = RequestMethod.GET )
    public ModelAndView getLessonPage( ModelMap model )
    {
        model.addAttribute( "lesson", new LessonForm() );
        return new ModelAndView( "lesson", model );
    }

    @RequestMapping( value = "/lesson", method = RequestMethod.POST )
    public ModelAndView addLessonPage( @Valid @ModelAttribute( "lesson" ) LessonForm lessonForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "lesson" );

        //service.addLesson( new Lesson( lessonForm.getCode(), lessonForm.getName(), lessonForm.getShortName() ) );

        return new ModelAndView( "lesson" );
    }
}
