package be.peerassistedlearningti.web.model.form;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class ReviewForm {
    @NotEmpty(message = "{NotEmpty.CourseForm.text}")
    private String text;

    @NotNull( message = "{NotNull.ReviewForm.contentScore}" )
    @Min(value = 1, message = "{NotEmpty.CourseForm.contentScore}")
    @Max(value = 10, message = "{NotEmpty.CourseForm.contentScore}")
    private int contentScore;

    @NotNull( message = "{NotNull.ReviewForm.tutorScore}" )
    @Min(value = 1, message = "{NotEmpty.CourseForm.tutorScore}")
    @Max(value = 10, message = "{NotEmpty.CourseForm.tutorScore}")
    private int tutorScore;

    @NotNull( message = "{NotNull.ReviewForm.engagementScore}" )
    @Min(value = 1, message = "{NotEmpty.CourseForm.engagementScore}")
    @Max(value = 10, message = "{NotEmpty.CourseForm.engagementScore}")
    private int engagementScore;

    @NotNull( message = "{NotNull.ReviewForm.atmosphereScore}" )
    @Min(value = 1, message = "{NotEmpty.CourseForm.atmosphereScore}")
    @Max(value = 10, message = "{NotEmpty.CourseForm.atmosphereScore}")
    private int atmosphereScore;

    boolean anonymous;

    public String getText() {
        return text;
    }

    public int getContentScore() {
        return contentScore;
    }

    public int getTutorScore() {
        return tutorScore;
    }

    public int getEngagementScore() {
        return engagementScore;
    }

    public int getAtmosphereScore() {
        return atmosphereScore;
    }

    public boolean isAnonymous() {
        return anonymous;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setContentScore(int contentScore) {
        this.contentScore = contentScore;
    }

    public void setTutorScore(int tutorScore) {
        this.tutorScore = tutorScore;
    }

    public void setEngagementScore(int engagementScore) {
        this.engagementScore = engagementScore;
    }

    public void setAtmosphereScore(int atmosphereScore) {
        this.atmosphereScore = atmosphereScore;
    }

    public void setAnonymous(boolean anonymous) {
        this.anonymous = anonymous;
    }
}
