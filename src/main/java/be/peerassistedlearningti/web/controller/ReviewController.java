package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ReviewForm;
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
import java.util.Date;

@Controller
@RequestMapping( value = "/review" )
public class ReviewController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getReviewOverviewPage()
    {
        return new ModelAndView( "review", "reviews", service.getAllReviews() );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getReviewDetailPage(@PathVariable( value = "id" ) int id, ModelMap model )
    {
        return new ModelAndView( "review_add", "review", service.getReviewById( id ) );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getReviewAddPage()
    {
        return new ModelAndView( "review_add", "review", new ReviewForm() );
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addReview(@Valid @ModelAttribute( "review" ) ReviewForm reviewForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "review_add" );

        //TODO pass Lesson
        service.addReview( new Review( reviewForm.getText(), SessionAuth.getStudent(), new Lesson(), reviewForm.getContentScore(), reviewForm.getTutorScore(), reviewForm.getEngagementScore(), reviewForm.getAtmosphereScore(), reviewForm.isAnonymous(), new Date() ) );

        return new ModelAndView( "redirect:/review/overview" );
    }
}

