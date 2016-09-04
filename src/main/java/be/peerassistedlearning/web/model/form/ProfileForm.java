package be.peerassistedlearning.web.model.form;

import be.peerassistedlearning.model.Course;
import org.springframework.web.multipart.MultipartFile;

import java.util.Set;

public class ProfileForm
{
    private MultipartFile avatar;

    private Set<Course> subscriptions;

    public ProfileForm() {}

    public MultipartFile getAvatar()
    {
        return avatar;
    }

    public void setAvatar( MultipartFile avatar )
    {
        this.avatar = avatar;
    }

    public Set<Course> getSubscriptions()
    {
        return subscriptions;
    }

    public void setSubscriptions( Set<Course> subscriptions )
    {
        this.subscriptions = subscriptions;
    }
}
