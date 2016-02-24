package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.web.model.validation.CheckEmailIsUnique;
import be.peerassistedlearningti.web.model.validation.CheckWithSessionPassword;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

@FieldMatch( first = "newPassword", second = "newRepeatPassword", message = "{FieldMatch.ProfileForm.newPassword.newRepeatPassword}" )
public class ProfileForm
{
    private MultipartFile avatar;

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
    private int[] subscriptions;

    public ProfileForm() {}

    public MultipartFile getAvatar()
    {
        return avatar;
    }

    public void setAvatar( MultipartFile avatar )
    {
        this.avatar = avatar;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
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

    public int[] getSubscriptions() {
        return subscriptions;
    }

    public void setSubscriptions(int[] subscriptions) {
        this.subscriptions = subscriptions;
    }
}
