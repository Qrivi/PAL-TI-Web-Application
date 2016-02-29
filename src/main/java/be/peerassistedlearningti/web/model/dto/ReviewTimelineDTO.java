package be.peerassistedlearningti.web.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

/**
 * Represents a review timeline object
 */
public class ReviewTimelineDTO extends TimelineDTO
{

    @JsonProperty( value = "text" )
    private String text;

    @JsonProperty( value = "tutor_name" )
    private String tutorName;

    @JsonProperty( value = "date" )
    private Date date;

    public ReviewTimelineDTO( String text, String tutorName, Date date )
    {
        this.text = text;
        this.tutorName = tutorName;
        this.date = date;
    }

    public String getText()
    {
        return text;
    }

    public String getTutorName()
    {
        return tutorName;
    }

    public Date getDate()
    {
        return date;
    }

    @Override
    public String getType()
    {
        return "review";
    }

    @Override
    public Date getArchiveDate()
    {
        return date;
    }
}
