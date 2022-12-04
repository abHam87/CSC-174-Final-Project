package academy.learnprogramming.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataSource {
    // Connecting into to MySQL database using JDBC
    public static final String CONNECTION_STRING = "jdbc:mysql://b2bfed5243e005:27cfdad7@us-cdbr-east-06.cleardb.net/heroku_8780401f05d27e4?reconnect=true";

    // Prepared statement for inserting data into clinic table
    public static final String insert_clinic_query =
            "INSERT INTO clinic VALUES (?,?,?,?,?,?)";

    // Select statement used to view CLINIC table
    public static final String view_clinic_query =
            "SELECT * FROM clinic";

    // Initializing prepared statement
    private PreparedStatement preparedStatement;

    private static DataSource instance = new DataSource();

    private DataSource() {
    }

    public static DataSource getInstance(){
        return instance;
    }

    // Function which allows user to insert values into CLINIC table
    public void insert_clinic(Integer clinicID, String phone, String street,
                              String city, String state, String zip) throws SQLException {
        try(Connection conn = DriverManager.getConnection(CONNECTION_STRING)){
            preparedStatement = conn.prepareStatement(insert_clinic_query);
            conn.setAutoCommit(false);
            preparedStatement.setInt(1, clinicID);
            preparedStatement.setString(2, phone);
            preparedStatement.setString(3, street);
            preparedStatement.setString(4, city);
            preparedStatement.setString(5, state);
            preparedStatement.setString(6, zip);
            // Execute prepared statement which updates all values on CLINIC table in database
            preparedStatement.executeUpdate();
            conn.commit();
        }
    }

    // List which retrieves and holds values from CLINIC table, code must be run first in order
    // to reflect any changes made within SQL
    public List<Clinic> query_clinic() throws SQLException {
        try (Connection conn = DriverManager.getConnection(CONNECTION_STRING);
             Statement statement = conn.createStatement();
             ResultSet results = statement.executeQuery(view_clinic_query)) {
            List<Clinic> clinics = new ArrayList<>();
            // While loop to iterate through each row of data within CLINIC table
            while (results.next()) {
                Clinic clinic = new Clinic();
                clinic.setClinicID(results.getInt(1));
                clinic.setPhone(results.getString(2));
                clinic.setStreet(results.getString(3));
                clinic.setCity((results.getString(4)));
                clinic.setState(results.getString(5));
                clinic.setZip(results.getString(6));
                clinics.add(clinic);
            }
            return clinics;
        }
    }
}