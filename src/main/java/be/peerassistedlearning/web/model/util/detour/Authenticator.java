package be.peerassistedlearning.web.model.util.detour;

import be.krivi.detour.KUAuth;
import be.krivi.detour.core.KUAccount;

public class Authenticator{

    public static KUAccount auth( String id, String password){
        KUAuth detour = new KUAuth();
        return detour.authenticate( id, password );
    }
}
