package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Lesson;
import be.peerassistedlearningti.model.Student;

import javax.validation.constraints.NotNull;

public class BookingForm
{

    @NotNull( message = "{NotNull.BookingForm.lesson}" )
    private Lesson lesson;

    @NotNull( message = "{NotNull.BookingForm.student}" )
    private Student student;

    public BookingForm() {}

    public void setLesson( Lesson lesson )
    {
        this.lesson = lesson;
    }

    public void setStudent( Student student )
    {
        this.student = student;
    }

    public Lesson getLesson()
    {
        return lesson;
    }

    public Student getStudent()
    {
        return student;
    }
}
