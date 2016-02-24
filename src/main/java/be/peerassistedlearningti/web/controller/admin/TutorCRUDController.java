package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TutorCRUDController {
    @Autowired
    private PALService service;

    @RequestMapping( value = "/tutors", method = RequestMethod.GET )
    public ModelAndView getTutorOverviewPage(ModelMap model )
    {
        return new ModelAndView("admin/tutors", "tutors", service.getAllTutors() );
    }
}