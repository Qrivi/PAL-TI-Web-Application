package be.peerassistedlearningti.web.model.form;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Min;

public class CourseForm
{

    @NotEmpty( message = "{NotEmpty.CourseForm.code}" )
    private String code;

    @NotEmpty( message = "{NotEmpty.CourseForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.CourseForm.shortName}" )
    private String shortName;

    @NotEmpty(message = "{NotEmpty.CourseForm.curriculum}")
    private String curriculum;

    @Min(value = 1, message = "{Min.CourseForm.year}")
    private int year;

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

    public void setCurriculum(String curriculum) {
        this.curriculum = curriculum;
    }

    public void setYear(int year) {
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

    public String getCurriculum() {
        return curriculum;
    }

    public int getYear() {
        return year;
    }
}
