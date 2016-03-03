package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Image;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.StudentUtils;
import be.peerassistedlearningti.web.model.util.Timeline;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.validation.Valid;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Date;

@Controller
@RequestMapping( value = "/profile/{identifier:.+}" )
public class ExternalProfileController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model, Student student )
    {
        if ( student.equals( SessionAuth.getStudent() ) )
            model = fillModel2( model, student );
        if ( model.get( "user" ) == null )
            model.addAttribute( "user", student );
        if ( model.get( "pastBookings" ) == null )
            model.addAttribute( "pastBookings", service.getPastBookings( student ).size() );
        if ( model.get( "upcomingBookings" ) == null )
            model.addAttribute( "upcomingBookings", service.getUpcomingBookings( student ).size() );
        return model;
    }

    private ModelMap fillModel2( ModelMap model, Student student )
    {
        if ( model.get( "profile" ) == null )
        {
            ProfileForm profile = new ProfileForm();
            profile.setName( student.getName() );
            profile.setEmail( student.getEmail() );
            profile.setSubscriptions( student.getSubscriptions() );
            model.addAttribute( "profile", profile );
        }
        if ( model.get( "courses" ) == null )
            model.addAttribute( "courses", service.getAllCourses() );
        return model;
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getProfile( @PathVariable( "identifier" ) String id, ModelMap model )
    {
        Student student = service.getStudentByProfileIdentifier( id );

        if ( student == null )
            return new ModelAndView( "redirect:/profile" );

        return new ModelAndView( "student/profile", fillModel( model, student ) );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @PathVariable( "identifier" ) String id, @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );

        Student student = SessionAuth.getStudent();
        Student s = service.getStudentByProfileIdentifier( id );

        if ( !s.equals( student ) )
            return new ModelAndView( "redirect:/profile" );

        if ( !form.getName().equals( student.getName() ) )
            student.setProfileIdentifier( StudentUtils.createProfileIdentifier( form.getName() ) );

        student.setName( StringUtils.defaultIfEmpty( form.getName(), student.getName() ) );
        student.setEmail( StringUtils.defaultIfEmpty( form.getEmail().toLowerCase(), student.getEmail() ) );

        if ( !form.getNewPassword().isEmpty() )
            student.setPassword( form.getNewPassword() );

        if ( !form.getAvatar().isEmpty() )
        {
            try
            {
                MultipartFile avatar = form.getAvatar();

                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                ByteArrayInputStream bis = new ByteArrayInputStream( avatar.getBytes() );
                BufferedImage bufferedImage = ImageIO.read( bis );

                BufferedImage scaled = Thumbnails.of( bufferedImage ).forceSize( 180, 180 ).outputFormat( "png" ).outputQuality( 1 ).asBufferedImage();

                ImageIO.write( scaled, "png", bos );
                byte[] imageBytes = bos.toByteArray();

                student.setAvatar( new Image( imageBytes, new Date() ) );
            } catch ( Exception e )
            {
                result.reject( "SaveFile.ProfileForm.avatar" );
                return new ModelAndView( "student/profile", fillModel( model, student ) );
            }
        }

        student.setSubscriptions( form.getSubscriptions() );
        student.setLastUpdated( new Date() );

        service.updateStudent( student );
        SessionAuth.setStudent( student );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.ExternalProfileController.Update" ) );

        return new ModelAndView( "redirect:/profile/" + student.getProfileIdentifier() );
    }

    @RequestMapping( value = "/timeline", method = RequestMethod.GET )
    public ModelAndView getTimeline( @PathVariable( "identifier" ) String id, @RequestParam( value = "offset", required = true ) int offset, @RequestParam( value = "limit", required = true ) int limit, ModelMap model )
    {
        Student current = service.getStudentByProfileIdentifier( id );

        Timeline timeline = new Timeline();

        timeline.addAll( service.getPastBookings( current, offset, limit ) );
        timeline.addAll( service.getReviews( current, offset, limit ) );

        if ( current.getTutor() != null )
        {
            timeline.addAll( service.getPastLessons( current.getTutor(), offset, limit ) );
            timeline.addAll( service.getReviews( current.getTutor(), offset, limit ) );
        }

        timeline.limit( limit );

        model.addAttribute( "timeline", timeline );
        model.addAttribute( "student", current );

        return new ModelAndView( "student/fragment/timeline", model );
    }

}
