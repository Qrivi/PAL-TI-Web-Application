package be.peerassistedlearningti.web.controller.admin;

import be.peerassistedlearningti.model.Campus;
import be.peerassistedlearningti.model.Room;
import be.peerassistedlearningti.model.RoomType;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.web.model.form.RoomForm;
import be.peerassistedlearningti.web.model.form.RoomUpdateForm;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
public class RoomCRUDController extends AdminController
{
    @Autowired
    private PALService service;

    private ModelMap fillModel( ModelMap model )
    {
        if ( model.get( "room" ) == null )
            model.addAttribute( "room", new RoomForm() );
        if ( model.get( "updateRoom" ) == null )
            model.addAttribute( "updateRoom", new RoomUpdateForm() );
        if ( model.get( "roomTypes" ) == null )
            model.addAttribute( "roomTypes", service.getRoomTypes() );
        if ( model.get( "campuses" ) == null )
            model.addAttribute( "campuses", service.getCampuses() );
        if ( model.get( "rooms" ) == null )
            model.addAttribute( "rooms", service.getAllRooms() );
        return model;
    }

    @RequestMapping( value = "/rooms", method = RequestMethod.GET )
    public ModelAndView getRoomOverviewPage( ModelMap model )
    {
        return new ModelAndView( "admin/rooms", fillModel( model ) );
    }

    @RequestMapping( value = "/rooms", method = RequestMethod.POST )
    public ModelAndView addRoom( @Valid @ModelAttribute( "room" ) RoomForm roomForm, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/rooms", fillModel( model ) );

        service.addRoom( new Room( roomForm.getName(), roomForm.getCampus(), roomForm.getType() ) );

        return new ModelAndView( "redirect:/admin/rooms" );
    }

    @RequestMapping( value = "/rooms", method = RequestMethod.PUT )
    public ModelAndView updateRoom( @Valid @ModelAttribute( "updateStudent" ) RoomUpdateForm form, BindingResult result, ModelMap model )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "admin/rooms", fillModel( model ) );

        Integer id = form.getId();

        if ( id == null )
            return new ModelAndView( "admin/rooms", fillModel( model ) );

        Room r = service.getRoomById( id );

        if ( r == null )
            return new ModelAndView( "admin/rooms", fillModel( model ) );

        r.setName( StringUtils.defaultIfEmpty( form.getName(), r.getName() ) );
        r.setCampus( ObjectUtils.defaultIfNull( form.getCampus(), r.getCampus() ) );
        r.setType( ObjectUtils.defaultIfNull( form.getType(), r.getType() ) );

        service.updateRoom( r );
        return new ModelAndView( "redirect:/admin/rooms" );
    }

    @RequestMapping( value = "/rooms", method = RequestMethod.DELETE )
    public String removeRoom( @RequestParam( required = true ) int id )
    {
        Room r = service.getRoomById( id );
        service.removeRoom( r );
        return "redirect:/admin/rooms";
    }

}
