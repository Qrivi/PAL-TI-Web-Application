package be.peerassistedlearningti.web.controller.tutor;

import be.peerassistedlearningti.model.*;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.LessonForm;
import be.peerassistedlearningti.web.model.form.StudentUpdateForm;
import be.peerassistedlearningti.web.model.util.MailSender;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
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
public class LessonController extends TutorController
{

    @Autowired
    MailSender mailSender;
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        Tutor tutor = SessionAuth.getStudent().getTutor();
        if ( model.get( "lesson" ) == null )
            model.addAttribute( "lesson", new LessonForm() );
        if (model.get("courses") == null)
            model.addAttribute( "courses", tutor.getCourses() );
        if ( model.get( "rooms" ) == null )
            model.addAttribute( "rooms", service.getRoomsFromCampus( Campus.PROXIMUS ) );

        return model;
    }

    @RequestMapping(value = "/lessons", method = RequestMethod.GET)
    public ModelAndView getLessonOverviewPage(ModelMap model)
    {
        Tutor tutor = SessionAuth.getStudent().getTutor();
        model.addAttribute("myPastLessons", tutor.getPastLessons());
        model.addAttribute("myUpcomingLessons", tutor.getUpcomingLessons());
        return new ModelAndView("tutor/lessons", fillModel(model));
    }

    @RequestMapping(value = "/lesson/edit/{id}", method = RequestMethod.GET)
    public ModelAndView showEditPage(@PathVariable(value = "id") int id, ModelMap model)
    {
        Lesson myLesson = service.getLessonById(id);
        //Not my lesson
        if (!SessionAuth.getStudent().getTutor().equals(myLesson.getTutor())) {
            return new ModelAndView("redirect:/lessons");
        }
        model.addAttribute("lesson", new LessonForm(myLesson));
        model.addAttribute("bookings", myLesson.getBookings());
        model.addAttribute("editable", true);
        return new ModelAndView("tutor/lesson_edit", fillModel(model));
    }

    @RequestMapping(value = "/lesson/info/{id}", method = RequestMethod.GET)
    public ModelAndView showInfoPage(@PathVariable(value = "id") int id, ModelMap model) {
        Lesson myLesson = service.getLessonById(id);

        model.addAttribute("lesson", new LessonForm(myLesson));
        model.addAttribute("editable", false);
        return new ModelAndView("tutor/lesson_edit", fillModel(model));
    }

    @RequestMapping(value = "/lesson/remove/{id}", method = RequestMethod.POST)
    public ModelAndView removeLesson(@PathVariable(value = "id") int id)
    {
        Lesson lesson = service.getLessonById(id);
        if (lesson == null || !lesson.getTutor().getStudent().equals(SessionAuth.getStudent()))
            return new ModelAndView("redirect:/lessons");

        service.removeLesson(lesson);
        //TODO:: success message
        return new ModelAndView("redirect:/lessons");
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
        Lesson lesson = new Lesson(lessonForm.getDate(), lessonForm.getName(), lessonForm.getDescription(), duration, lessonForm.getCourse(), lessonForm.getMaxParticipants(), tutor, lessonForm.getRoom(), lessonForm.getBackupRoom());
        service.addLesson(lesson);
        notifySubscribers(lesson);
        return new ModelAndView( "redirect:/lessons" );
    }

    @Async
    private void notifySubscribers(Lesson lesson) {
        for (Student subscriber : lesson.getCourse().getSubscribers()) {
            mailSender.sendNotificationMail(subscriber, lesson);
        }
    }

    //TODO:: nodig ?
    @RequestMapping(value = "/overview/course/{id}", method = RequestMethod.GET)
    public ModelAndView getLessonOfCourse(@PathVariable(value = "id") int id) {
        Course course = service.getCourseById(id);
        return new ModelAndView("lesson", "lessons", service.getUpcomingLessons(course));
    }

}
