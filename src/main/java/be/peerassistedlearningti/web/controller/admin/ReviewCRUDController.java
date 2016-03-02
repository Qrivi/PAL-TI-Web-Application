package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Review;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ReviewCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/reviews", method = RequestMethod.GET )
    public ModelAndView getReviewOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/reviews", "reviews", service.getAllReviews() );
    }

    @RequestMapping( value = "/reviews", method = RequestMethod.DELETE )
    public String removeReview( @RequestParam( required = true ) int id, RedirectAttributes redirectAttributes )
    {
        Review r = service.getReviewById( id );
        service.removeReview( r );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ReviewCRUDController.Remove", new Object[]{ r.getId() } ) );
        return "redirect:/admin/reviews";
    }
}
