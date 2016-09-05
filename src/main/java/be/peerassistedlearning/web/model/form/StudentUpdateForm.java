package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.model.UserType;

public class StudentUpdateForm{

    private Integer id = -1;
    private String name;
    private String email;
    private UserType type;
    private Curriculum curriculum;

    public StudentUpdateForm(){
    }

    public Integer getId(){
        return id;
    }

    public void setId( Integer id ){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setName( String name ){
        this.name = name;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail( String email ){
        this.email = email;
    }

    public UserType getType(){
        return type;
    }

    public void setType( UserType type ){
        this.type = type;
    }

    public Curriculum getCurriculum(){
        return curriculum;
    }

    public void setCurriculum( Curriculum curriculum ){
        this.curriculum = curriculum;
    }
}
