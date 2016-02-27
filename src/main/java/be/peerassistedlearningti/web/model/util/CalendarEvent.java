package be.peerassistedlearningti.web.model.util;

/**
 * Represents a calendar event
 */
public class CalendarEvent
{
    private String title;
    private String start;
    private String end;
    private String color;

    public CalendarEvent() {}

    public void setTitle( String title )
    {
        this.title = title;
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

    public String getStart() { return start; }

    public String getTitle()
    {
        return title;
    }

    public String getColor()
    {
        return color;
    }

    public String getEnd()
    {
        return end;
    }
}
