package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.dto.LessonTimelineDTO;
import be.peerassistedlearningti.web.model.dto.ReviewDTO;
import be.peerassistedlearningti.web.model.dto.ReviewTimelineDTO;
import be.peerassistedlearningti.web.model.dto.TimelineDTO;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.form.ReviewForm;
import be.peerassistedlearningti.web.model.util.*;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

        Tutor tutor = student.getTutor();

        if ( model.get( "user" ) == null )
        {
            model.addAttribute( "user", student );
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
        {
            model.addAttribute( "courses", service.getAllCourses() );
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
        ArrayList<ReviewDTO> reviews = new ArrayList<>( service.getPastBookings( current ).stream().map( b -> {
            Review review = service.getReviewsForStudentAndLesson( current, b );
            String text = ( review != null ? review.getText() : null );
            Student tutor = b.getTutor().getStudent();
            return new ReviewDTO( current.getId(), tutor.getId(), tutor.getName(), tutor.getProfileIdentifier(), b.getCourse().getName(), b.getId(), b.getName(), b.getDescription(), b
                    .getDate(), text, service.getReviewsForStudentAndLesson( current, b ) != null );
        } ).collect( Collectors.toSet() ) );

        Collections.sort( reviews, ( o1, o2 ) -> o1.getLessonDate().compareTo( o2.getLessonDate() ) );

        return reviews;
    }

    @ResponseBody
    @RequestMapping( value = "/timeline", method = RequestMethod.GET, produces = "application/json" )
    public ArrayList<TimelineDTO> getTimeline()
    {
        Student current = SessionAuth.getStudent();
        ArrayList<TimelineDTO> timeline = new ArrayList<>();

        timeline.addAll( service.getPastBookings( current ).stream().map( b -> {
            Student tutor = b.getTutor().getStudent();
            return new LessonTimelineDTO( b.getCourse().getName(), tutor.getName(), b.getName(), b.getDescription(), b.getDate() );
        } ).collect( Collectors.toSet() ) );

        timeline.addAll( service.getReviewsForStudent( current ).stream().map( r -> {
            if ( r.isAnonymous() )
                return null;
            return new ReviewTimelineDTO( r.getText(), r.getLesson().getTutor().getStudent().getName(), r.getDate() );
        } ).collect( Collectors.toSet() ) );

        Collections.sort( timeline, ( o1, o2 ) -> o1.getArchiveDate().compareTo( o2.getArchiveDate() ) );

        return timeline;
    }

    //================================================================================
    // region Reviews
    //================================================================================

    @RequestMapping( value = "/reviews/{id}", method = RequestMethod.GET )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );

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
        return new ModelAndView( "student/review_add", model );
    }

    @RequestMapping( value = "/reviews/{id}", method = RequestMethod.POST )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, @Valid @ModelAttribute( "review" ) ReviewForm reviewForm, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );

        if ( lesson == null || !lesson.getBookings().contains( current ) || !lesson.getDate().before( new Date() ) )
        {
            return new ModelAndView( "redirect:/profile" );
        }

        if ( result.hasErrors() )
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
        redirectAttributes
                .addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ProfileController.Review", new Object[]{ review.getLesson().getTutor().getStudent().getName() } ) );
        return new ModelAndView( "redirect:/profile/" + current.getProfileIdentifier() );
    }

    //================================================================================
    // end region
    //================================================================================
}
