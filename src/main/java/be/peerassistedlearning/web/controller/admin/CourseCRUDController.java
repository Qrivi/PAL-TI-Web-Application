package be.peerassistedlearning.web.controller.admin;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.service.PALService;
import be.peerassistedlearning.web.model.form.CourseForm;
import be.peerassistedlearning.web.model.form.CourseUpdateForm;
import be.peerassistedlearning.web.model.util.message.MessageFactory;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
public class CourseCRUDController extends AdminController{

    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model ){
        if( model.get( "course" ) == null )
            model.addAttribute( "course", new CourseForm() );
        if( model.get( "updateCourse" ) == null )
            model.addAttribute( "updateCourse", new CourseUpdateForm() );
        if( model.get( "courses" ) == null )
            model.addAttribute( "courses", service.getAllCourses() );
        return model;
    }

    @RequestMapping( value = "/courses", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage( ModelMap model ){
        return new ModelAndView( "admin/courses", fillModel( model ) );
    }

    @RequestMapping( value = "/courses", method = RequestMethod.POST )
    public ModelAndView addCourse( @Valid @ModelAttribute( "course" ) CourseForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes ){
        if( result.hasErrors() )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        service.addCourse( new Course( form.getCode(), form.getName(), form.getShortName(), form.getCurriculum(), form.getYear() ) );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.CourseCRUDController.Add", new Object[]{form.getName()} ) );

        return new ModelAndView( "redirect:/admin/courses" );
    }

    @RequestMapping( value = "/courses", method = RequestMethod.PUT )
    public ModelAndView updateCourse( @Valid @ModelAttribute( "updateCourse" ) CourseUpdateForm form, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes ){
        if( result.hasErrors() )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        Integer id = form.getId();

        if( id == null )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        Course c = service.getCourseById( id );

        if( c == null )
            return new ModelAndView( "admin/courses", fillModel( model ) );

        String code = form.getCode();

        if( !StringUtils.isEmpty( code ) ){
            Course c2 = service.getCourseByCode( code );
            if( c2 != null && !c.equals( c2 ) ){
                result.reject( "CheckCodeExists.CourseUpdateForm.code" );
                return new ModelAndView( "admin/courses", fillModel( model ) );
            }
        }

        c.setCode( StringUtils.defaultIfEmpty( code, c.getCode() ) );
        c.setName( StringUtils.defaultIfEmpty( form.getName(), c.getName() ) );
        c.setShortName( StringUtils.defaultIfEmpty( form.getShortName(), c.getShortName() ) );
        c.setCurriculum( ObjectUtils.defaultIfNull( form.getCurriculum(), c.getCurriculum() ) );
        c.setYear( ObjectUtils.defaultIfNull( form.getYear(), c.getYear() ) );

        service.updateCourse( c );

        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.CourseCRUDController.Update", new Object[]{form.getName()} ) );

        return new ModelAndView( "redirect:/admin/courses" );
    }

    @RequestMapping( value = "/courses", method = RequestMethod.DELETE )
    public String removeCourse( @RequestParam( required = true ) int id, RedirectAttributes redirectAttributes ){
        Course c = service.getCourseById( id );
        service.removeCourse( c );
        redirectAttributes.addFlashAttribute( "message", MessageFactory.createSuccessMessage( "Success.CourseCRUDController.Remove", new Object[]{c.getName()} ) );
        return "redirect:/admin/courses";
    }

}
