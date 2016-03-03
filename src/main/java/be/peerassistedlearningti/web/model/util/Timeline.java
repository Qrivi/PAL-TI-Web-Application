package be.peerassistedlearningti.web.model.util;

import be.peerassistedlearningti.common.model.archivable.Archivable;

import java.util.Collection;
import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;

/**
 * Class used to create a timeline of different events
 */
public class Timeline
{

    private Set<Archivable> archivables;

    /**
     * Default constructor
     */
    public Timeline()
    {
        archivables = new TreeSet<>( new ArchiveCmp() );
    }

    /**
     * Adds a collection of Archivable objects to the timeline
     *
     * @param archivables The collection to add to the timeline
     * @return If the collection is changed as a result of the call
     */
    public boolean addAll( Collection<? extends Archivable> archivables )
    {
        return this.archivables.addAll( archivables );
    }

    /**
     * Limits the list of archivables
     *
     * @param limit
     */
    public void limit( int limit )
    {
        if ( archivables.size() < limit )
            return;
        Set<Archivable> limited = new TreeSet<>( new ArchiveCmp() );
        for ( Archivable a : archivables )
            limited.add( a );
        archivables = limited;
    }

    /**
     * Compares two Archivable object using the getArchiveDate method
     */
    private class ArchiveCmp implements Comparator<Archivable>
    {
        public int compare( Archivable o1, Archivable o2 )
        {
            return o2.getArchiveDate().compareTo( o1.getArchiveDate() );
        }
    }

    /**
     * @return The archivable list of the timeline
     */
    public Set<Archivable> getArchivables()
    {
        return archivables;
    }
}
