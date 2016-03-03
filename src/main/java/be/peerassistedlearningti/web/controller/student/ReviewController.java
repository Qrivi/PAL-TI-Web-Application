package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ReviewForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Date;

@Controller
@RequestMapping( value = "/reviews" )
public class ReviewController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model, Review review, Lesson lesson )
    {
        if ( model.get( "review" ) == null )
        {
            ReviewForm form = new ReviewForm();
            if ( review != null )
            {
                form.setText( review.getText() );
                form.setAnonymous( review.isAnonymous() );
                form.setTutorScore( review.getTutorScore() );
                form.setContentScore( review.getContentScore() );
                form.setAtmosphereScore( review.getAtmosphereScore() );
                form.setEngagementScore( review.getEngagementScore() );
            }
            model.addAttribute( "review", form );
        }
        if ( model.get( "lesson" ) == null )
            model.addAttribute( "lesson", lesson );
        return model;
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );

        if ( lesson == null || !lesson.getBookings().contains( current ) || !lesson.getDate().before( new Date() ) )
            return new ModelAndView( "redirect:/profile" );

        Review review = service.getReviews( current, lesson );
        return new ModelAndView( "student/review_add", fillModel( model, review, lesson ) );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.POST )
    public ModelAndView addReview( @PathVariable( value = "id" ) int id, @Valid @ModelAttribute( "review" ) ReviewForm reviewForm, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        Student current = SessionAuth.getStudent();
        Lesson lesson = service.getLessonById( id );

        if ( lesson == null || !lesson.getBookings().contains( current ) || !lesson.getDate().before( new Date() ) )
            return new ModelAndView( "redirect:/profile" );

        if ( result.hasErrors() )
            return new ModelAndView( "student/review_add", fillModel( model, null, lesson ) );

        Review review = service.getReviews( current, lesson );
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
            review.setDate( new Date() );
        }

        service.addReview( review );
        redirectAttributes
                .addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ProfileController.Review", new Object[]{ review.getLesson().getTutor().getStudent().getName() } ) );
        return new ModelAndView( "redirect:/profile/" + current.getProfileIdentifier() );
    }

}
