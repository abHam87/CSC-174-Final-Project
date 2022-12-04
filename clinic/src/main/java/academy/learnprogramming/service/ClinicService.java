package academy.learnprogramming.service;

import academy.learnprogramming.model.*;

import java.sql.SQLException;

public interface ClinicService {

    public void addClinic(Clinic clinic) throws SQLException;


    public ClinicData getClinicData();



}
