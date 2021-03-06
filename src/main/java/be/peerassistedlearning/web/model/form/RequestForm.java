package be.peerassistedlearning.web.model.form;


import be.peerassistedlearning.model.Course;
import org.hibernate.validator.constraints.SafeHtml;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class RequestForm{

    @SafeHtml
    @NotNull( message = "{NotNull.RequestForm.title}" )
    @Size( min = 3, max = 50, message = "{Size.RequestForm.title}" )
    private String title;

    @SafeHtml
    @NotNull( message = "{NotNull.RequestForm.description}" )
    @Size( min = 10, max = 300, message = "{Size.RequestForm.text}" )
    private String description;

    @Valid
    @NotNull( message = "{NotNull.RequestForm.course}" )
    private Course course;

    public RequestForm(){
    }

    public String getTitle(){
        return title;
    }

    public void setTitle( String title ){
        this.title = title;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription( String description ){
        this.description = description;
    }

    public Course getCourse(){
        return course;
    }

    public void setCourse( Course course ){
        this.course = course;
    }

}
