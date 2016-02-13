package be.peerassistedlearningti.web.controller;

public class TutorController
{
   /* @Autowired
    private PALService service;

    @RequestMapping( value = "/{id}", method = RequestMethod.GET )
    public ModelAndView getTutorDetailPage(@PathVariable( value = "id" ) int id, ModelMap model )
    {
        return new ModelAndView( "tutor_add", "tutor", service.getTutorById( id ) );
    }

    @RequestMapping( value = "/add", method = RequestMethod.GET )
    public ModelAndView getTutorAddPage()
    {
        return new ModelAndView( "tutor_add", "tutor", new TutorForm() );
    }

    @RequestMapping( value = "/remove/{id}", method = RequestMethod.POST )
    public String removeTutor( @PathVariable( value = "id" ) int id )
    {
        Tutor t = service.getTutorById( id );
        service.removeTutor( t );
        return "redirect:/tutor/overview";
    }

    @RequestMapping( value = "/add", method = RequestMethod.POST )
    public ModelAndView addTutor(@Valid @ModelAttribute( "tutor" ) TutorForm tutorForm, BindingResult result )
    {
        if ( result.hasErrors() )
            return new ModelAndView( "tutor_add" );

        return new ModelAndView( "redirect:/tutor/overview" );
    }

    @RequestMapping (value = "/approve", method = RequestMethod.POST )
    public ModelAndView approveTutor(){
        //TODO
    }
}*/
}