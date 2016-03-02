package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Request;
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
public class RequestCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/requests", method = RequestMethod.GET )
    public ModelAndView getRequestOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/requests", "requests", service.getAllRequests() );
    }

    @RequestMapping( value = "/requests", method = RequestMethod.DELETE )
    public String removeRequest( @RequestParam( required = true ) int id, RedirectAttributes redirectAttributes )
    {
        Request r = service.getRequestById( id );
        service.removeRequest( r );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.RequestCRUDController.Remove", new Object[]{ r.getId() } ) );
        return "redirect:/admin/requests";
    }
}
