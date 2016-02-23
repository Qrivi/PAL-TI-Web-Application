package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.Timeline;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/dashboard")
@PreAuthorize("hasRole('ROLE_USER')")
public class DashboardController {
    @Autowired
    private PALService service;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getDashboard(Authentication auth) {
        Student current = (Student) auth.getPrincipal();

        ModelMap map = new ModelMap();
        //Add ProfileForm object to modelmap
        ProfileForm profile = new ProfileForm();
        profile.setName(current.getName());
        profile.setEmail(current.getEmail());
        map.addAttribute("profile", profile);

        //Add Student object to modelmap
        map.addAttribute("user", current);

        //Add reviews to modelmap
        Tutor tutor = current.getTutor();
        if (tutor != null)
            map.addAttribute("reviews", service.getReviews(tutor));

        //Add Timeline to modelmap
        Timeline timeline = new Timeline();
        timeline.addAll(service.getPastLessons(current));
        timeline.addAll(service.getReviewsForStudent(current));

        map.addAttribute("timeline", timeline);

        return new ModelAndView("dashboard", map);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView modifyStudentProfile(@Valid @ModelAttribute("profile") ProfileForm form, BindingResult result) {
        if (result.hasErrors())
            return new ModelAndView("dashboard");

        Student student = SessionAuth.getStudent();

        student.setName(form.getName());
        student.setEmail(form.getEmail());
        if (!form.getNewPassword()
                .isEmpty()) {
            student.setPassword(form.getNewPassword());
        }

        //TODO update session only if db is updated w/o errors
        service.updateStudent(student);
        SessionAuth.setStudent(student);


        return new ModelAndView("dashboard");
    }

}