package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ReviewForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.Date;

public class ReviewCRUDController {
    @Autowired
    private PALService service;

    private ModelMap fillModel(ModelMap model )
    {
        if ( model.get( "review" ) == null )
            model.addAttribute( "review", new ReviewForm() );
        if ( model.get( "reviews" ) == null )
            model.addAttribute( "reviews", service.getAllReviews() );
        return model;
    }

    @RequestMapping( value = "/reviews", method = RequestMethod.GET )
    public ModelAndView getReviewOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/reviews", fillModel( model ) );
    }

    @RequestMapping( value = "/reviews", method = RequestMethod.POST )
    public ModelAndView addReview(@Valid @ModelAttribute( "review" ) ReviewForm reviewForm, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/reviews", fillModel( model ) );

        //TODO pass lesson
        service.addReview( new Review( reviewForm.getText(), SessionAuth.getStudent(), new Lesson(), reviewForm.getContentScore(), reviewForm.getTutorScore(), reviewForm.getEngagementScore(), reviewForm.getAtmosphereScore(), reviewForm.isAnonymous(), new Date() ));

        return new ModelAndView( "redirect:/admin/reviews" );
    }

    @RequestMapping( value = "/reviews", method = RequestMethod.DELETE )
    public String removeReview( @RequestParam( required = true ) int id )
    {
        Review r = service.getReviewById( id );
        service.removeReview( r );
        return "redirect:/admin/reviews";
    }
}
