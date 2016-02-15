package be.peerassistedlearningti.web.controller.auth;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.StudentForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@PreAuthorize( "hasRole('ROLE_ANONYMOUS')" )
@RequestMapping( value = "/auth" )
public class AuthController
{

    @Autowired
    private PALService service;

    @RequestMapping( value = "/login", method = RequestMethod.GET )
    public ModelAndView getLoginPage( @RequestParam( value = "error", required = false ) boolean error, ModelMap model )
    {
        if ( error )
            model.addAttribute( "error", true );
        return new ModelAndView( "auth/login", model );
    }

    @RequestMapping( value = "/register", method = RequestMethod.GET )
    public ModelAndView registerStudent( ModelMap model )
    {
        model.addAttribute( "student", new StudentForm() );
        return new ModelAndView( "auth/register", model );
    }

    @RequestMapping( value = "/register", method = RequestMethod.POST )
    public ModelAndView registerStudent( @Valid @ModelAttribute( "student" ) StudentForm form, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "auth/register" );

        String email = form.getEmail()
                .toLowerCase();

        if ( service.getStudentByEmail( email ) != null )
        {
            result.reject( "EmailInUse.StudentForm.email" );
            return new ModelAndView( "auth/register" );
        }

        service.addStudent( new Student( form.getName(), form.getPassword(), form.getEmail()
                .toLowerCase(), UserType.NORMAL ) );

        return new ModelAndView( "redirect:/auth/login" );
    }

}
