package be.peerassistedlearningti.web.controller;

import be.peerassistedlearningti.model.Room;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RoomForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping( value = "/room" )
public class RoomController {
    @Autowired
    private PALService service;

    @RequestMapping( value = "/overview", method = RequestMethod.GET )
    public ModelAndView getRoomOverviewPage()
    {
        return new ModelAndView( "room", "rooms", service.getAllRooms());
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView addRoom()
    {
        ModelMap model = new ModelMap();
        model.addAttribute("room", new RoomForm());
        model.addAttribute("campuses",service.getCampuses());
        model.addAttribute("roomTypes",service.getRoomTypes());
        return new ModelAndView( "room_add", model );
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addRoom(@Valid @ModelAttribute( "room" ) RoomForm roomForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "room_add" );

        service.addRoom( new Room( roomForm.getName(), roomForm.getCampus(), roomForm.getType() ) );

        return new ModelAndView( "redirect:/room/overview" );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeRoom( @PathVariable( value = "id" ) int id )
    {
        Room r = service.getRoomById( id );
        service.removeRoom( r );
        return "redirect:/room/overview";
    }


}
