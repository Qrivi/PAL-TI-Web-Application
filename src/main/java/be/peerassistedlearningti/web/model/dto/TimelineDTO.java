package be.peerassistedlearningti.web.model.dto;

import be.peerassistedlearningti.common.model.archivable.Archivable;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

/**
 * Represents a timeline object
 */
public abstract class TimelineDTO implements Archivable
{
    @JsonProperty( "type" )
    public abstract String getType();

    @JsonProperty( "archive_date" )
    public abstract Date getArchiveDate();
}
