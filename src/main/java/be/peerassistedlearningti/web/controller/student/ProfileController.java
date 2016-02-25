package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.Timeline;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;

@Controller
@RequestMapping( value = "/profile" )
public class ProfileController extends StudentController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model, Student student )
    {
        Tutor tutor = student.getTutor();

        if ( model.get( "profile" ) == null )
        {
            ProfileForm profile = new ProfileForm();
            profile.setName( student.getName() );
            profile.setEmail( student.getEmail() );
            profile.setSubscriptions( student.getSubscriptions() );
            model.addAttribute( "profile", profile );
        }
        if ( model.get( "user" ) == null )
        {
            model.addAttribute( "user", student );
        }
        if ( tutor != null && model.get( "reviews" ) == null )
        {
            model.addAttribute( "reviews", service.getReviews( tutor ) );
        }
        if ( model.get( "timeline" ) == null )
        {
            Timeline timeline = new Timeline();
            timeline.addAll( service.getPastLessons( student ) );
            timeline.addAll( service.getReviewsForStudent( student ) );
            model.addAttribute( "timeline", timeline );
        }
        if ( model.get( "courses" ) == null )
        {
            model.addAttribute( "courses", service.getAllCourses() );
        }
        return model;
    }

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView getProfile( ModelMap model )
    {
        return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );
    }

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getOtherProfile( @PathVariable( "id" ) int id, ModelMap model )
    {
        Student student = service.getStudentById( id );

        if ( student == null )
            return new ModelAndView( "redirect:/profile" );

        return new ModelAndView( "student/profile", fillModel( model, student ) );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView modifyStudentProfile( @Valid @ModelAttribute( "profile" ) ProfileForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "student/profile", fillModel( model, SessionAuth.getStudent() ) );

        Student student = SessionAuth.getStudent();

        student.setName( StringUtils.defaultIfEmpty( form.getName(), student.getName() ) );
        student.setEmail( StringUtils.defaultIfEmpty( form.getEmail(), student.getEmail() ) );

        if ( !form.getNewPassword()
                .isEmpty() )
        {
            student.setPassword( form.getNewPassword() );
        }

        if ( !form.getAvatar()
                .isEmpty() )
        {
            try
            {
                MultipartFile avatar = form.getAvatar();
                student.setAvatar( avatar.getBytes() );
            } catch ( Exception e )
            {
                result.reject( "SaveFile.ProfileForm.avatar" );
                return new ModelAndView( "student/profile", fillModel( model, student ) );
            }
        }

        student.setSubscriptions( form.getSubscriptions() );

        service.updateStudent( student );
        SessionAuth.setStudent( student );

        return new ModelAndView( "redirect:/profile" );
    }

    @ResponseBody
    @RequestMapping( value = "/{id}/avatar.png", method = RequestMethod.GET )
    public void getScreenshot( @PathVariable( "id" ) int id, HttpServletRequest request, HttpServletResponse response )
    {
        InputStream in = null;
        try
        {
            Student student = service.getStudentById( id );
            byte[] img = student.getAvatar();

            if ( img == null )
            {
                String path = request.getSession()
                        .getServletContext()
                        .getRealPath( "/resources/img" ) + "/default_profile.jpg";
                in = new FileSystemResource( new File( path ) ).getInputStream();
            } else
            {
                in = new ByteArrayInputStream( img );
            }
            response.setContentType( "image/jpeg" );
            IOUtils.copy( in, response.getOutputStream() );
        } catch ( Exception e ) { System.out.println( e.getMessage() );} finally
        {
            if ( in != null )
                IOUtils.closeQuietly( in );
        }
    }

}
