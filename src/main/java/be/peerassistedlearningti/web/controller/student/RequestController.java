package be.peerassistedlearningti.web.controller.student;


import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RequestForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping (value = "/request")
public class RequestController extends StudentController {
    @Autowired
    private PALService service;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getRequestPage()
    {
        ModelMap model = new ModelMap();
        model.addAttribute("request", new RequestForm());
        model.addAttribute("courses", service.getAllCourses());
        return new ModelAndView("student/request_add",model );
    }

}
