package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.model.Curriculum;
import be.peerassistedlearningti.model.UserType;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.StudentUpdateForm.password.repeatPassword}" )
public class StudentUpdateForm
{

    private Integer id = -1;
    private String name;
    private String email;
    private String password;
    private String repeatPassword;
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

    public void setPassword( String password )
    {
        this.password = password;
    }

    public void setRepeatPassword( String repeatPassword )
    {
        this.repeatPassword = repeatPassword;
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

    public String getPassword()
    {
        return password;
    }

    public String getRepeatPassword()
    {
        return repeatPassword;
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
