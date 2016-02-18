package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.CourseForm;
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

    @RequestMapping( value = "/course/overview", method = RequestMethod.GET )
    public ModelAndView getCourseOverviewPage()
    {
        return new ModelAndView("course", "courses", service.getAllCourses());
    }

    @RequestMapping( value = "/course/{id}", method = RequestMethod.GET )
    public ModelAndView getCourseDetailPage( @PathVariable( value = "id" ) int id, ModelMap model )
    {
        return new ModelAndView("course_add", "course", service.getCourseById(id));
    }

    @RequestMapping( value = "/course/add", method = RequestMethod.GET )
    public ModelAndView getCourseAddPage()
    {
        return new ModelAndView( "course_add", "course", new CourseForm() );
    }

    @RequestMapping( value = "/course/remove/{id}", method = RequestMethod.POST )
    public String removeCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById(id);
        service.removeCourse(c);
        return "redirect:/admin/course/overview";
    }

    @RequestMapping( value = "/course/add", method = RequestMethod.POST )
    public ModelAndView addCourse( @Valid @ModelAttribute( "course" ) CourseForm courseForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "course_add" );

        service.addCourse(new Course(courseForm.getCode(), courseForm.getName(), courseForm.getShortName(), courseForm.getCurriculum(), courseForm.getYear()));

        return new ModelAndView( "redirect:/admin/course/overview" );
    }

}
