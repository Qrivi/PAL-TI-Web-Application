package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.web.model.validation.CheckEmailExists;
import be.peerassistedlearningti.web.model.validation.CheckWithSessionPassword;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch( first = "newPassword", second = "newRepeatPassword", message = "{FieldMatch.ProfileForm.newPassword.newRepeatPassword}" )
public class ProfileForm
{
    @NotEmpty( message = "{NotEmpty.ProfileForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.ProfileForm.email}" )
    @CheckEmailExists( allowSessionEmail = true )
    @Email( message = "{Email.ProfileForm.email}" )
    private String email;

    @NotEmpty( message = "{NotEmpty.ProfileForm.password}" )
    @CheckWithSessionPassword( message = "{CheckWithSessionPassword.ProfileForm.password}" )
    private String password;

    private String newPassword;
    private String newRepeatPassword;

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

    public void setNewPassword( String newPassword ) {this.newPassword = newPassword;}

    public void setNewRepeatPassword( String newRepeatPassword )
    {
        this.newRepeatPassword = newRepeatPassword;
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

    public String getNewRepeatPassword()
    {
        return newRepeatPassword;
    }
}
