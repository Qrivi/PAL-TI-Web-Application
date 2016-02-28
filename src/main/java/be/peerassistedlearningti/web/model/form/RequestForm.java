package be.peerassistedlearningti.web.model.form;


import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Student;

import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

public class RequestForm {

    @Min(value = 0, message = "{Min.RequestForm.upvotes}")
    private int upvotes;

    @NotNull(message = "{NotNull.RequestForm.description}")
    @Size( min = 10, max = 300, message = "{Size.RequestForm.text}" )
    private String description;

    @Valid
    @NotNull(message = "{NotNull.RequestForm.course}")
    private Course course;

    @Valid
    @NotNull(message = "{NotNull.RequestForm.student}")
    private Student student;

    @NotNull(message = "{NotNull.RequestForm.creationDate}")
    private Date creationDate;

    public RequestForm() {
    }

    public int getUpvotes() {
        return upvotes;
    }

    public void setUpvotes(int upvotes) {
        this.upvotes = upvotes;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
}
