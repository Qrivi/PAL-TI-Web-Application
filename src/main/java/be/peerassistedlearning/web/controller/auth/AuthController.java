package be.peerassistedlearning.web.controller.auth;

import be.krivi.detour.core.KUAccount;
import be.krivi.detour.core.KUSubscription;
import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.model.UserType;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.util.MailSender;
import be.peerassistedlearning.web.model.util.StudentUtils;
import be.peerassistedlearning.web.model.util.detour.Authenticator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping( value = "/auth" )
public class AuthController{

    @Autowired
    MailSender mailSender;

    @Autowired
    PALService service;

    //================================================================================
    // region Login
    //================================================================================

    @RequestMapping( value = "/login", method = RequestMethod.GET )
    public ModelAndView loginStudent(
            @RequestParam( value = "error", required = false ) String error,
            @RequestParam( value = "id", required = false ) String studentId,
            @RequestParam( value = "different_user", required = false ) boolean differentUser,
            @CookieValue( value = "remember", required = false ) String remember,
            ModelMap model ){
        if( !"".equals( error ) )
            model.addAttribute( "error", error );

        if( !differentUser && !"".equals( remember ) ){
                Student current = service.getStudentByProfileIdentifier( remember );
                if( current != null ){
                    model.addAttribute( "user", current );
                    return new ModelAndView( "auth/lockscreen", model );
                }
        }

        model.addAttribute( "studentId", studentId );

        return new ModelAndView( "auth/login", model );
    }

    @RequestMapping( value = "/login", method = RequestMethod.POST )
    public ModelAndView registerStudent( @RequestParam( "studentId" ) String studentId, @RequestParam( "password" ) String password, ModelMap model ){

        KUAccount a = Authenticator.auth( studentId, password );

        if( a == null )
            return new ModelAndView( "redirect:/auth/login?error=invalid&id=" + studentId );

        Student s = service.getStudentByEmail( a.getEmail() );

        if( s == null ){
            String programme = "None";

            for( KUSubscription sub : a.getSubscriptions() ){
                if( "Valid".equals( sub.getStatus() ) ){
                    programme = sub.getProgramme();
                    break;
                }
            }

            Curriculum c = service.getCurriculumFromProgramme( programme );

            if( c == null )
                return new ModelAndView( "redirect:/auth/login?error=unsupported&id=" + studentId );

            s = new Student(
                    a.getFirstName() + " " + a.getLastName(),
                    password,
                    a.getEmail(),
                    c,
                    StudentUtils.createProfileIdentifier( a.getUsername() ), UserType.ADMIN ); //TODO UserType.Normal
            service.addStudent( s );
        }else{
            if( !s.isPasswordValid( password ) )
                s.setPassword( password );
        }

        model.addAttribute( "email", a.getEmail() );
        model.addAttribute( "password", password );

        return new ModelAndView( "auth/logincheck", model );
    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Register
    //================================================================================

    //    @RequestMapping( value = "/register", method = RequestMethod.GET )
    //    public ModelAndView registerStudent( ModelMap model )
    //    {
    //        model.addAttribute( "curriculums", service.getCurriculums() );
    //        model.addAttribute( "register", new RegisterForm() );
    //        return new ModelAndView( "auth/register", model );
    //    }

    //    @RequestMapping( value = "/register", method = RequestMethod.POST )
    //    public ModelAndView registerStudent( @Valid @ModelAttribute( "register" ) RegisterForm form, BindingResult result, RedirectAttributes redirectAttributes )
    //    {
    //        if ( result.hasErrors() )
    //            return new ModelAndView( "auth/register" );
    //
    //        Student s = new Student( form.getName(), form.getPassword(), form.getEmail().toLowerCase(), form.getCurriculum(), StudentUtils.createProfileIdentifier( form.getName() ), UserType.NORMAL );
    //        service.addStudent( s );
    //
    //        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.Register" ) );
    //
    //        return new ModelAndView( "redirect:/auth/login" );
    //    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Reset
    //================================================================================

    //    @RequestMapping( value = "/reset", method = RequestMethod.GET )
    //    public ModelAndView resetPassword()
    //    {
    //        return new ModelAndView( "auth/reset", "resetRequest", new ResetRequestForm() );
    //    }

    //    @RequestMapping( value = "/reset", method = RequestMethod.POST )
    //    public ModelAndView resetPassword( @Valid @ModelAttribute( "resetRequest" ) ResetRequestForm form, BindingResult result, RedirectAttributes redirectAttributes )
    //    {
    //        if ( result.hasErrors() )
    //            return new ModelAndView( "auth/reset" );
    //
    //        Student student = service.getStudentByEmail( form.getEmail() );
    //
    //        // max 1 reset request an hour
    //        if ( student.getResetTokenExpiration() != null && student.getResetTokenExpiration().getTime() - new Date().getTime() > 0 )
    //        {
    //            return new ModelAndView( "auth/reset", "message", MessageFactory.createDangerMessage( "ReqLimit.AuthController.Token" ) );
    //        } else
    //        {
    //            mailSender.sendResetMail( student, student.issuePasswordReset() );
    //            service.updateStudent( student );
    //            redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.Mail" ) );
    //            return new ModelAndView( "redirect:/auth/login" );
    //        }
    //    }

    //================================================================================
    // endregion
    //================================================================================

    //================================================================================
    // region Validate
    //================================================================================

    //    @RequestMapping( value = "/reset/validate/{email}/{token}", method = RequestMethod.GET )
    //    public ModelAndView resetPasswordValidation( @PathVariable( value = "email" ) String email, @PathVariable( value = "token" ) String token )
    //    {
    //        return new ModelAndView( "auth/reset_validation", "reset", new ResetForm() );
    //    }

    //    @RequestMapping( value = "/reset/validate/{email}/{token}", method = RequestMethod.POST )
    //    public ModelAndView resetPasswordValidation( @PathVariable( value = "email" ) String email, @PathVariable( value = "token" ) String token, @Valid @ModelAttribute( "reset" ) ResetForm form, BindingResult result, RedirectAttributes redirectAttributes )
    //    {
    //        if ( result.hasErrors() )
    //            return new ModelAndView( "auth/reset_validation", "reset", form );
    //
    //        Student student = service.getStudentByEmail( email );
    //
    //        if ( student.validatePasswordReset( token ) )
    //        {
    //            student.setPassword( form.getPassword() );
    //            service.updateStudent( student );
    //
    //            redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.AuthController.PasswordReset" ) );
    //            return new ModelAndView( "redirect:/auth/login" );
    //        } else
    //        {
    //            ModelMap map = new ModelMap();
    //            map.addAttribute( "reset", form );
    //            map.addAttribute( "message", MessageFactory.createDangerMessage( "Invalid.AuthController.Token" ) );
    //            return new ModelAndView( "auth/reset_validation", map );
    //        }
    //    }

    //================================================================================
    // endregion
    //================================================================================

}
