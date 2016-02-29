package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.form.ReviewForm;
import be.peerassistedlearningti.web.model.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping( value = "/profile" )
public class ProfileController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model, Student student )
    {
        Tutor tutor = student.getTutor();

        if ( model.get( "profile" ) == null )
        {
            ProfileForm profile = new ProfileForm();
            profile.setName( student.getName() );
            profile.setEmail( student.getEmail() );
            profile.setSubscriptions( student.getSubscriptions() );
            model.addAttribute( "profile", profile );
        }
        if ( model.get( "user" ) == null )
        {
            model.addAttribute( "user", student );
        }
        if ( model.get( "review" ) == null )
        {
            model.addAttribute( "review", new ReviewForm() );
        }
        if ( model.get( "timeline" ) == null )
        {
            Timeline timeline = new Timeline();
            timeline.addAll( service.getPastBookings( student ) );
            timeline.addAll( service.getReviewsForStudent( student ) );
            model.addAttribute( "timeline", timeline );
        }
        if ( model.get( "courses" ) == null )
        {
            model.addAttribute( "courses", service.getAllCourses() );
        }
        if ( model.get( "pastBookings" ) == null )
        {
            model.addAttribute( "pastBookings", service.getPastBookings( student ).size() );
        }
        if ( model.get( "upcomingBookings" ) == null )
        {
            model.addAttribute( "upcomingBookings", service.getUpcomingBookings( student ).size() );
        }
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
        {
            student.setPassword( form.getNewPassword() );
        }

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

        service.updateStudent( student );
        SessionAuth.setStudent( student );

        return new ModelAndView( "redirect:/profile" );
    }

    @ResponseBody
    @RequestMapping( value = "/reviews", method = RequestMethod.GET, produces = "application/json" )
    public ArrayList<ReviewDTO> getReviews()
    {
        Student current = SessionAuth.getStudent();

        return new ArrayList<>( service.getPastBookings( current ).stream().map( b -> {
            Review review = service.getReviewsForStudentAndLesson( current, b );
            String text = ( review != null ? review.getText() : null );
            Student tutor = b.getTutor().getStudent();
            return new ReviewDTO( current.getId(), tutor.getId(), tutor.getName(), b.getCourse().getName(), b.getId(), b.getName(), b.getDescription(), b.getDate(), text, service
                    .getReviewsForStudentAndLesson( current, b ) != null );
        } ).collect( Collectors.toSet() ) );
    }

    @RequestMapping( value = "/reviews/{id}", method = RequestMethod.GET )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );
        //I did not go this lesson or lesson is not in the past
        if ( lesson == null || !lesson.getBookings().contains( current ) || !lesson.getDate().before( new Date() ) )
        {
            return new ModelAndView( "redirect:/profile" );
        }
        Review myReview = service.getReviewsForStudentAndLesson( current, lesson );
        if ( myReview != null )
        {
            ReviewForm form = new ReviewForm();
            form.setText( myReview.getText() );
            form.setAnonymous( myReview.isAnonymous() );
            form.setTutorScore( myReview.getTutorScore() );
            form.setContentScore( myReview.getContentScore() );
            form.setAtmosphereScore( myReview.getAtmosphereScore() );
            form.setEngagementScore( myReview.getEngagementScore() );
            model.addAttribute( "review", form );
        }
        model.addAttribute( "lesson", lesson );
        return new ModelAndView( "student/review_add", fillModel( model, current ) );
    }

    @RequestMapping( value = "/lesson/{id}/reviews/add", method = RequestMethod.POST )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, @Valid @ModelAttribute( "review" ) ReviewForm reviewForm, BindingResult result, ModelMap model )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );
        //I did not go this lesson or lesson is not in the past
        if ( lesson == null || !lesson.getBookings().contains( current ) || !lesson.getDate().before( new Date() ) )
        {
            return new ModelAndView( "redirect:/profile" );
        } else if ( result.hasErrors() )
        {
            return new ModelAndView( "student/review_add", fillModel( model, current ) );
        }
        Review review = service.getReviewsForStudentAndLesson( current, lesson );
        if ( review == null )
        {
            review = new Review( reviewForm.getText(), SessionAuth.getStudent(), lesson, reviewForm.getContentScore(), reviewForm.getTutorScore(), reviewForm.getEngagementScore(), reviewForm
                    .getAtmosphereScore(), reviewForm.isAnonymous(), new Date() );
        } else
        {
            review.setText( reviewForm.getText() );
            review.setAnonymous( reviewForm.isAnonymous() );
            review.setContentScore( reviewForm.getContentScore() );
            review.setEngagementScore( reviewForm.getEngagementScore() );
            review.setAtmosphereScore( reviewForm.getAtmosphereScore() );
            review.setTutorScore( reviewForm.getTutorScore() );
        }

        service.addReview( review );
        return new ModelAndView( "redirect:/profile", fillModel( model, current ) );
    }
}
