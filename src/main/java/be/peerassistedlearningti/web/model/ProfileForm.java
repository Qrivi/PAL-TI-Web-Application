package be.peerassistedlearningti.web.model;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class ProfileForm
{
    @NotEmpty( message = "{NotEmpty.ProfileForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.ProfileForm.email}" )
    @Email( message = "{Email.ProfileForm.email}" )
    private String email;

    private String password;
    private String repeatPassword;

    public ProfileForm() {}

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
}
