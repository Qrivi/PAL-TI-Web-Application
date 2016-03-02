package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Request;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RequestCRUDController extends AdminController{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/requests", method = RequestMethod.GET )
    public ModelAndView getRequestOverviewPage(ModelMap model )
    {
        return new ModelAndView( "admin/requests", "requests", service.getAllRequests() );
    }

    @RequestMapping( value = "/requests", method = RequestMethod.DELETE )
    public String removeRequest( @RequestParam( required = true ) int id )
    {
        Request r = service.getRequestById( id );
        service.removeRequest( r );
        return "redirect:/admin/requests";
    }
}
