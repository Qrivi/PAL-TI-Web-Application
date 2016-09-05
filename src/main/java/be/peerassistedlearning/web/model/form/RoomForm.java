package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Campus;
import be.peerassistedlearning.model.RoomType;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.SafeHtml;

import javax.validation.constraints.NotNull;

public class RoomForm{
    @SafeHtml
    @NotEmpty( message = "{NotEmpty.RoomForm.name}" )
    private String name;

    @NotNull( message = "{NotNull.RoomForm.campus}" )
    private Campus campus;

    @NotNull( message = "{NotNull.RoomForm.type}" )
    private RoomType type;

    public RoomForm(){
    }

    public String getName(){
        return name;
    }

    public void setName( String name ){
        this.name = name;
    }

    public Campus getCampus(){
        return campus;
    }

    public void setCampus( Campus campus ){
        this.campus = campus;
    }

    public RoomType getType(){
        return type;
    }

    public void setType( RoomType type ){
        this.type = type;
    }
}
