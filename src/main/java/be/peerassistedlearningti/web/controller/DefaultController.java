package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Application;
import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;


@Controller
@RequestMapping( "/" )
public class DefaultController
{

    @Autowired
    PALService service;

    @RequestMapping( method = RequestMethod.GET )
    public String getDefaultPage()
    {
        return "redirect:/profile";
    }

}
