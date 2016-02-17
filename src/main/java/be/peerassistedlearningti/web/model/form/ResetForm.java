package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.common.model.validation.FieldMatch;
import org.hibernate.validator.constraints.NotEmpty;

@FieldMatch(first = "newPassword", second = "newRepeatPassword", message = "{FieldMatch.ResetForm.newPassword.newRepeatPassword}")
public class ResetForm {

    @NotEmpty(message = "{NotEmpty.ResetForm.password}")
    private String password;
    @NotEmpty(message = "{NotEmpty.ResetForm.repeatPassword}")
    private String repeatPassword;

    public ResetForm() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRepeatPassword() {
        return repeatPassword;
    }

    public void setRepeatPassword(String repeatPassword) {
        this.repeatPassword = repeatPassword;
    }
}
