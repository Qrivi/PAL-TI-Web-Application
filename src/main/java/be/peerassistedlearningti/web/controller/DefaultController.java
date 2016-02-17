package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.dao.CourseDAO;
import be.peerassistedlearningti.dao.StudentDAO;
import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.repository.StudentRepository;
import be.peerassistedlearningti.repository.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collection;


@Controller
@RequestMapping( "/" )
public class DefaultController
{

    @Autowired
    StudentService studentService;

    @ResponseBody
    @RequestMapping( method = RequestMethod.GET )
    public String getDefaultPage()
    {

        return "Default page";
    }

}
