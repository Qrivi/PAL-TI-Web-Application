package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch(first = "newPassword", second = "newRepeatPassword", message = "{FieldMatch.ResetForm.newPassword.newRepeatPassword}")
public class ResetForm {

    @NotEmpty(message = "{NotEmpty.ResetForm.password}")
    private String password;
    @NotEmpty(message = "{NotEmpty.ResetForm.passwordRepeat}")
    private String passwordRepeat;

    public ResetForm() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordRepeat() {
        return passwordRepeat;
    }

    public void setPasswordRepeat(String passwordRepeat) {
        this.passwordRepeat = passwordRepeat;
    }
}
