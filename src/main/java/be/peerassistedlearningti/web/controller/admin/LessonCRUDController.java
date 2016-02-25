package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Campus;
import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.LessonForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.time.LocalTime;

@Controller
public class LessonCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "lessons", method = RequestMethod.GET )
    public ModelAndView getLessonOverviewPage()
    {
        return new ModelAndView( "admin/lessons", "lessons", service.getAllLessons() );
    }

    @RequestMapping( value = "/lessons", method = RequestMethod.DELETE )
    public String removeLesson( @RequestParam( value = "id" ) int id )
    {
        Lesson l = service.getLessonById( id );
        service.removeLesson( l );
        return "redirect:/admin/lessons";
    }
}
