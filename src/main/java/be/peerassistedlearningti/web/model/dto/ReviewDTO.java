package be.peerassistedlearningti.web.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

/**
 * Represents a review
 */
public class ReviewDTO
{
    @JsonProperty( index = 0, value = "student_id" )
    private int studentId;

    @JsonProperty( index = 1, value = "tutor_id" )
    private int tutorId;

    @JsonProperty( index = 2, value = "tutor_name" )
    private String tutorName;

    @JsonProperty( index = 3, value = "tutor_profile_identifier" )
    private String tutorProfileIdentifier;

    @JsonProperty( index = 4, value = "course_name" )
    private String courseName;

    @JsonProperty( index = 5, value = "lesson_id" )
    private int lessonId;

    @JsonProperty( index = 6, value = "lesson_name" )
    private String lessonName;

    @JsonProperty( index = 7, value = "lesson_description" )
    private String lessonDescription;

    @JsonProperty( index = 8, value = "lesson_date" )
    private Date lessonDate;

    @JsonProperty( index = 9, value = "text" )
    private String text;

    @JsonProperty( index = 9, value = "done" )
    private boolean done;

    public ReviewDTO() {}

    public ReviewDTO( int studentId, int tutorId, String tutorName, String tutorProfileIdentifier, String courseName, int lessonId, String lessonName, String lessonDescription, Date lessonDate, String text, boolean done )
    {
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.tutorName = tutorName;
        this.tutorProfileIdentifier = tutorProfileIdentifier;
        this.courseName = courseName;
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.lessonDescription = lessonDescription;
        this.lessonDate = lessonDate;
        this.text = text;
        this.done = done;
    }

    public int getStudentId()
    {
        return studentId;
    }

    public int getTutorId()
    {
        return tutorId;
    }

    public String getTutorName()
    {
        return tutorName;
    }

    public String getTutorProfileIdentifier()
    {
        return tutorProfileIdentifier;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public int getLessonId()
    {
        return lessonId;
    }

    public String getLessonName()
    {
        return lessonName;
    }

    public String getLessonDescription()
    {
        return lessonDescription;
    }

    public Date getLessonDate()
    {
        return lessonDate;
    }

    public String getText()
    {
        return text;
    }

    public boolean isDone()
    {
        return done;
    }
}
