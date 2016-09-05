package be.peerassistedlearning.web.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.web.util.HtmlUtils;

/**
 * Represents a calendar event
 */
public class CalendarDTO{
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

    @JsonProperty( index = 7, value = "course_name" )
    private String courseName;

    @JsonProperty( index = 8, value = "color" )
    private String color;

    public CalendarDTO(){
    }

    public int getId(){
        return id;
    }

    public void setId( int id ){
        this.id = id;
    }

    public String getTitle(){
        return HtmlUtils.htmlEscape( title );
    }

    public void setTitle( String title ){
        this.title = title;
    }

    public String getDescription(){
        return HtmlUtils.htmlEscape( description );
    }

    public void setDescription( String description ){
        this.description = description;
    }

    public String getColor(){
        return HtmlUtils.htmlEscape( color );
    }

    public void setColor( String color ){
        this.color = color;
    }

    public String getStart(){
        return HtmlUtils.htmlEscape( start );
    }

    public void setStart( String start ){
        this.start = start;
    }

    public String getEnd(){
        return HtmlUtils.htmlEscape( end );
    }

    public void setEnd( String end ){
        this.end = end;
    }

    public String getTutorName(){
        return HtmlUtils.htmlEscape( tutorName );
    }

    public void setTutorName( String tutorName ){
        this.tutorName = tutorName;
    }

    public String getCourseName(){
        return HtmlUtils.htmlEscape( courseName );
    }

    public void setCourseName( String courseName ){
        this.courseName = courseName;
    }

    public boolean isRegistered(){
        return registered;
    }

    public void setRegistered( boolean registered ){
        this.registered = registered;
    }
}
