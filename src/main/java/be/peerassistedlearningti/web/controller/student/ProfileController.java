package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping( value = "/profile" )
public class ProfileController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model, Student student )
    {
        if ( student.equals( SessionAuth.getStudent() ) )
            model = fillModel2( model, SessionAuth.getStudent() );

        if ( model.get( "user" ) == null )
            model.addAttribute( "user", student );
        if ( model.get( "pastBookings" ) == null )
            model.addAttribute( "pastBookings", service.getPastBookings( student ).size() );
        if ( model.get( "upcomingBookings" ) == null )
            model.addAttribute( "upcomingBookings", service.getUpcomingBookings( student ).size() );

        return model;
    }

    private ModelMap fillModel2( ModelMap model, Student student )
    {
        if ( model.get( "profile" ) == null )
        {
            ProfileForm profile = new ProfileForm();
            profile.setName( student.getName() );
            profile.setEmail( student.getEmail() );
            profile.setSubscriptions( student.getSubscriptions() );
            model.addAttribute( "profile", profile );
        }
        if ( model.get( "courses" ) == null )
            model.addAttribute( "courses", service.getAllCourses() );
        return model;
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getProfile()
    {
        return new ModelAndView( "redirect:/profile/" + SessionAuth.getStudent().getProfileIdentifier() );
    }

    @RequestMapping( value = "/{identifier:.+}", method = RequestMethod.GET )
    public ModelAndView getProfile( @PathVariable( "identifier" ) String id, ModelMap model )
    {
        Student student = service.getStudentByProfileIdentifier( id );

        if ( student == null )
            return new ModelAndView( "redirect:/profile" );

        return new ModelAndView( "student/profile", fillModel( model, student ) );
    }

    @RequestMapping( value = "/{identifier:.+}", method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @PathVariable( "identifier" ) String id, @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );

        Student student = SessionAuth.getStudent();
        Student s = service.getStudentByProfileIdentifier( id );

        if ( !s.equals( student ) )
            return new ModelAndView( "redirect:/profile" );

        if ( !form.getName().equals( student.getName() ) )
        {
            student.setProfileIdentifier( StudentUtils.createProfileIdentifier( form.getName() ) );
        }

        student.setName( StringUtils.defaultIfEmpty( form.getName(), student.getName() ) );
        student.setEmail( StringUtils.defaultIfEmpty( form.getEmail().toLowerCase(), student.getEmail() ) );

        if ( !form.getNewPassword().isEmpty() )
            student.setPassword( form.getNewPassword() );

        if ( !form.getAvatar().isEmpty() )
        {
            try
            {
                MultipartFile avatar = form.getAvatar();
                student.setAvatar( avatar.getBytes() );
            } catch ( Exception e )
            {
                result.reject( "SaveFile.ProfileForm.avatar" );
                return new ModelAndView( "student/profile", fillModel( model, student ) );
            }
        }

        student.setSubscriptions( form.getSubscriptions() );
        student.setLastUpdated( new Date() );

        service.updateStudent( student );
        SessionAuth.setStudent( student );

        return new ModelAndView( "redirect:/profile/" + student.getProfileIdentifier() );
    }


    @RequestMapping( value = "/reviews", method = RequestMethod.GET )
    public ModelAndView getReviews( ModelMap model )
    {
        Student current = SessionAuth.getStudent();

        List<LessonReviewWrapper> list = new ArrayList<>();

        for ( Lesson lesson : service.getPastBookings( current ) )
            list.add( new LessonReviewWrapper( lesson, service.getReviewsByStudentAndLesson( current, lesson ) ) );

        model.addAttribute( "lessonReviews", list );
        model.addAttribute( "student", SessionAuth.getStudent() );

        return new ModelAndView( "student/fragment/review" );
    }

    @RequestMapping( value = "/timeline", method = RequestMethod.GET )
    public ModelAndView getTimeline( ModelMap model )
    {
        Student current = SessionAuth.getStudent();
        Timeline timeline = new Timeline();
        timeline.addAll( service.getPastBookings( current ) );
        timeline.addAll( service.getReviewsByStudent( current ) );
        model.addAttribute( "timeline", timeline );
        model.addAttribute( "student", SessionAuth.getStudent() );
        return new ModelAndView( "student/fragment/timeline" );
    }

}
