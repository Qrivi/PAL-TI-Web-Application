package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Room;
import be.peerassistedlearningti.model.Tutor;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.Date;

public class LessonForm
{
    @NotEmpty( message = "{NotNull.LessonForm.name}" )
    private String name;

    @NotEmpty( message = "{NotNull.LessonForm.description}" )
    private String description;

    @NotNull( message = "{NotNull.LessonForm.date}" )
    private Date date;

    //@Min( value = 1, message = "{Min.LessonForm.duration}" )
    private String duration;

    @NotNull( message = "{NotNull.LessonForm.course}" )
    private Course course;

    //@Min( value = 1, message = "{Min.LessonForm.maxParticipants}" )
    private String maxParticipants;

    @NotNull( message = "{NotNull.LessonForm.course}" )
    private Room room;

    @NotNull( message = "{NotNull.LessonForm.backupRoom}" )
    private Room backupRoom;

    public LessonForm() {}

    public String getName()
    {
        return name;
    }

    public String getDescription()
    {
        return description;
    }

    public Date getDate()
    {
        return date;
    }

    public String getDuration()
    {
        return duration;
    }

    public Course getCourse()
    {
        return course;
    }

    public String getMaxParticipants()
    {
        return maxParticipants;
    }

    public Room getRoom()
    {
        return room;
    }

    public Room getBackupRoom()
    {
        return backupRoom;
    }

    public void setName( String name )
    {
        this.name = name;
    }

    public void setDescription( String description )
    {
        this.description = description;
    }

    public void setDate( Date date )
    {
        this.date = date;
    }

    public void setDuration( String duration )
    {
        this.duration = duration;
    }

    public void setCourse( Course course )
    {
        this.course = course;
    }

    public void setMaxParticipants( String maxParticipants )
    {
        this.maxParticipants = maxParticipants;
    }

    public void setRoom( Room room )
    {
        this.room = room;
    }

    public void setBackupRoom( Room backupRoom )
    {
        this.backupRoom = backupRoom;
    }

}
