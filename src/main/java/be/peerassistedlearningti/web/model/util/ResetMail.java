package be.peerassistedlearningti.web.model.util;


import be.peerassistedlearningti.model.Student;

public class ResetMail {

    public static void send(Student student, String token) {
        String email = student.getEmail();
        System.out.println("URL=" + "http://localhost:8080/auth/reset/validate/" + email + "/" + token);
    }
}
