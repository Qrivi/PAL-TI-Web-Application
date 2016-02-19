package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

@Controller
@RequestMapping( value = "application" )
public class ApplicationController
{
    @Autowired
    private PALService service;

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

        Tutor tutor = SessionAuth.getStudent().getTutor();
        if(tutor == null){
            Set<Course> courses = new HashSet<Course>();
            courses.add(application.getCourse());
            service.addTutor(new Tutor(SessionAuth.getStudent(), courses));
        } else {
            tutor.addCourse(application.getCourse());
        }

        return "redirect:/application/overview";
    }

    @RequestMapping( value = "/screenshot/{id}", method = RequestMethod.GET )
    @ResponseBody
    public void getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        try
        {
            InputStream is = new ByteArrayInputStream( service.getApplicationById( id )
                    .getScreenshot() );
            IOUtils.copy( is, response.getOutputStream() );
            response.flushBuffer();
        } catch ( Exception e ) {}
    }
}