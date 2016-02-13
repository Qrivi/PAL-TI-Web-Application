package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping( value = "application" )
public class ApplicationController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getApplicationOverviewPage()
    {
        return new ModelAndView( "application", "applications", service.getAllApplications() );
    }

    @RequestMapping( value = "/approve/{id}", method = RequestMethod.POST )
    public String approveApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );
        application.accept();
        service.updateApplication( application );
        return "redirect:/application/overview";
    }

    @RequestMapping( value = "/reject/{id}", method = RequestMethod.POST )
    public String rejectApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );
        application.decline();
        service.updateApplication( application );
        return "redirect:/application/overview";
    }
}