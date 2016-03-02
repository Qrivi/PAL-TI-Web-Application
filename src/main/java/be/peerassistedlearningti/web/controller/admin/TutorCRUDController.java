package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Tutor;
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
public class TutorCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/tutors", method = RequestMethod.GET )
    public ModelAndView getTutorOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/tutors", "tutors", service.getAllTutors() );
    }

    @RequestMapping( value = "/tutors", method = RequestMethod.DELETE )
    public String removeTutor( @RequestParam( required = true ) int id, RedirectAttributes redirectAttributes )
    {
        Tutor t = service.getTutorById( id );
        service.removeTutor( t );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.TutorCRUDController.Remove", new Object[]{ t.getStudent().getName() } ) );
        return "redirect:/admin/tutors";
    }
}
