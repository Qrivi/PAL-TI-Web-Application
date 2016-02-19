package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import be.peerassistedlearningti.web.model.validation.CheckEmailIsUnique;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.StudentForm.password.repeatPassword}" )
public class RegisterForm
{

    @NotEmpty( message = "{NotEmpty.StudentForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.StudentForm.email}" )
    @Email( message = "{Email.StudentForm.email}" )
    @CheckEmailIsUnique( message = "{CheckEmailIsUnique.StudentForm.email}" )
    private String email;

    @NotEmpty( message = "{NotEmpty.StudentForm.password}" )
    private String password;

    @NotEmpty( message = "{NotEmpty.StudentForm.repeatPassword}" )
    private String repeatPassword;

    public RegisterForm() {}

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

}
