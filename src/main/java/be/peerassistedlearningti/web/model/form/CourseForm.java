package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.web.model.validation.CheckCodeIsUnique;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class CourseForm
{

    @CheckCodeIsUnique( message = "{CheckCodeIsUnique.CourseForm.code}" )
    @NotEmpty( message = "{NotEmpty.CourseForm.code}" )
    private String code;

    @NotEmpty( message = "{NotEmpty.CourseForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.CourseForm.shortName}" )
    private String shortName;

    @NotEmpty( message = "{NotEmpty.CourseForm.curriculum}" )
    private String curriculum;

    @NotNull( message = "{NotNull.CourseForm.year}" )
    @Min( value = 1, message = "{Min.CourseForm.year}" )
    private Integer year;

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

    public void setCurriculum( String curriculum )
    {
        this.curriculum = curriculum;
    }

    public void setYear( Integer year )
    {
        this.year = year;
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

    public String getCurriculum()
    {
        return curriculum;
    }

    public Integer getYear()
    {
        return year;
    }
}
