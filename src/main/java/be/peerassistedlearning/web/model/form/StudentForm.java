package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.common.model.validation.FieldMatch;
import be.peerassistedlearning.model.Curriculum;
import be.peerassistedlearning.model.UserType;
import be.peerassistedlearning.web.model.validation.CheckEmailIsUnique;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.SafeHtml;

import javax.validation.constraints.NotNull;

@FieldMatch( first = "password", second = "repeatPassword", message = "{FieldMatch.StudentForm.password.repeatPassword}" )
public class StudentForm
{

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.StudentForm.name}" )
    private String name;

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.StudentForm.email}" )
    @Email( message = "{Email.StudentForm.email}" )
    @CheckEmailIsUnique( message = "{CheckEmailIsUnique.StudentForm.email}" )
    private String email;

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.StudentForm.password}" )
    private String password;

    @SafeHtml
    @NotEmpty( message = "{NotEmpty.StudentForm.repeatPassword}" )
    private String repeatPassword;

    @NotNull( message = "{NotNull.StudentForm.type}" )
    private UserType type;

    @NotNull( message = "{NotNull.StudentForm.curriculum}" )
    private Curriculum curriculum;

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

    public void setType( UserType type )
    {
        this.type = type;
    }

    public void setCurriculum( Curriculum curriculum )
    {
        this.curriculum = curriculum;
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

    public UserType getType()
    {
        return type;
    }

    public Curriculum getCurriculum()
    {
        return curriculum;
    }
}
