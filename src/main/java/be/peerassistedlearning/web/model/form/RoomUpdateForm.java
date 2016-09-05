package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Campus;
import be.peerassistedlearning.model.RoomType;

public class RoomUpdateForm{
    private Integer id;
    private String name;
    private Campus campus;
    private RoomType type;

    public RoomUpdateForm(){
    }

    public Integer getId(){
        return id;
    }

    public void setId( Integer id ){
        this.id = id;
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
