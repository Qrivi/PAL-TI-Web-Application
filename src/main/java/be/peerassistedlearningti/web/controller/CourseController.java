package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/course")
public class CourseController {
    @Autowired
    private PALService service;

    @RequestMapping(value = "/subscribe", method = RequestMethod.POST)
    public String subscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        service.subscribe(c, SessionAuth.getStudent());
        return "redirect:/review/overview";
    }

    @RequestMapping(value = "/subscribe", method = RequestMethod.POST)
    public String unsubscribeToCourse( @PathVariable( value = "id" ) int id )
    {
        Course c = service.getCourseById( id );
        service.unsubscribe(c, SessionAuth.getStudent());
        return "redirect:/review/overview";
    }
}
