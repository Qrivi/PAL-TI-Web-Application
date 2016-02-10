package be.peerassistedlearningti.web.model;

import org.hibernate.validator.constraints.NotEmpty;

public class CourseForm
{

    @NotEmpty( message = "{NotEmpty.CourseForm.code}" )
    private String code;

    @NotEmpty( message = "{NotEmpty.CourseForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.CourseForm.shortName}" )
    private String shortName;

    public CourseForm() {}

    public void setCode( String code )
    {
        this.code = code;
    }

    public void setName( String name )
    {
        this.name = name;
    }

    public void setShortName( String shortName )
    {
        this.shortName = shortName;
    }

    public String getCode()
    {
        return code;
    }

    public String getName()
    {
        return name;
    }

    public String getShortName()
    {
        return shortName;
    }

}
