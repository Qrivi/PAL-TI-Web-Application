package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.model.UserType;
import be.peerassistedlearningti.web.model.validation.CheckEmailIsUnique;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.StudentUpdateForm.password.repeatPassword}" )
public class StudentUpdateForm
{

    private Integer id;
    private String name;
    private String email;
    private String password;
    private String repeatPassword;
    private UserType type;

    public StudentUpdateForm() {}

    public Integer getId() { return id; }

    public void setId( Integer id ) { this.id = id; }

    public String getName()
    {
        return name;
    }

    public void setName( String name )
    {
        this.name = name;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail( String email )
    {
        this.email = email;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword( String password )
    {
        this.password = password;
    }

    public String getRepeatPassword()
    {
        return repeatPassword;
    }

    public void setRepeatPassword( String repeatPassword )
    {
        this.repeatPassword = repeatPassword;
    }

    public UserType getType()
    {
        return type;
    }

    public void setType( UserType type )
    {
        this.type = type;
    }

}
