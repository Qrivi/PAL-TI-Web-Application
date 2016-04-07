package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.web.model.validation.CheckCodeIsUnique;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.SafeHtml;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class CourseForm
{

    @SafeHtml
    @CheckCodeIsUnique( message = "{CheckCodeIsUnique.CourseForm.code}" )
    @NotEmpty( message = "{NotEmpty.CourseForm.code}" )
    private String code;

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.CourseForm.name}" )
    private String name;

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.CourseForm.shortName}" )
    private String shortName;

    @NotNull( message = "{NotNull.CourseForm.curriculum}" )
    private Curriculum curriculum;

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

    public void setCurriculum( Curriculum curriculum )
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

    public Curriculum getCurriculum()
    {
        return curriculum;
    }

    public Integer getYear()
    {
        return year;
    }
}
