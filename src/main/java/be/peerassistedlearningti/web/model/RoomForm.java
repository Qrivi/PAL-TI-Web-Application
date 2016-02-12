package be.peerassistedlearningti.web.model;

import be.peerassistedlearningti.model.Campus;
import be.peerassistedlearningti.model.RoomType;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

public class RoomForm {
    @NotEmpty( message = "{NotEmpty.CourseForm.name}" )
    private String name;

    @NotNull( message = "{NotEmpty.CourseForm.campus}" )
    private Campus campus;

    @NotNull( message = "{NotEmpty.CourseForm.type}" )
    private RoomType type;

    public RoomForm(){}

    public String getName() {
        return name;
    }

    public Campus getCampus() {
        return campus;
    }

    public RoomType getType() {
        return type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCampus(Campus campus) {
        this.campus = campus;
    }

    public void setType(RoomType type) {
        this.type = type;
    }
}
