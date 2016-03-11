package be.peerassistedlearning.web.controller.student;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.model.Request;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.form.RequestForm;
import be.peerassistedlearning.web.model.util.RequestSimilarityWrapper;
import be.peerassistedlearning.web.model.util.SessionAuth;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping( value = "/request" )
public class RequestController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        if ( model.get( "request" ) == null )
            model.addAttribute( "request", new RequestForm() );
        if ( model.get( "courses" ) == null )
            model.addAttribute( "courses", service.getCourses( SessionAuth.getStudent() ) );
        if ( model.get( "requests" ) == null )
            model.addAttribute("requests", service.getAllRequestsWithoutLesson());
        return model;
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getRequestPage( ModelMap model )
    {
        return new ModelAndView( "student/request_add", fillModel( model ) );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getRequestInfo( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        Request request = service.getRequestById( id );
        if ( request == null )
            return new ModelAndView( "redirect:/request", fillModel( model ) );
        model.addAttribute( "requested", request );
        return new ModelAndView( "student/request_info", fillModel( model ) );
    }


    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addRequest( @Valid @ModelAttribute( value = "request" ) RequestForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/request_add", fillModel( model ) );

        Request request = new Request( form.getTitle(), form.getDescription(), form.getCourse(), SessionAuth.getStudent() );
        request.upvote( SessionAuth.getStudent() );
        service.addRequest( request );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.RequestController.Add", new Object[]{ form.getTitle() } ) );
        return new ModelAndView( "redirect:/request" );
    }

    @RequestMapping( value = "/upvote/{id}", method = RequestMethod.POST )
    public ModelAndView upvote( @PathVariable( value = "id" ) int id, ModelMap model, RedirectAttributes redirectAttributes )
    {
        Request request = service.getRequestById( id );

        if ( request == null )
            return new ModelAndView( "redirect:/request", fillModel( model ) );

        request.upvote( SessionAuth.getStudent() );
        service.updateRequest( request );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.RequestController.Upvote", new Object[]{ request.getTitle() } ) );
        return new ModelAndView( "redirect:/request" );

    }

    @RequestMapping( value = "/undovote/{id}", method = RequestMethod.POST )
    public ModelAndView undoVote( @PathVariable( value = "id" ) int id, ModelMap model, RedirectAttributes redirectAttributes )
    {
        Request request = service.getRequestById( id );

        if ( request == null )
            return new ModelAndView( "redirect:/request", fillModel( model ) );

        request.removeUpvote( SessionAuth.getStudent() );
        service.updateRequest( request );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.RequestController.Undoupvote", new Object[]{ request.getTitle() } ) );
        return new ModelAndView( "redirect:/request" );
    }

    @RequestMapping( value = "/similar", method = RequestMethod.POST )
    public ModelAndView getSimilar( HttpServletRequest req )
    {
        String title = req.getParameter( "title" );
        String courseId = req.getParameter( "course" );
        Course course = service.getCourseById( Integer.parseInt( courseId ) );

        if ( title == null || course == null )
        {
            return new ModelAndView( "student/fragment/similar_requests" );
        }

        Request newRequest = new Request();
        newRequest.setCourse( course );
        newRequest.setTitle( title );

        List<RequestSimilarityWrapper> similar = new LinkedList<>();
        for ( Request request : service.getRequests( newRequest.getCourse() ) )
        {
            double similarity = request.getSimilarity( newRequest );
            System.out.println( "similarity=" + similarity );
            if ( similarity >= 0.6 )
                similar.add( new RequestSimilarityWrapper( similarity, request ) );
        }
        Collections.sort( similar );
        return new ModelAndView( "student/fragment/similar_requests", "similar", similar );
    }

}
