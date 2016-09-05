package be.peerassistedlearning.web.controller.admin;

import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.util.MailSender;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LessonCRUDController extends AdminController{
    @Autowired
    MailSender mailSender;

    @Autowired
    private PALService service;

    @RequestMapping( value = "/lessons", method = RequestMethod.DELETE )
    public String removeLesson( @RequestParam( value = "id" ) int id, RedirectAttributes redirectAttributes ){
        Lesson l = service.getLessonById( id );
        service.removeLesson( l );
        notifyBookings( l );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.LessonCRUDController.Remove", new Object[]{l.getName()} ) );
        return "redirect:/admin/lessons";
    }

    private void notifyBookings( Lesson lesson ){
        for( Student booking : lesson.getBookings() )
            mailSender.sendLessonCanceledMail( booking, lesson );
    }

    @RequestMapping( value = "lessons", method = RequestMethod.GET )
    public ModelAndView getLessonOverviewPage(){
        return new ModelAndView( "admin/lessons", "lessons", service.getAllLessons() );
    }
}
