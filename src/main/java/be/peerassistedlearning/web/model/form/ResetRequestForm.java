package be.peerassistedlearning.web.model.form;


import be.peerassistedlearning.web.model.validation.CheckEmailIsUnique;
import org.hibernate.validator.constraints.NotEmpty;

public class ResetRequestForm {

    @NotEmpty(message = "{NotEmpty.ResetRequestForm.email}")
    @CheckEmailIsUnique(inverted = true, message = "{CheckEmailIsUnique.ResetRequestForm.email}")
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
