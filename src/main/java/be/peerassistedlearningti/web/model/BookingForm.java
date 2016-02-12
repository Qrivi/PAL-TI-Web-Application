package be.peerassistedlearningti.web.model;

import javax.validation.constraints.NotNull;

public class BookingForm
{

    @NotNull( message = "{NotNull.BookingForm.lesson}" )
    private String lesson;

    @NotNull( message = "{NotNull.BookingForm.student}" )
    private String student;

    public BookingForm() {}

    public String getLesson() {
        return lesson;
    }

    public String getStudent() {
        return student;
    }

    public void setLesson(String lesson) {
        this.lesson = lesson;
    }

    public void setStudent(String student) {
        this.student = student;
    }
}
