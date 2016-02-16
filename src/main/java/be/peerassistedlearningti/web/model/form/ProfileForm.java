package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.web.model.validation.CheckEmailExists;
import be.peerassistedlearningti.web.model.validation.CheckWithSessionPassword;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class ProfileForm
{
    @NotEmpty( message = "{NotEmpty.ProfileForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.ProfileForm.email}" )
    @CheckEmailExists( allowSessionEmail = true)
    @Email( message = "{Email.ProfileForm.email}" )
    private String email;

    @NotEmpty( message = "{NotEmpty.ProfileForm.password}" )
    @CheckWithSessionPassword( message = "{CheckWithSessionPassword.ProfileForm.password}")
    private String password;

    private String newPassword;
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

    public void setNewPassword (String newPassword){this.newPassword=newPassword;}

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

    public String getNewPassword()
    {
        return newPassword;
    }

    public String getRepeatPassword()
    {
        return repeatPassword;
    }
}
