package be.peerassistedlearning.web.model.form;


import be.peerassistedlearning.model.Course;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class RequestForm
{

    @NotNull( message = "{NotNull.RequestForm.title}" )
    @Size( min = 3, max = 50, message = "{Size.RequestForm.title}" )
    private String title;

    @NotNull( message = "{NotNull.RequestForm.description}" )
    @Size( min = 10, max = 300, message = "{Size.RequestForm.text}" )
    private String description;

    @Valid
    @NotNull( message = "{NotNull.RequestForm.course}" )
    private Course course;

    public RequestForm() {}

    public void setTitle( String title )
    {
        this.title = title;
    }

    public void setDescription( String description )
    {
        this.description = description;
    }

    public void setCourse( Course course )
    {
        this.course = course;
    }

    public String getTitle()
    {
        return title;
    }

    public String getDescription()
    {
        return description;
    }

    public Course getCourse()
    {
        return course;
    }

}
