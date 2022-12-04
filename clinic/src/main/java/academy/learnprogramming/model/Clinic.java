package academy.learnprogramming.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "clinicID")
public class Clinic {
    // Data fields (attributes)
    Integer clinicID;
    String phone;
    String street;
    String city;
    String state;
    String zip;

    // Clinic class constructor
    public Clinic(Integer clinicID, String phone, String street, String city, String state, String zip) {
        this.clinicID = clinicID;
        this.phone = phone;
        this.street = street;
        this.city = city;
        this.state = state;
        this.zip = zip;
    }

    // Empty clinic constructor
    public Clinic() {
    }
}
