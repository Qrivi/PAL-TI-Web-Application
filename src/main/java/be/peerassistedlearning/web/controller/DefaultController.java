package be.peerassistedlearning.web.controller;

import be.peerassistedlearning.service.PALService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


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
