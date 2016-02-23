package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.web.model.validation.CheckEmailIsUnique;
import be.peerassistedlearningti.web.model.validation.CheckWithSessionPassword;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch( first = "newPassword", second = "newRepeatPassword", message = "{FieldMatch.ProfileForm.newPassword.newRepeatPassword}" )
public class ProfileForm
{
    @NotEmpty( message = "{NotEmpty.ProfileForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.ProfileForm.email}" )
    @CheckEmailIsUnique( allowSessionEmail = true, message = "{CheckEmailIsUnique.ProfileForm.email}" )
    @Email( message = "{Email.ProfileForm.email}" )
    private String email;

    @CheckWithSessionPassword( message = "{CheckWithSessionPassword.ProfileForm.password}" )
    private String password;

    private String newPassword;
    private String newRepeatPassword;

    public ProfileForm() {}

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

    public String getNewPassword()
    {
        return newPassword;
    }

    public void setNewPassword( String newPassword )
    {
        this.newPassword = newPassword;
    }

    public String getNewRepeatPassword()
    {
        return newRepeatPassword;
    }

    public void setNewRepeatPassword( String newRepeatPassword )
    {
        this.newRepeatPassword = newRepeatPassword;
    }
}
