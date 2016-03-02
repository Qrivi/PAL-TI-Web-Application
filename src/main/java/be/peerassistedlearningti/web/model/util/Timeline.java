package be.peerassistedlearningti.web.model.util;

import be.peerassistedlearningti.common.model.archivable.Archivable;

import java.util.Collection;
import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;

/**
 * Class used to create a timeline of different events
 */
public class Timeline {

    private Set<Archivable> archivables;

    public Timeline() {
        archivables = new TreeSet<Archivable>(new ArchiveCmp());
    }

    public boolean addAll(Collection<? extends Archivable> archivables) {
        return this.archivables.addAll(archivables);
    }

    public Set<Archivable> getArchivables() {
        return archivables;
    }

    //Comparator
    private class ArchiveCmp implements Comparator<Archivable> {

        public int compare(Archivable o1, Archivable o2) {
            return o2.getArchiveDate().compareTo(o1.getArchiveDate());
        }
    }
}
