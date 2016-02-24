package be.peerassistedlearningti.web.controller.student;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.model.Tutor;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.ProfileForm;
import be.peerassistedlearningti.web.model.util.SessionAuth;
import be.peerassistedlearningti.web.model.util.Timeline;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

@Controller
@RequestMapping(value = "/dashboard")
@PreAuthorize("hasRole('ROLE_USER')")
public class DashboardController {
    @Autowired
    private PALService service;

    private ModelMap fillModel(ModelMap model) {
        Student current = SessionAuth.getStudent();
        Tutor tutor = current.getTutor();

        if (model.get("profile") == null) {
            ProfileForm profile = new ProfileForm();
            profile.setName(current.getName());
            profile.setEmail(current.getEmail());
            model.addAttribute("profile", profile);
        }
        if (model.get("user") == null) {
            model.addAttribute("user", current);
        }
        if (tutor != null && model.get("reviews") == null) {
            model.addAttribute("reviews", service.getReviews(tutor));
        }
        if (model.get("timeline") == null) {
            Timeline timeline = new Timeline();
            timeline.addAll(service.getPastLessons(current));
            timeline.addAll(service.getReviewsForStudent(current));
            model.addAttribute("timeline", timeline);
        }
        if (model.get("courses") == null) {
            model.addAttribute("courses", service.getAllCourses());
        }
        return model;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getDashboard(ModelMap model) {
        return new ModelAndView("student/dashboard", fillModel(model));
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView modifyStudentProfile(@Valid @ModelAttribute("profile") ProfileForm form, BindingResult result, ModelMap model) {
        if (result.hasErrors())
            return new ModelAndView("student/dashboard", fillModel(model));

        Student student = SessionAuth.getStudent();

        student.setName(StringUtils.defaultIfEmpty(form.getName(), student.getName()));
        student.setEmail(StringUtils.defaultIfEmpty(form.getEmail(), student.getEmail()));

        if (!form.getNewPassword()
                .isEmpty()) {
            student.setPassword(form.getNewPassword());
        }

        if (!form.getAvatar()
                .isEmpty()) {
            try {
                MultipartFile avatar = form.getAvatar();
                student.setAvatar(avatar.getBytes());
            } catch (Exception e) {
                result.reject("SaveFile.ProfileForm.avatar");
                return new ModelAndView("student/dashboard", fillModel(model));
            }
        }

        service.updateStudent(student);
        SessionAuth.setStudent(student);

        return new ModelAndView("redirect:/dashboard");
    }

    @ResponseBody
    @RequestMapping(value = "/avatar.png", method = RequestMethod.GET)
    public void getScreenshot(HttpServletResponse response) {
        InputStream in = null;
        try {
            Student current = SessionAuth.getStudent();
            byte[] img = current.getAvatar();

            in = new ByteArrayInputStream(img);
            response.setContentType("image/jpeg");
            IOUtils.copy(in, response.getOutputStream());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (in != null)
                IOUtils.closeQuietly(in);
        }
    }

}
