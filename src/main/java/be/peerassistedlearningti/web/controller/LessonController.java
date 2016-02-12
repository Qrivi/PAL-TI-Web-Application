package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Campus;
import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.LessonForm;
import be.peerassistedlearningti.web.model.RoomForm;
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
public class LessonController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getLessonDetailPage( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        return new ModelAndView( "lesson_add", "lesson", service.getLessonById( id ) );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getLessonAddPage()
    {
        ModelMap model = new ModelMap();
        model.addAttribute( "courses", service.getAllCourses() );
        model.addAttribute( "rooms", service.getRoomsFromCampus( Campus.PROXIMUS ) );
        return new ModelAndView( "lesson_add", model );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeLesson( @PathVariable( value = "id" ) int id )
    {
        Lesson l = service.getLessonById( id );
        service.removeLesson( l );
        return "redirect:/lesson/overview";
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addLesson( @Valid @ModelAttribute( "lesson" ) LessonForm lessonForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "lesson_add" );

        /*TODO authenticated tutor
        service.addLesson( new Lesson( lessonForm.getDate(), lessonForm.getDuration(), lessonForm.getCourse(), lessonForm.getMaxParticipants(), ,lessonForm.getRoom(), lessonForm.getBackupRoom() ) );
        */

        return new ModelAndView( "redirect:/lesson/overview" );
    }
}
