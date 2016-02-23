package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.TutorForm;
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

import javax.validation.Valid;

@Controller
public class TutorCRUDController {
    @Autowired
    private PALService service;

    @RequestMapping( value = "/tutors", method = RequestMethod.GET )
    public ModelAndView getTutorOverviewPage(ModelMap model )
    {
        return new ModelAndView( "admin/tutor", "tutors", service.getAllTutors() );
    }
}
