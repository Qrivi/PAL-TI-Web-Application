package be.peerassistedlearning.web.model.form;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class ReviewForm
{
    @Size( min = 10, max = 140, message = "{Size.ReviewForm.text}" )
    private String text;

    @NotNull( message = "{NotNull.ReviewForm.contentScore}" )
    @Min( value = 1, message = "{Min.ReviewForm.contentScore}" )
    @Max( value = 10, message = "{Max.ReviewForm.contentScore}" )
    private Integer contentScore = 0;

    @NotNull( message = "{NotNull.ReviewForm.tutorScore}" )
    @Min( value = 1, message = "{Min.ReviewForm.tutorScore}" )
    @Max( value = 10, message = "{Max.ReviewForm.tutorScore}" )
    private Integer tutorScore = 0;

    @NotNull( message = "{NotNull.ReviewForm.engagementScore}" )
    @Min( value = 1, message = "{Min.ReviewForm.engagementScore}" )
    @Max( value = 10, message = "{Max.ReviewForm.engagementScore}" )
    private Integer engagementScore = 0;

    @NotNull( message = "{NotNull.ReviewForm.atmosphereScore}" )
    @Min( value = 1, message = "{Min.ReviewForm.atmosphereScore}" )
    @Max( value = 10, message = "{Max.ReviewForm.atmosphereScore}" )
    private Integer atmosphereScore = 0;

    private boolean anonymous;

    public ReviewForm() {}

    public void setText( String text )
    {
        this.text = text;
    }

    public void setContentScore( Integer contentScore )
    {
        this.contentScore = contentScore;
    }

    public void setTutorScore( Integer tutorScore )
    {
        this.tutorScore = tutorScore;
    }

    public void setEngagementScore( Integer engagementScore )
    {
        this.engagementScore = engagementScore;
    }

    public void setAtmosphereScore( Integer atmosphereScore )
    {
        this.atmosphereScore = atmosphereScore;
    }

    public void setAnonymous( boolean anonymous )
    {
        this.anonymous = anonymous;
    }

    public String getText()
    {
        return text;
    }

    public Integer getContentScore()
    {
        return contentScore;
    }

    public Integer getTutorScore()
    {
        return tutorScore;
    }

    public Integer getEngagementScore()
    {
        return engagementScore;
    }

    public Integer getAtmosphereScore()
    {
        return atmosphereScore;
    }

    public boolean isAnonymous()
    {
        return anonymous;
    }
}
