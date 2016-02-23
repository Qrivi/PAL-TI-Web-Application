package be.peerassistedlearningti.web.controller.tutor;

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
public class LessonController extends TutorController
{

    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        if ( model.get( "lesson" ) == null )
            model.addAttribute( "lesson", new LessonForm() );
        if ( model.get( "courses" ) == null ){
            Tutor tutor = SessionAuth.getStudent().getTutor();
            model.addAttribute( "courses", tutor.getCourses() );
        }
        if ( model.get( "rooms" ) == null )
            model.addAttribute( "rooms", service.getRoomsFromCampus( Campus.PROXIMUS ) );
        return model;
    }

    @RequestMapping( value = "lessons", method = RequestMethod.GET )
    public ModelAndView getLessonOverviewPage()
    {
        return new ModelAndView( "lesson", "lessons", service.getAllLessons() );
    }

    @RequestMapping( value = "/overview/course/{id}", method = RequestMethod.GET )
    public ModelAndView getLessonOfCourse( @PathVariable( value = "id" ) int id )
    {
        Course course = service.getCourseById( id );
        return new ModelAndView( "lesson", "lessons", service.getUpcomingLessons( course ) );
    }

    @RequestMapping( value = "/lessons", method = RequestMethod.DELETE )
    public String removeLesson( @RequestParam( value = "id" ) int id )
    {
        Lesson l = service.getLessonById( id );
        service.removeLesson( l );
        return "redirect:/lesson/overview";
    }

    @RequestMapping( value = "/lessons/add", method = RequestMethod.GET )
    public ModelAndView getLessonAddPage( ModelMap model )
    {
        return new ModelAndView( "tutor/lesson_add", fillModel( model ) );
    }

    @RequestMapping( value = "/lessons/add", method = RequestMethod.POST )
    public ModelAndView addLesson( @Valid @ModelAttribute( "lesson" ) LessonForm lessonForm, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "tutor/lesson_add", fillModel( model ) );

        Tutor tutor = SessionAuth.getStudent()
                .getTutor();

        if ( tutor == null || !tutor.getCourses()
                .contains( lessonForm.getCourse() ) )
        {
            result.reject( "NoTutor.LessonForm.course" );
            return new ModelAndView( "tutor/lesson_add", fillModel( model ) );
        }

        LocalTime time = lessonForm.getDuration();
        long duration = time.getHour() * 60 + time.getMinute();

        service.addLesson( new Lesson( lessonForm.getDate(), lessonForm.getName(), lessonForm.getDescription(), duration, lessonForm.getCourse(), lessonForm.getMaxParticipants(), tutor, lessonForm.getRoom(), lessonForm.getBackupRoom() ) );

        return new ModelAndView( "redirect:/lessons" );
    }

}
