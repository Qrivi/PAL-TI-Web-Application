package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.file.FileManager;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

@Controller
@RequestMapping( value = "application" )
public class ApplicationController
{
    @Autowired
    private PALService service;

    @Autowired
    private FileManager fileManager;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getApplicationOverviewPage()
    {
        return new ModelAndView( "application", "applications", service.getAllPendingApplications() );
    }

    @RequestMapping( value = "/approve/{id}", method = RequestMethod.POST )
    public String approveApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );

        application.approve();
        service.updateApplication( application );

        return "redirect:/application/overview";
    }

    @RequestMapping( value = "/reject/{id}", method = RequestMethod.POST )
    public String rejectApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );

        application.reject();
        service.updateApplication( application );

        return "redirect:/application/overview";
    }

    @RequestMapping( value = "/screenshot/{id}", method = RequestMethod.GET )
    @ResponseBody
    public void getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        File file = fileManager.getFile( service.getApplicationById( id )
                .getScreenshotURL() );
        try
        {
            File downloadFile = new File( file.getPath() );
            InputStream is = new FileInputStream( downloadFile );
            IOUtils.copy( is, response.getOutputStream() );
            response.flushBuffer();
        } catch ( Exception e ) {}
    }
}