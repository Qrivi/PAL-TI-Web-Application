package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Course;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;

public class TutorApplyForm
{

    @NotNull( message = "{NotNull.TutorApplyForm.course}" )
    private Course course;

    @NotNull( message = "{NotNull.TutorApplyForm.screenshot}" )
    private MultipartFile screenshot;

    public TutorApplyForm() {}

    public void setCourse( Course course )
    {
        this.course = course;
    }

    public void setScreenshot( MultipartFile screenshot )
    {
        this.screenshot = screenshot;
    }

    public Course getCourse()
    {
        return course;
    }

    public MultipartFile getScreenshot()
    {
        return screenshot;
    }

}
