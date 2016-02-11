package be.peerassistedlearningti.web.model;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Room;
import org.hibernate.validator.constraints.NotEmpty;

import java.util.Date;

public class LessonForm
{

    @NotEmpty( message = "NotEmpty.LessonForm.date" )
    private Date date;

    private long duration;

    @NotEmpty( message = "NotEmpty.LessonForm.course" )
    private Course course;

    private int maxParticipants;

    @NotEmpty( message = "NotEmpty.LessonForm.course" )
    private Room room;

    private Room backupRoom;

    public LessonForm() {}

    public Date getDate()
    {
        return date;
    }

    public long getDuration()
    {
        return duration;
    }

    public Course getCourse()
    {
        return course;
    }

    public int getMaxParticipants()
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

    public void setDate( Date date )
    {
        this.date = date;
    }

    public void setDuration( long duration )
    {
        this.duration = duration;
    }

    public void setCourse( Course course )
    {
        this.course = course;
    }

    public void setMaxParticipants( int maxParticipants )
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