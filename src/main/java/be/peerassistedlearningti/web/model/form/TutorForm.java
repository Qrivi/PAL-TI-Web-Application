package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Course;

import javax.validation.constraints.NotNull;

public class TutorForm {
    @NotNull(message = "NotNull.TutorForm.course")
    private Course course;

    public TutorForm(){}

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
}
