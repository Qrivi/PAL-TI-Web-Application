package be.peerassistedlearningti.web.controller.student;


import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Request;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RequestForm;
import be.peerassistedlearningti.web.model.util.RequestSimilarityWrapper;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

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
        Request request = new Request(form.getTitle(),form.getDescription(),form.getCourse(), SessionAuth.getStudent());
        service.addRequest(request);

        return new ModelAndView("/request",fillModel(model) );
    }


    @RequestMapping(value = "/similar", method = RequestMethod.POST)
    public ModelAndView getSimilar(HttpServletRequest req) {
        String title = req.getParameter("title");
        String courseId = req.getParameter("course");
        Course course = service.getCourseById(Integer.parseInt(courseId));

        if (title == null || course == null) {
            return new ModelAndView("student/fragment/similar_requests");
        }

        Request newRequest = new Request();
        newRequest.setCourse(course);
        newRequest.setTitle(title);

        List<RequestSimilarityWrapper> similar = new LinkedList<>();
        //todo:: only this year's requests
        for (Request request : service.getAllRequest(newRequest.getCourse())) {
            double similarity = request.getSimilarity(newRequest);
            System.out.println("similarity=" + similarity);
            if (similarity >= 0.6)
                similar.add(new RequestSimilarityWrapper(similarity, request));
        }
        Collections.sort(similar);
        return new ModelAndView("student/fragment/similar_requests", "similar", similar);
    }

}
