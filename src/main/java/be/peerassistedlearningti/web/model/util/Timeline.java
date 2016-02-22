package be.peerassistedlearningti.web.model.util;

import be.peerassistedlearningti.model.Student;
import be.peerassistedlearningti.service.PALService;
import be.peerassistedlearningti.util.TimelineObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * Class used to create a timeline of different events
 */
public class Timeline {

    @Autowired
    private PALService service;
    private SortedSet<TimelineObject> objects = new TreeSet<TimelineObject>(new TimelineObjectCmp());

    public Timeline(Student student) {
        objects.addAll(service.getPastLessons(student));
        objects.addAll(service.getReviewsForStudent(student));
    }

    public Set<TimelineObject> getTimeline() {
        return objects;
    }

    //Comparator
    private class TimelineObjectCmp implements Comparator<TimelineObject> {

        public int compare(TimelineObject o1, TimelineObject o2) {
            return o1.getTimelineDate().compareTo(o2.getTimelineDate());
        }
    }
}
