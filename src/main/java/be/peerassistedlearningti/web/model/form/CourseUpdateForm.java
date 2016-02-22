package be.peerassistedlearningti.web.model.form;

public class CourseUpdateForm
{

    private Integer id;
    private String code;
    private String name;
    private String shortName;
    private String curriculum;
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

    public void setCurriculum( String curriculum )
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

    public String getCurriculum()
    {
        return curriculum;
    }

    public Integer getYear()
    {
        return year;
    }
}
