package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Course;
import be.peerassistedlearning.model.Lesson;
import be.peerassistedlearning.model.Request;
import be.peerassistedlearning.model.Room;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.time.LocalTime;
import java.util.Date;

public class LessonForm
{
    @NotEmpty( message = "{NotEmpty.LessonForm.name}" )
    private String name;

    @NotEmpty( message = "{NotEmpty.LessonForm.description}" )
    private String description;

    @NotNull( message = "{NotNull.LessonForm.date}" )
    private Date date;

    @NotNull( message = "{NotNull.LessonForm.duration}" )
    private LocalTime duration;

    @NotNull( message = "{NotNull.LessonForm.course}" )
    private Course course;

    @NotNull( message = "{NotNull.LessonForm.maxParticipants}" )
    @Min( value = 1, message = "{Min.LessonForm.maxParticipants}" )
    private Integer maxParticipants;

    @NotNull( message = "{NotNull.LessonForm.room}" )
    private Room room;

    @NotNull( message = "{NotNull.LessonForm.backupRoom}" )
    private Room backupRoom;

    private Request request;

    public LessonForm() {}

    public LessonForm( Lesson lesson )
    {
        name = lesson.getName();
        description = lesson.getDescription();
        date = lesson.getDate();
        int hours = (int) lesson.getDuration() / 60;
        int minutes = (int) lesson.getDuration() % 60;
        duration = LocalTime.of( hours, minutes );
        course = lesson.getCourse();
        maxParticipants = lesson.getMaxParticipants();
        room = lesson.getRoom();
        backupRoom = lesson.getBackupRoom();
        request = lesson.getRequest();
    }

    public String getName()
    {
        return name;
    }

    public void setName( String name )
    {
        this.name = name;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription( String description )
    {
        this.description = description;
    }

    public Date getDate()
    {
        return date;
    }

    public void setDate( Date date )
    {
        this.date = date;
    }

    public LocalTime getDuration()
    {
        return duration;
    }

    public void setDuration( LocalTime duration )
    {
        this.duration = duration;
    }

    public Course getCourse()
    {
        return course;
    }

    public void setCourse( Course course )
    {
        this.course = course;
    }

    public Integer getMaxParticipants()
    {
        return maxParticipants;
    }

    public void setMaxParticipants( Integer maxParticipants )
    {
        this.maxParticipants = maxParticipants;
    }

    public Room getRoom()
    {
        return room;
    }

    public void setRoom( Room room )
    {
        this.room = room;
    }

    public Room getBackupRoom()
    {
        return backupRoom;
    }

    public void setBackupRoom( Room backupRoom )
    {
        this.backupRoom = backupRoom;
    }

    public Request getRequest() {
        return request;
    }

    public void setRequest(Request request) {
        this.request = request;
    }
}
