CREATE TABLE CLINIC(
    ClinicID INT(5) NOT NULL,
    Phone    VARCHAR(10),
    Street   VARCHAR(20),
    City     VARCHAR(15),
    State    CHAR(2),
    Zip      CHAR(5),
    PRIMARY KEY (ClinicID)
);

CREATE TABLE EMPLOYEE(
    EmployeeID CHAR(5)     NOT NULL,
    FName      VARCHAR(20) NOT NULL,
    LName      VARCHAR(20) NOT NULL,
    PRIMARY KEY (EmployeeID)
);

CREATE TABLE NURSE(
    EmployeeID CHAR(5) NOT NULL,
    Position   VARCHAR(10),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
);

CREATE TABLE DOCTOR(
    EmployeeID     CHAR(5) NOT NULL,
    Medical_Degree VARCHAR(10),
    Specialty      VARCHAR(10),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
);

CREATE TABLE FRONT_DESK_TECH(
    EmployeeID CHAR(5) NOT NULL,
    WPM        VARCHAR(5),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
);

CREATE TABLE PATIENT(
    SSN   CHAR(9) NOT NULL,
    DOB   date,
    FName VARCHAR(20),
    LName VARCHAR(20),
    PRIMARY KEY (SSN)
);

CREATE TABLE WORKS(
    EmployeeID   CHAR(5) NOT NULL,
    ClinicID     INT(5) NOT NULL,
    Date_Started DATE,
    PRIMARY KEY (EmployeeID, ClinicID),
    FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID),
    FOREIGN KEY (ClinicID)
        REFERENCES CLINIC(ClinicID)
);

CREATE TABLE DIAGNOSE(
    EmployeeID CHAR(5) NOT NULL,
    SSN     CHAR(9) NOT NULL,
    Diagnosis  VARCHAR(50),
    Date       date,
    PRIMARY KEY (EmployeeID, SSN),
    FOREIGN KEY (EmployeeID)
        REFERENCES DOCTOR(EmployeeID),
    FOREIGN KEY (SSN)
        REFERENCES PATIENT(SSN)
);

DELIMITER $$
CREATE TRIGGER DOCTOR_INSERT
BEFORE INSERT ON DOCTOR
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM NURSE
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER DOCTOR_UPDATE
BEFORE UPDATE ON DOCTOR
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM NURSE
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER DOCTOR_DELETE
BEFORE INSERT ON DOCTOR
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM NURSE
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER NURSE_INSERT
BEFORE INSERT ON NURSE
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID IN (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER NURSE_UPDATE
BEFORE UPDATE ON NURSE
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID IN (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER NURSE_DELETE
BEFORE DELETE ON NURSE
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID IN (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM FRONT_DESK_TECH
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER FDT_INSERT
BEFORE INSERT ON FRONT_DESK_TECH
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM NURSE
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER FDT_UPDATE
BEFORE UPDATE ON FRONT_DESK_TECH
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM NURSE
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE TRIGGER FDT_DELETE
BEFORE DELETE ON FRONT_DESK_TECH
  FOR EACH ROW
    BEGIN
      IF NEW.EmployeeID in (
        SELECT EmployeeID
        FROM DOCTOR
        UNION
        SELECT EmployeeId
        FROM NURSE
        )
        THEN SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Subclasses must be disjoint';
        END IF;
    END $$

CREATE FUNCTION CheckWPM(WPM INT) RETURNS VARCHAR(255)
    BEGIN
        IF WPM >= 60 THEN RETURN 'Congrats! You are qualified for the Front Desk job.';
        ELSE RETURN 'Your typing speed is less than 60 WPM, you are not qualified for this job.';
        END IF ;
    END $$

DELIMITER ;