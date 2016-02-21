package be.peerassistedlearningti.web.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.time.LocalTime;

@Controller
@RequestMapping( value = "lesson" )
public class LessonController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getLessonOverviewPage()
    {
        return new ModelAndView( "lesson", "lessons", service.getAllLessons() );
    }

    @RequestMapping( value = "/overview/course/{id}", method = RequestMethod.GET )
    public ModelAndView getLessonOfCourse( @PathVariable( value = "id" ) int id )
    {
        Course course = service.getCourseById(id);
        return new ModelAndView( "lesson", "lessons", service.getLessons(course) );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getLessonDetailPage( @PathVariable( value = "id" ) int id )
    {
        return new ModelAndView( "lesson_add", "lesson", service.getLessonById( id ) );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getLessonAddPage()
    {
        ModelMap model = new ModelMap();
        model.addAttribute( "lesson", new LessonForm() );
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

        Tutor tutor = SessionAuth.getStudent().getTutor();
        if (!tutor.getCourses().contains(lessonForm.getCourse())) {
            result.reject("NoTutor.LessonForm.course");
        }

        LocalTime time = lessonForm.getDuration();
        long duration = time.getHour() * 60 + time.getMinute();

        service.addLesson( new Lesson( lessonForm.getDate(), lessonForm.getName(), lessonForm.getDescription(), duration, lessonForm.getCourse(), Integer.parseInt( lessonForm.getMaxParticipants() ), tutor, lessonForm.getRoom(), lessonForm.getBackupRoom() ) );

        return new ModelAndView( "redirect:/lesson/overview" );
    }

    //TODO pass student
    @RequestMapping( value = "/register/{id}", method = RequestMethod.POST )
    public String RegisterForLesson( @PathVariable( value = "id" ) int id )
    {
        Lesson l = service.getLessonById( id );
        return "redirect:/booking/add";
    }

    @RequestMapping( value = "/reviews/lesson/{id}", method = RequestMethod.POST )
    public ModelAndView getReviews( @PathVariable( value = "id" ) int id )
    {
        Lesson l = service.getLessonById( id );
        return new ModelAndView( "lesson_add", "lesson", service.getLessonById( id ) );
    }
}
