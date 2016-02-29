package be.peerassistedlearningti.web.controller.auth;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RegisterForm;
import be.peerassistedlearningti.web.model.form.ResetForm;
import be.peerassistedlearningti.web.model.form.ResetRequestForm;
import be.peerassistedlearningti.web.model.util.MailSender;
import be.peerassistedlearningti.web.model.util.message.MessageFactory;
import be.peerassistedlearningti.web.model.util.StudentUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Date;

@Controller
@RequestMapping( value = "/auth" )
public class AuthController
{

    @Autowired
    MailSender mailSender;

    @Autowired
    PALService service;

    //================================================================================
    // region Login
    //================================================================================

    @RequestMapping( value = "/login", method = RequestMethod.GET )
    public ModelAndView getLoginPage( @RequestParam( value = "error", required = false ) boolean error, @RequestParam( value = "different_user", required = false ) boolean differentUser, @CookieValue( value = "remember", required = false ) String remember, @CookieValue( value = "email", required = false ) String email, ModelMap model )
    {
        if ( error )
            model.addAttribute( "error", true );
        if ( !differentUser && remember != null && Boolean.valueOf( remember ) )
        {
            if ( email != null )
            {
                Student current = service.getStudentByEmail( email );
                if ( current != null )
                {
                    model.addAttribute( "user", current );
                    return new ModelAndView( "auth/lockscreen", model );
                }
            }
        }
        return new ModelAndView( "auth/login", model );
    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Register
    //================================================================================

    @RequestMapping( value = "/register", method = RequestMethod.GET )
    public ModelAndView registerStudent( ModelMap model )
    {
        return new ModelAndView( "auth/register", "register", new RegisterForm() );
    }

    @RequestMapping( value = "/register", method = RequestMethod.POST )
    public ModelAndView registerStudent( @Valid @ModelAttribute( "register" ) RegisterForm form, BindingResult result, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "auth/register" );

        service.addStudent( new Student( form.getName(), form.getPassword(), form.getEmail()
                .toLowerCase(), StudentUtils.createProfileIdentifier( form.getName() ), UserType.NORMAL ) );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.Register" ) );

        return new ModelAndView( "redirect:/auth/login" );
    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Reset
    //================================================================================

    @RequestMapping( value = "/reset", method = RequestMethod.GET )
    public ModelAndView resetPassword()
    {
        return new ModelAndView( "auth/reset", "resetRequest", new ResetRequestForm() );
    }

    @RequestMapping( value = "/reset", method = RequestMethod.POST )
    public ModelAndView resetPassword( @Valid @ModelAttribute( "resetRequest" ) ResetRequestForm form, BindingResult result, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "auth/reset" );

        Student student = service.getStudentByEmail( form.getEmail() );

        // max 1 reset request an hour
        if ( student.getResetTokenExpiration() != null && student.getResetTokenExpiration()
                .getTime() - new Date().getTime() > 0 )
        {
            return new ModelAndView( "auth/reset", "message", MessageFactory.createDangerMessage( "ReqLimit.AuthController.Token" ) );
        } else
        {
            mailSender.sendResetMail( student, student.issuePasswordReset() );
            service.updateStudent( student );
            redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.Mail" ) );
            return new ModelAndView( "redirect:/auth/login" );
        }
    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Validate
    //================================================================================

    @RequestMapping( value = "/reset/validate/{email}/{token}", method = RequestMethod.GET )
    public ModelAndView resetPasswordValidation( @PathVariable( value = "email" ) String email, @PathVariable( value = "token" ) String token )
    {
        return new ModelAndView( "auth/reset_validation", "reset", new ResetForm() );
    }

    @RequestMapping( value = "/reset/validate/{email}/{token}", method = RequestMethod.POST )
    public ModelAndView resetPasswordValidation( @PathVariable( value = "email" ) String email, @PathVariable( value = "token" ) String token, @Valid @ModelAttribute( "reset" ) ResetForm form, BindingResult result, RedirectAttributes redirectAttributes )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "auth/reset_validation", "reset", form );

        Student student = service.getStudentByEmail( email );

        if ( student.validatePasswordReset( token ) )
        {
            student.setPassword( form.getPassword() );
            service.updateStudent( student );

            redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.PasswordReset" ) );
            return new ModelAndView( "redirect:/auth/login" );
        } else
        {
            ModelMap map = new ModelMap();
            map.addAttribute( "reset", form );
            map.addAttribute( "message", MessageFactory.createDangerMessage( "Invalid.AuthController.Token" ) );
            return new ModelAndView( "auth/reset_validation", map );
        }
    }

    //================================================================================
    // endregion
    //================================================================================

}
