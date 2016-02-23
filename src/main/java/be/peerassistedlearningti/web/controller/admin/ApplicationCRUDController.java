package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Set;

@Controller
public class ApplicationCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    @RequestMapping( value = "/applications", method = RequestMethod.GET )
    public ModelAndView getApplicationOverviewPage( ModelMap model )
    {
        model.addAttribute( "pendingApplications", service.getAllPendingApplications() );
        model.addAttribute( "doneApplications", service.getAllDoneApplications() );
        return new ModelAndView( "admin/applications", model );
    }

    @RequestMapping( value = "/applications/approve/{id}", method = RequestMethod.POST )
    public String approveApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );

        application.approve();
        service.updateApplication( application );

        Tutor tutor = application.getStudent()
                .getTutor();

        if ( tutor == null )
        {
            Set<Course> courses = new HashSet<Course>();
            courses.add( application.getCourse() );
            service.addTutor( new Tutor( application.getStudent(), courses ) );
        } else
        {
            tutor.addCourse( application.getCourse() );
            service.updateTutor( tutor );
        }

        return "redirect:/admin/applications";
    }

    @RequestMapping( value = "/applications/reject/{id}", method = RequestMethod.POST )
    public String rejectApplication( @PathVariable( value = "id" ) int id )
    {
        Application application = service.getApplicationById( id );

        application.reject();
        service.updateApplication( application );

        return "redirect:/admin/applications";
    }

    @RequestMapping( value = "/applications/screenshot/{id}.png", method = RequestMethod.GET )
    @ResponseBody
    public void getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        try
        {
            InputStream is = new ByteArrayInputStream( service.getApplicationById( id )
                    .getScreenshot() );
            IOUtils.copy( is, response.getOutputStream() );
            response.flushBuffer();
        } catch ( Exception e ) { }
    }
}