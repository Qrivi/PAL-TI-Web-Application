package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.TutorApplyForm;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

@Controller
@RequestMapping( value = "/apply" )
public class ApplyController
{

    @Autowired
    private PALService service;

    private static String CATALINA_HOME = System.getProperty( "catalina.home" );
    private static String UPLOAD_PATH = CATALINA_HOME + File.separator + "applications";

    @RequestMapping( method = RequestMethod.GET )
    public ModelAndView applyTutor( ModelMap model )
    {
        model.addAttribute( "tutorApply", new TutorApplyForm() );
        model.addAttribute( "courses", service.getAllCourses() );
        return new ModelAndView( "tutor_apply", model );
    }

    @RequestMapping( method = RequestMethod.POST )
    public ModelAndView applyTutor( @Valid @ModelAttribute( "tutorApply" ) TutorApplyForm form, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "tutor_apply" );

        Student david = new Student( "David", "123", "davidopdebeeck@hotmail.com", true );

        service.addStudent( david );

        String path = saveFile( form.getScreenshot() );

        service.addApplication( new Application( david, form.getCourse(), path ) );

        return new ModelAndView( "tutor_apply" );
    }

    private String saveFile( MultipartFile file )
    {
        if ( !file.isEmpty() )
        {
            try
            {
                String name = file.getOriginalFilename();
                String path = UPLOAD_PATH + File.separator + name;
                String extension = FilenameUtils.getExtension( name );

                // TODO check valid extensions

                byte[] multiPartFileBytes = file.getBytes();
                File saveDir = new File( UPLOAD_PATH );

                if ( !saveDir.exists() )
                    saveDir.mkdirs();

                File saveFile = new File( saveDir + File.separator + file.getOriginalFilename() );
                BufferedOutputStream stream = new BufferedOutputStream( new FileOutputStream( saveFile ) );
                stream.write( multiPartFileBytes );
                stream.close();

                return path;
            } catch ( Exception e ) { e.printStackTrace(); }

            return null;
        }
        return null;
    }

}
