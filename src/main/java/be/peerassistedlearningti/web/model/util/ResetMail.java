package be.peerassistedlearningti.web.model.util;


import be.peerassistedlearningti.model.Student;

/**
 * Class used to send a reset password mail to a given student.
 */
public class ResetMail {

    /**
     * Sens the reset mail to the given student.
     *
     * @param student The student who will receive the mail
     * @param token   The plaintext token used by the student to preform a password reset
     */
    public static void send(Student student, String token) {
        String email = student.getEmail();
        System.out.println("URL=" + "http://localhost:8080/auth/reset/validate/" + email + "/" + token + "/");
    }
}
