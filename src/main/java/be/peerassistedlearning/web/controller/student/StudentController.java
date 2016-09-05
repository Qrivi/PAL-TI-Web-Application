package be.peerassistedlearning.web.controller.student;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

@Controller
@PreAuthorize( "hasRole('ROLE_USER')" )
public class StudentController{
}
