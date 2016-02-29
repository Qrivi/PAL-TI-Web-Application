package be.peerassistedlearningti.web.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public class LessonTimelineDTO extends TimelineDTO
{
    @JsonProperty( index = 0, value = "course_name" )
    private String courseName;

    @JsonProperty( index = 1, value = "tutor_name" )
    private String tutorName;

    @JsonProperty( index = 2, value = "lesson_name" )
    private String lessonName;

    @JsonProperty( index = 3, value = "lesson_description" )
    private String lessonDescription;

    @JsonProperty( index = 4, value = "lesson_date" )
    private Date lessonDate;

    public LessonTimelineDTO( String courseName, String tutorName, String lessonName, String lessonDescription, Date lessonDate )
    {
        this.courseName = courseName;
        this.tutorName = tutorName;
        this.lessonName = lessonName;
        this.lessonDescription = lessonDescription;
        this.lessonDate = lessonDate;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public String getTutorName()
    {
        return tutorName;
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

    @Override
    public String getType()
    {
        return "lesson";
    }

    @Override
    public Date getArchiveDate()
    {
        return lessonDate;
    }
}
