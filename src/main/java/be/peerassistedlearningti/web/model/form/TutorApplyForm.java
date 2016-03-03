package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearningti.web.model.validation.NotEmptyMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;

public class TutorApplyForm
{

    @NotNull( message = "{NotNull.TutorApplyForm.course}" )
    private Course course;

    @NotEmptyMultipartFile( message = "{NotEmptyMultipartFile.TutorApplyForm.screenshot}" )
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
