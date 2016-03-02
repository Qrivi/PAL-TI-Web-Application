package be.peerassistedlearningti.web.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Represents a calendar event
 */
public class CalendarDTO
{
    @JsonProperty( index = 0, value = "id" )
    private int id;

    @JsonProperty( index = 1, value = "title" )
    private String title;

    @JsonProperty( index = 2, value = "description" )
    private String description;

    @JsonProperty( index = 3, value = "start" )
    private String start;

    @JsonProperty( index = 4, value = "end" )
    private String end;

    @JsonProperty( index = 5, value = "tutor_name" )
    private String tutorName;

    @JsonProperty( index = 6, value = "registered" )
    private boolean registered;

    @JsonProperty( index = 7, value = "color" )
    private String color;

    public CalendarDTO() {}

    public void setId( int id )
    {
        this.id = id;
    }

    public void setTitle( String title )
    {
        this.title = title;
    }

    public void setDescription( String description )
    {
        this.description = description;
    }

    public void setStart( String start )
    {
        this.start = start;
    }

    public void setEnd( String end )
    {
        this.end = end;
    }

    public void setColor( String color )
    {
        this.color = color;
    }

    public void setTutorName( String tutorName )
    {
        this.tutorName = tutorName;
    }

    public void setRegistered( boolean registered )
    {
        this.registered = registered;
    }

    public int getId()
    {
        return id;
    }

    public String getTitle()
    {
        return title;
    }

    public String getDescription()
    {
        return description;
    }

    public String getColor()
    {
        return color;
    }

    public String getStart() { return start; }

    public String getEnd()
    {
        return end;
    }

    public String getTutorName()
    {
        return tutorName;
    }

    public boolean isRegistered()
    {
        return registered;
    }
}
