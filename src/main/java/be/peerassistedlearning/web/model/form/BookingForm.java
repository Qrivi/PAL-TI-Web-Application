package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Student;

import javax.validation.constraints.NotNull;

public class BookingForm{

    @NotNull( message = "{NotNull.BookingForm.lesson}" )
    private Lesson lesson;

    @NotNull( message = "{NotNull.BookingForm.student}" )
    private Student student;

    public BookingForm(){
    }

    public Lesson getLesson(){
        return lesson;
    }

    public void setLesson( Lesson lesson ){
        this.lesson = lesson;
    }

    public Student getStudent(){
        return student;
    }

    public void setStudent( Student student ){
        this.student = student;
    }
}
