package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.LessonReviewWrapper;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping( value = "/profile" )
public class ProfileController extends StudentController
{
    @Autowired
    private PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getProfile()
    {
        return new ModelAndView( "redirect:/profile/" + SessionAuth.getStudent().getProfileIdentifier() );
    }

    @RequestMapping( value = "/reviews", method = RequestMethod.GET )
    public ModelAndView getReviews( ModelMap model )
    {
        Student current = SessionAuth.getStudent();

        List<LessonReviewWrapper> list = new ArrayList<>();

        for ( Lesson lesson : service.getPastBookings( current ) )
            list.add( new LessonReviewWrapper( lesson, service.getReviewsByStudentAndLesson( current, lesson ) ) );

        Collections.sort( list );

        model.addAttribute( "lessonReviews", list );
        model.addAttribute( "student", SessionAuth.getStudent() );

        return new ModelAndView( "student/fragment/review" );
    }

}
