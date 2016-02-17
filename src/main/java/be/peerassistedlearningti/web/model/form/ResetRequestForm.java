package be.peerassistedlearningti.web.model.form;


import be.peerassistedlearningti.web.model.validation.CheckEmailExists;
import org.hibernate.validator.constraints.NotEmpty;

public class ResetRequestForm {

    @NotEmpty(message = "{NotEmpty.ResetRequestForm.email}")
    @CheckEmailExists(inverted = true, message = "{CheckEmailExists.ResetRequestForm.email}")
    private String email;

    public ResetRequestForm() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
