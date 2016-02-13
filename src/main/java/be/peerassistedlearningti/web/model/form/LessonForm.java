package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Course;
import be.peerassistedlearningti.model.Room;
import be.peerassistedlearningti.model.Tutor;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import java.util.Date;

public class LessonForm
{
    @NotEmpty( message = "{NotNull.LessonForm.name}")
    private String name;

    private String description;

    @NotNull( message = "{NotNull.LessonForm.date}" )
    private Date date;

    private long duration;

    @NotNull( message = "{NotNull.LessonForm.course}" )
    private Course course;

    private int maxParticipants;

    @NotNull( message = "{NotNull.LessonForm.course}" )
    private Room room;

    private Room backupRoom;

    @NotNull( message = "{NotNull.LessonForm.course}")
    private Tutor tutor;

    public LessonForm() {}

    public String getName(){
        return name;
    }

    public String getDescription() {
        return description;
    }

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

    public Tutor getTutor()
    {
        return tutor;
    }

    public void setName(String name){
        this.name = name;
    }

    public void setDescription(String description){
        this.description = description;
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

    public void setTutor(Tutor tutor) {
        this.tutor = tutor;
    }

}
