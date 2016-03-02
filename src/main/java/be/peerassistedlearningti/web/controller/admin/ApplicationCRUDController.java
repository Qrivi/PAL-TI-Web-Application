package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public ModelAndView approveApplication( @PathVariable( value = "id" ) int id, RedirectAttributes redirectAttributes )
    {
        Application application = service.getApplicationById( id );

        application.approve();
        service.updateApplication( application );

        Tutor tutor = service.getTutorByStudent( application.getStudent() );

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

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ApplicationCRUDController.Approved", new Object[]{ application.getId() } ) );

        return new ModelAndView( "redirect:/admin/applications" );
    }

    @RequestMapping( value = "/applications/reject/{id}", method = RequestMethod.POST )
    public ModelAndView rejectApplication( @PathVariable( value = "id" ) int id, RedirectAttributes redirectAttributes )
    {
        Application application = service.getApplicationById( id );

        application.reject();
        service.updateApplication( application );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ApplicationCRUDController.Rejected", new Object[]{ application.getId() } ) );

        return new ModelAndView( "redirect:/admin/applications" );
    }
}