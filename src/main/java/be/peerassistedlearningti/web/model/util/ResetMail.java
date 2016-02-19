package be.peerassistedlearningti.web.model.util;


import be.peerassistedlearningti.model.Student;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.ui.velocity.VelocityEngineUtils;

import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;

/**
 * Class used to send a reset password mail to a given student.
 */
public class ResetMail
{

    private static final String SENDER_EMAIL = "noreply@pal-ti.be";

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private VelocityEngine velocityEngine;

    public ResetMail() {}

    public void sendResetMail( final Student student, final String token )
    {
        MimeMessagePreparator preparator = new MimeMessagePreparator()
        {
            public void prepare( MimeMessage mimeMessage ) throws Exception
            {
                MimeMessageHelper messageHelper = new MimeMessageHelper( mimeMessage );
                messageHelper.setTo( student.getEmail() );
                messageHelper.setFrom( SENDER_EMAIL );
                messageHelper.setSubject( "PAL-TI password reset" );
                Map<String, Object> model = new HashMap<String, Object>();
                model.put( "student", student );
                model.put( "resetLink", "http://localhost:8080/auth/reset/validate/" + student.getEmail() + "/" + token + "/" );
                String text = VelocityEngineUtils.mergeTemplateIntoString( velocityEngine, "mail/reset_mail.vm", "UTF-8", model );
                messageHelper.setText( text, true );
            }
        };
        mailSender.send( preparator );
    }
}
