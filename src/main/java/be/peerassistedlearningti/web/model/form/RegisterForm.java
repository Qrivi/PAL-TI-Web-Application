package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearning.common.model.validation.FieldMatch;
import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearningti.web.model.validation.CheckEmailIsUnique;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.RegisterForm.password.repeatPassword}" )
public class RegisterForm
{

    @NotEmpty( message = "{NotEmpty.RegisterForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.RegisterForm.email}" )
    @Email( message = "{Email.RegisterForm.email}" )
    @CheckEmailIsUnique( message = "{CheckEmailIsUnique.RegisterForm.email}" )
    private String email;

    @NotEmpty( message = "{NotEmpty.RegisterForm.password}" )
    private String password;

    @NotEmpty( message = "{NotEmpty.RegisterForm.repeatPassword}" )
    private String repeatPassword;

    @NotNull( message = "{NotNull.RegisterForm.curriculum}" )
    private Curriculum curriculum;

    public RegisterForm() {}

    public void setName( String name )
    {
        this.name = name;
    }

    public void setCurriculum( Curriculum curriculum )
    {
        this.curriculum = curriculum;
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

    public String getName()
    {
        return name;
    }

    public String getEmail()
    {
        return email;
    }

    public Curriculum getCurriculum()
    {
        return curriculum;
    }

    public String getPassword()
    {
        return password;
    }

    public String getRepeatPassword()
    {
        return repeatPassword;
    }

}
