package be.peerassistedlearningti.web.controller.student;


import be.peerassistedlearningti.model.Request;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RequestForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping (value = "/request")
public class RequestController extends StudentController {
    @Autowired
    private PALService service;

    private ModelMap fillModel(ModelMap model){
        if(model.get("request") == null)
            model.addAttribute("request", new RequestForm());
        if(model.get("courses") == null)
            model.addAttribute("courses", service.getAllCourses());

        return model;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getRequestPage(ModelMap model)
    {
        return new ModelAndView("student/request_add",fillModel(model));
    }


    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView addRequest(@Valid @ModelAttribute(value = "request") RequestForm form, BindingResult result, ModelMap model)
    {
        if(result.hasErrors()){
            return new ModelAndView("/request");
        }
        Request request = new Request(0, form.getTitle(),form.getDescription(),form.getCourse(), SessionAuth.getStudent());
        service.addRequest(request);

        return new ModelAndView("/request",fillModel(model) );
    }

    //TODO:: AJAX for similar requests
    //http://www.mkyong.com/spring-mvc/spring-4-mvc-ajax-hello-world-example/
}
