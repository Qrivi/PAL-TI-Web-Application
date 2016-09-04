package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.model.UserType;

public class StudentUpdateForm
{

    private Integer id = -1;
    private String name;
    private String email;
    private UserType type;
    private Curriculum curriculum;

    public StudentUpdateForm() {}

    public void setId( Integer id ) { this.id = id; }

    public void setName( String name )
    {
        this.name = name;
    }

    public void setEmail( String email )
    {
        this.email = email;
    }

    public void setType( UserType type )
    {
        this.type = type;
    }

    public void setCurriculum( Curriculum curriculum )
    {
        this.curriculum = curriculum;
    }

    public Integer getId() { return id; }

    public String getName()
    {
        return name;
    }

    public String getEmail()
    {
        return email;
    }

    public UserType getType()
    {
        return type;
    }

    public Curriculum getCurriculum()
    {
        return curriculum;
    }
}
