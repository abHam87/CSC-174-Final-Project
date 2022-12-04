package academy.learnprogramming.controller;

import academy.learnprogramming.model.*;
import academy.learnprogramming.service.ClinicService;
import academy.learnprogramming.service.ClinicServiceImpl;
import academy.learnprogramming.util.AttributeNames;
import academy.learnprogramming.util.Mappings;
import academy.learnprogramming.util.ViewNames;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.SQLException;

@Slf4j
@Controller
public class ClinicController {

    // Data fields
    private final ClinicService clinicService;

    // A contractor for the controller
    @Autowired
    public ClinicController(ClinicService clinicService) {
        log.info("clientService is in the bean " + clinicService);
        this.clinicService = clinicService;

    }

    // Attribute contains all the data from the CLINIC table in the Clinic database
    @ModelAttribute
    public ClinicData clinicData() {
        return clinicService.getClinicData();
    }


    // Get mapping for:
    // https://nameless-atoll-88208.herokuapp.com/clinic/addClinic
    @GetMapping(Mappings.ADD_CLINIC)
    public String addClinic(Model model) {
        Clinic clinic = new Clinic(null,"","","","","");
        model.addAttribute(AttributeNames.CLINIC,clinic);
        return ViewNames.ADD_CLINIC;

    }

    // Get mapping for:
    // https://nameless-atoll-88208.herokuapp.com/clinic/clinicData
    @GetMapping(Mappings.ALL_CLINIC_DATA)
    public String viewClinicData(){
        return ViewNames.ALL_CLINIC_DATA;
    }

    // Post mapping for:
    // https://nameless-atoll-88208.herokuapp.com/clinic/addClinic
    @PostMapping(Mappings.ADD_CLINIC)
    public String postClinic(@ModelAttribute(AttributeNames.CLINIC) Clinic clinic) throws SQLException {
        clinicService.addClinic(clinic);
        return "redirect:/" + Mappings.ALL_CLINIC_DATA;
    }
}