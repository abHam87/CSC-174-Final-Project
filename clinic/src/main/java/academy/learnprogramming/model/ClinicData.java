package academy.learnprogramming.model;

import lombok.NonNull;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class ClinicData {

    // Initialize list to hold data from clinic table
    private List<Clinic> items = DataSource.getInstance().query_clinic();

    public ClinicData() throws SQLException {
    }

    // Returning Clinic list and making sure it cannot be modified by the user
    public List<Clinic> getItems() {
        return Collections.unmodifiableList(items);
    }

    // Adding a new data row to the database and updating the list
    public void addItem(@NonNull Clinic toAdd) throws SQLException {
        DataSource.getInstance().insert_clinic(
                toAdd.clinicID,
                toAdd.phone,
                toAdd.street,
                toAdd.city,
                toAdd.state,
                toAdd.zip);
        List<Clinic> items2 = DataSource.getInstance().query_clinic();
        items.add(toAdd);
        // If list size is different, initialize list with new values
        if (items.size() != items2.size()) {
            items = DataSource.getInstance().query_clinic();
        }

    }
}