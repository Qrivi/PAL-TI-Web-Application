package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.CourseForm;
import be.peerassistedlearningti.web.model.form.CourseUpdateForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
public class CourseCRUDController extends AdminController
{

    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        if ( model.get( "course" ) == null )
            model.addAttribute( "course", new CourseForm() );
        if ( model.get( "updateCourse" ) == null )
            model.addAttribute( "updateCourse", new CourseUpdateForm() );
        if ( model.get( "courses" ) == null )
            model.addAttribute( "courses", service.getAllCourses() );
        return model;
    }

    @RequestMapping( value = "/courses", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/courses", fillModel( model ) );
    }

    @RequestMapping( value = "/course", method = RequestMethod.POST )
    public ModelAndView addCourse( @Valid @ModelAttribute( "course" ) CourseForm courseForm, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        service.addCourse( new Course( courseForm.getCode(), courseForm.getName(), courseForm.getShortName(), courseForm.getCurriculum(), courseForm.getYear() ) );

        return new ModelAndView( "redirect:/admin/courses" );
    }

    @RequestMapping( value = "/courses/update", method = RequestMethod.POST )
    public ModelAndView updateCourse( @Valid @ModelAttribute( "updateCourse" ) CourseUpdateForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        Integer id = form.getId();

        if ( id == null )
            return new ModelAndView( "redirect:admin/courses", fillModel( model ) );

        Course c = service.getCourseById( id );

        if ( c == null )
            return new ModelAndView( "redirect:admin/courses", fillModel( model ) );

        String code = form.getCode();
        String name = form.getName();
        String shortName = form.getShortName();
        String curriculum = form.getCurriculum();
        int year = form.getYear();

        if ( code != null && !code.isEmpty() )
            c.setCode( code );
        if ( name != null && !name.isEmpty() )
            c.setName( name );
        if ( shortName != null && !shortName.isEmpty() )
            c.setShortName( shortName );
        if ( curriculum != null && !curriculum.isEmpty() )
            c.setCurriculum( curriculum );

        c.setYear( year );

        service.updateCourse( c );
        return new ModelAndView( "redirect:/admin/courses", fillModel( model ) );
    }

    @RequestMapping( value = "/courses/remove/{id}", method = RequestMethod.POST )
    public String removeCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        service.removeCourse( c );
        return "redirect:/admin/course/overview";
    }

}
