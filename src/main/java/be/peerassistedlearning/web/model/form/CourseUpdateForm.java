package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Curriculum;

public class CourseUpdateForm
{

    private Integer id;
    private String code;
    private String name;
    private String shortName;
    private Curriculum curriculum;
    private Integer year;

    public CourseUpdateForm() {}

    public void setId( Integer id )
    {
        this.id = id;
    }

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

    public Integer getId()
    {
        return id;
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
