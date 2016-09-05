package be.peerassistedlearning.web.controller.student;

import be.peerassistedlearning.model.Application;
import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.form.TutorApplyForm;
import be.peerassistedlearning.web.model.util.SessionAuth;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Collection;
import java.util.LinkedList;
import java.util.stream.Collectors;

@Controller
public class ApplyController extends StudentController{

    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model ){
        Student current = SessionAuth.getStudent();
        if( model.get( "tutorApply" ) == null )
            model.addAttribute( "tutorApply", new TutorApplyForm() );
        if( model.get( "topSubscribedCourses" ) == null )
            model.addAttribute( "topSubscribedCourses", service.getTopSubscribedCourses( 10 ) );
        if( model.get( "lastApplications" ) == null )
            model.addAttribute( "lastApplications", service.getLastApplications( current, 10 ) );
        if( model.get( "courses" ) == null ){
            Collection<Course> courses = service.getAllCourses();
            Collection<Application> applications = new LinkedList<>();

            applications.addAll( service.getPendingApplications( current ) );
            applications.addAll( service.getApprovedApplications( current ) );

            courses.removeAll( applications.stream().map( Application::getCourse ).collect( Collectors.toList() ) );

            model.addAttribute( "courses", courses );
        }
        return model;
    }

    @RequestMapping( value = "/apply", method = RequestMethod.GET )
    public ModelAndView applyTutor( ModelMap model ){
        return new ModelAndView( "student/apply", fillModel( model ) );
    }

    @RequestMapping( value = "/apply", method = RequestMethod.POST )
    public ModelAndView applyTutor( @Valid @ModelAttribute( "tutorApply" ) TutorApplyForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes ){
        if( result.hasErrors() )
            return new ModelAndView( "student/apply", fillModel( model ) );

        try{
            MultipartFile screenshot = form.getScreenshot();
            service.addApplication( new Application( SessionAuth.getStudent(), form.getCourse(), screenshot.getBytes() ) );
        }catch( Exception e ){
            result.reject( "SaveFile.TutorApplyForm.screenshot" );
            return new ModelAndView( "student/apply", fillModel( model ) );
        }

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ApplyController.Apply", new Object[]{form.getCourse().getName()} ) );

        return new ModelAndView( "redirect:/apply" );
    }

}
