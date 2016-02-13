package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.StudentForm.password.repeatPassword}" )
public class StudentForm
{

    @NotEmpty( message = "{NotEmpty.StudentForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.StudentForm.email}" )
    @Email( message = "{Email.StudentForm.email}" )
    private String email;

    @NotEmpty( message = "{NotEmpty.StudentForm.password}" )
    private String password;

    @NotEmpty( message = "{NotEmpty.StudentForm.repeatPassword}" )
    private String repeatPassword;

    private boolean admin = false;

    public StudentForm() {}

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

    public void setAdmin( boolean admin )
    {
        this.admin = admin;
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

    public boolean isAdmin()
    {
        return admin;
    }

}
