package be.peerassistedlearningti.web.model.util;


public class ResetMail {

    public static void send(String email, String token) {
        System.out.println("URL=" + "http://localhost:8080/auth/reset/validate/" + email + "/" + token);
    }
}
