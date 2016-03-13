package be.peerassistedlearning.web.controller.tutor;

import be.peerassistedlearning.model.Campus;
import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.model.Tutor;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.form.LessonForm;
import be.peerassistedlearning.web.model.util.MailSender;
import be.peerassistedlearning.web.model.util.SessionAuth;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );
        if ( model.get( "lesson" ) == null )
            model.addAttribute( "lesson", new LessonForm() );
        if ( model.get( "courses" ) == null )
            model.addAttribute( "courses", tutor.getCourses() );
        if ( model.get( "rooms" ) == null )
            model.addAttribute( "rooms", service.getRooms( Campus.PROXIMUS ) );
        if ( model.get( "requests" ) == null )
            model.addAttribute( "requests", service.getRequests( tutor.getCourses() ) );
        return model;
    }

    @RequestMapping( value = "/lessons", method = RequestMethod.GET )
    public ModelAndView getLessonOverviewPage( ModelMap model )
    {
        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );
        model.addAttribute( "myPastLessons", service.getPastLessons( tutor ) );
        model.addAttribute( "myUpcomingLessons", service.getUpcomingLessons( tutor ) );
        return new ModelAndView( "tutor/lessons", model );
    }

    @RequestMapping( value = "/lessons/edit/{id}", method = RequestMethod.GET )
    public ModelAndView showEditPage( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Lesson lesson = service.getLessonById( id );

        if ( lesson == null )
            return new ModelAndView( "redirect:/tutor/lessons" );

        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );

        if ( !tutor.equals( lesson.getTutor() ) )
            return new ModelAndView( "redirect:/tutor/lessons" );

        model.addAttribute( "lesson", new LessonForm( lesson ) );
        model.addAttribute( "bookings", lesson.getBookings() );
        model.addAttribute( "editable", true );
        return new ModelAndView( "tutor/lesson_edit", fillModel( model ) );
    }

    @RequestMapping( value = "/lessons/edit/{id}", method = RequestMethod.PUT )
    public ModelAndView editLesson( @PathVariable( value = "id" ) int id, @Valid @ModelAttribute( "lesson" ) LessonForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        Lesson lesson = service.getLessonById( id );

        if ( lesson == null )
            return new ModelAndView( "redirect:/tutor/lessons" );

        if ( result.hasErrors() )
        {
            model.addAttribute( "bookings", lesson.getBookings() );
            model.addAttribute( "editable", true );
            return new ModelAndView( "tutor/lesson_edit", fillModel( model ) );
        }

        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );

        if ( !tutor.equals( lesson.getTutor() ) || !tutor.getCourses().contains( form.getCourse() ) )
            return new ModelAndView( "redirect:/tutor/lessons" );

        lesson.setName( form.getName() );
        lesson.setDescription( form.getDescription() );
        lesson.setCourse( form.getCourse() );
        lesson.setDate( form.getDate() );
        lesson.setDuration( localTimeToMinutes( form.getDuration() ) );
        lesson.setMaxParticipants( form.getMaxParticipants() );
        lesson.setRoom( form.getRoom() );
        lesson.setBackupRoom( form.getBackupRoom() );

        if ( form.getRequest() != null )
        {
            lesson.setRequest( form.getRequest() );
        }

        service.updateLesson( lesson );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.LessonController.Save", new Object[]{ form.getName() } ) );
        return new ModelAndView( "redirect:/tutor/lessons" );
    }

    @RequestMapping( value = "/lessons/info/{id}", method = RequestMethod.GET )
    public ModelAndView showInfoPage( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Lesson myLesson = service.getLessonById( id );
        model.addAttribute( "lesson", new LessonForm( myLesson ) );
        model.addAttribute( "bookings", myLesson.getBookings() );
        model.addAttribute( "editable", false );
        return new ModelAndView( "tutor/lesson_edit", model );
    }

    @RequestMapping( value = "/lessons/remove", method = RequestMethod.DELETE )
    public ModelAndView removeLesson( @RequestParam( value = "id" ) int id, RedirectAttributes redirectAttributes )
    {
        Lesson lesson = service.getLessonById( id );
        if ( lesson == null || !lesson.getTutor().getStudent().equals( SessionAuth.getStudent() ) )
            return new ModelAndView( "redirect:/tutor/lessons" );

        service.removeLesson( lesson );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.LessonController.Remove", new Object[]{ lesson.getName() } ) );

        return new ModelAndView( "redirect:/tutor/lessons" );
    }

    @RequestMapping( value = "/lessons/add", method = RequestMethod.GET )
    public ModelAndView getLessonAddPage( ModelMap model )
    {
        return new ModelAndView( "tutor/lesson_add", fillModel( model ) );
    }

    @RequestMapping( value = "/lessons/add", method = RequestMethod.POST )
    public ModelAndView addLesson( @Valid @ModelAttribute( "lesson" ) LessonForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "tutor/lesson_add", fillModel( model ) );

        Tutor tutor = service.getTutorByStudent( SessionAuth.getStudent() );

        if ( tutor == null || !tutor.getCourses().contains( form.getCourse() ) )
        {
            result.reject( "NoTutor.LessonForm.course" );
            return new ModelAndView( "tutor/lesson_add", fillModel( model ) );
        }

        Lesson lesson = new Lesson( form.getDate(), form.getName(), form.getDescription(), localTimeToMinutes( form.getDuration() ), form.getCourse(), form.getMaxParticipants(), tutor, form
                .getRoom(), form.getBackupRoom() );
        if ( form.getRequest() != null )
        {
            lesson.setRequest( form.getRequest() );
        }

        service.addLesson( lesson );
        notifySubscribers( lesson );

        return new ModelAndView( "redirect:/tutor/lessons" );
    }

    private void notifySubscribers( Lesson lesson )
    {
        for ( Student subscriber : lesson.getCourse().getSubscribers() )
            mailSender.sendNotificationMail( subscriber, lesson );
    }

    private long localTimeToMinutes( LocalTime time )
    {
        return time.getHour() * 60 + time.getMinute();
    }
}
