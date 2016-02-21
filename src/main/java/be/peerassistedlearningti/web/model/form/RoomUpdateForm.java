package be.peerassistedlearningti.web.model.form;

import be.peerassistedlearningti.model.Campus;
import be.peerassistedlearningti.model.RoomType;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

public class RoomUpdateForm
{
    private Integer id;
    private String name;
    private Campus campus;
    private RoomType type;

    public RoomUpdateForm() {}

    public Integer getId()
    {
        return id;
    }

    public String getName()
    {
        return name;
    }

    public Campus getCampus()
    {
        return campus;
    }

    public RoomType getType()
    {
        return type;
    }

    public void setId( Integer id )
    {
        this.id = id;
    }

    public void setName( String name )
    {
        this.name = name;
    }

    public void setCampus( Campus campus )
    {
        this.campus = campus;
    }

    public void setType( RoomType type )
    {
        this.type = type;
    }
}
