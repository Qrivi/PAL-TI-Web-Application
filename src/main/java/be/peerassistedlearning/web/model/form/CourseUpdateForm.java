package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Curriculum;

public class CourseUpdateForm{

    private Integer id;
    private String code;
    private String name;
    private String shortName;
    private Curriculum curriculum;
    private Integer year;

    public CourseUpdateForm(){
    }

    public Integer getId(){
        return id;
    }

    public void setId( Integer id ){
        this.id = id;
    }

    public String getCode(){
        return code;
    }

    public void setCode( String code ){
        this.code = code;
    }

    public String getName(){
        return name;
    }

    public void setName( String name ){
        this.name = name;
    }

    public String getShortName(){
        return shortName;
    }

    public void setShortName( String shortName ){
        this.shortName = shortName;
    }

    public Curriculum getCurriculum(){
        return curriculum;
    }

    public void setCurriculum( Curriculum curriculum ){
        this.curriculum = curriculum;
    }

    public Integer getYear(){
        return year;
    }

    public void setYear( Integer year ){
        this.year = year;
    }
}
