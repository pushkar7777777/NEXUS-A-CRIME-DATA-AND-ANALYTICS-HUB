package org.example.nexus.service;

import org.example.nexus.dao.CivilianRegistrationDAO;
import org.example.nexus.model.CivilianRegistration;

public class CivilianRegistrationService {

    private CivilianRegistrationDAO dao = new CivilianRegistrationDAO();

    public CivilianRegistration getById(int regId) {
        return dao.getById(regId);
    }

    public boolean updateProfile(CivilianRegistration civilian) {
        return dao.updateProfile(civilian);
    }
}
