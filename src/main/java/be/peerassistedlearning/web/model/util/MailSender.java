package be.peerassistedlearning.web.model.util;


import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Class used to send a mail to a given student.
 */
public class MailSender{
    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private VelocityEngine velocityEngine;

    public MailSender(){
    }

    /**
     * Sends a reset password mail to the specified student
     *
     * @param student The student to send the mail to
     * @param token   The reset password token
     */
    @Async
    public void sendResetMail( final Student student, final String token ){
        try{
            MimeMessagePreparator preparator = mimeMessage -> {
                MimeMessageHelper messageHelper = new MimeMessageHelper( mimeMessage );
                messageHelper.setTo( student.getEmail() );
                messageHelper.setSubject( "PAL-TI password reset" );
                Map<String, Object> model = new HashMap<String, Object>();
                model.put( "student", student );
                model.put( "resetLink", "https://pal.studentenraad.ucll.be/auth/reset/validate/" + student.getEmail() + "/" + token );
                String text = VelocityEngineUtils.mergeTemplateIntoString( velocityEngine, "mail/reset_mail.vm", "UTF-8", model );
                messageHelper.setText( text, true );
            };
            mailSender.send( preparator );
        }catch( Exception e ){
        }
    }

    /**
     * Sends a notification mail to the specified student
     *
     * @param student The student to send the mail to
     * @param lesson  The lesson of the notification
     */
    @Async
    public void sendNotificationMail( final Student student, final Lesson lesson ){
        try{
            MimeMessagePreparator preparator = mimeMessage -> {
                MimeMessageHelper messageHelper = new MimeMessageHelper( mimeMessage );
                messageHelper.setTo( student.getEmail() );
                messageHelper.setSubject( "PAL-TI notification for " + lesson.getCourse().getShortName() );
                Map<String, Object> model = new HashMap<String, Object>();
                model.put( "student", student );
                model.put( "lesson", lesson );
                String text = VelocityEngineUtils.mergeTemplateIntoString( velocityEngine, "mail/subscription_mail.vm", "UTF-8", model );
                messageHelper.setText( text, true );
            };
            mailSender.send( preparator );
        }catch( Exception e ){
        }
    }

    /**
     * Sends a lesson canceled mail to the specified student
     *
     * @param student The student to send the mail to
     * @param lesson  The lesson that is removed
     */
    @Async
    public void sendLessonCanceledMail( final Student student, final Lesson lesson ){
        try{
            MimeMessagePreparator preparator = mimeMessage -> {
                MimeMessageHelper messageHelper = new MimeMessageHelper( mimeMessage );
                messageHelper.setTo( student.getEmail() );
                messageHelper.setSubject( "PAL-TI lesson was canceled" );
                Map<String, Object> model = new HashMap<String, Object>();
                model.put( "student", student );
                model.put( "lesson", lesson );
                String text = VelocityEngineUtils.mergeTemplateIntoString( velocityEngine, "mail/lesson_canceled_mail.vm", "UTF-8", model );
                messageHelper.setText( text, true );
            };
            mailSender.send( preparator );
        }catch( Exception e ){
        }
    }
}
