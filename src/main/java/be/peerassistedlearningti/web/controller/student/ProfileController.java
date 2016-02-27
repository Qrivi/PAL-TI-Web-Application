package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.form.ReviewForm;
import be.peerassistedlearningti.web.model.util.LessonReviewWrapper;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.Timeline;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
        if ( tutor != null && model.get( "reviews" ) == null )
        {
            model.addAttribute( "reviews", service.getReviewsForStudent( student ) );
        }
        if(model.get("lessonReviews") == null){
            List<LessonReviewWrapper> list = new ArrayList<>();
            for(Lesson lesson: student.getClosedBookings()){
                list.add(new LessonReviewWrapper(lesson,service.getReviewsForStudentAndLesson(student,lesson)));
            }
        }
        if (model.get("review") == null) {
            model.addAttribute("review", new ReviewForm());
        }
        if ( model.get( "timeline" ) == null )
        {
            Timeline timeline = new Timeline();
            timeline.addAll( service.getPastLessons( student ) );
            timeline.addAll( service.getReviewsForStudent( student ) );
            model.addAttribute( "timeline", timeline );
        }
        if ( model.get( "courses" ) == null )
        {
            model.addAttribute( "courses", service.getAllCourses() );
        }
        return model;
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getProfile( ModelMap model )
    {
        return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getOtherProfile( @PathVariable( "id" ) int id, ModelMap model )
    {
        Student student = service.getStudentById( id );

        if ( student == null )
            return new ModelAndView( "redirect:/profile" );

        return new ModelAndView( "student/profile", fillModel( model, student ) );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );

        Student student = SessionAuth.getStudent();

        student.setName( StringUtils.defaultIfEmpty( form.getName(), student.getName() ) );
        student.setEmail( StringUtils.defaultIfEmpty( form.getEmail(), student.getEmail() ) );

        if ( !form.getNewPassword()
                .isEmpty() )
        {
            student.setPassword( form.getNewPassword() );
        }

        if ( !form.getAvatar()
                .isEmpty() )
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

    @RequestMapping(value = "/lesson/{id}/reviews/add", method = RequestMethod.POST)
    public ModelAndView addReview(@PathVariable(value = "id") int id, @Valid @ModelAttribute("review") ReviewForm reviewForm, BindingResult result, ModelMap model) {
        Lesson lesson = service.getLessonById(id);
        if (lesson == null || !lesson.getBookings().contains(SessionAuth.getStudent())) {
            return new ModelAndView("redirect:/profile");
        } else if (result.hasErrors()) {
            return new ModelAndView("/profile", fillModel(model, SessionAuth.getStudent()));
        }
        Review review = new Review(reviewForm.getText(), SessionAuth.getStudent(), lesson, reviewForm.getContentScore(), reviewForm.getTutorScore(), reviewForm.getEngagementScore(), reviewForm.getAtmosphereScore(), reviewForm.isAnonymous(), new Date());
        service.addReview(review);
        model.addAttribute("addedReview", review.getId());
        return new ModelAndView("/profile", fillModel(model, SessionAuth.getStudent()));
    }
}
