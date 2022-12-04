package academy.learnprogramming.service;

import academy.learnprogramming.model.*;
import lombok.Getter;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
@Getter
public class ClinicServiceImpl implements ClinicService{


    public final ClinicData clinicData = new ClinicData();

    public ClinicServiceImpl() throws SQLException {
    }

    public void addClinic(Clinic clinic) throws SQLException {
        clinicData.addItem(clinic);
    }

}
