package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;

@Controller
@RequestMapping( "/resources" )
public class ResourceController
{

    @Autowired
    private PALService service;

    @ResponseBody
    @RequestMapping( value = "/students/{id}/avatar.png", method = RequestMethod.GET )
    public void getAvatar( @PathVariable( "id" ) int id, HttpServletRequest request, HttpServletResponse response )
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

    @ResponseBody
    @RequestMapping( value = "/applications/{id}/screenshot.png", method = RequestMethod.GET )
    public void getScreenshot( @PathVariable( value = "id" ) int id, HttpServletResponse response )
    {
        InputStream in = null;
        try
        {
            Application app = service.getApplicationById( id );
            byte[] img = app.getScreenshot();

            in = new ByteArrayInputStream( img );
            response.setContentType( "image/jpeg" );
            IOUtils.copy( in, response.getOutputStream() );
        } catch ( Exception e ) {} finally
        {
            if ( in != null )
                IOUtils.closeQuietly( in );
        }
    }

}
