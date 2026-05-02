-- ============================================================
-- CAR RENTAL MANAGEMENT SYSTEM
-- Student: Talha Aftab | SAP ID: 63091
-- Course: Database Management System | Spring 2026
-- Riphah International University
-- Oracle 11g XE Compatible
-- ============================================================

-- Drop triggers first
DROP TRIGGER trg_staff_id;
DROP TRIGGER trg_customer_id;
DROP TRIGGER trg_vehicle_id;
DROP TRIGGER trg_booking_id;
DROP TRIGGER trg_payment_id;

-- Drop sequences
DROP SEQUENCE seq_staff_id;
DROP SEQUENCE seq_customer_id;
DROP SEQUENCE seq_vehicle_id;
DROP SEQUENCE seq_booking_id;
DROP SEQUENCE seq_payment_id;

-- Drop tables in reverse dependency order
DROP TABLE PAYMENT   CASCADE CONSTRAINTS PURGE;
DROP TABLE BOOKING   CASCADE CONSTRAINTS PURGE;
DROP TABLE CUSTOMER  CASCADE CONSTRAINTS PURGE;
DROP TABLE VEHICLE   CASCADE CONSTRAINTS PURGE;
DROP TABLE STAFF     CASCADE CONSTRAINTS PURGE;

-- ============================================================
-- TABLE 1: STAFF
-- ============================================================
CREATE TABLE STAFF (
    staff_id    NUMBER          PRIMARY KEY,
    full_name   VARCHAR2(100)   NOT NULL,
    role        VARCHAR2(50)    NOT NULL
                                CONSTRAINT chk_staff_role
                                CHECK (role IN ('Manager','Agent','Mechanic')),
    email       VARCHAR2(100)   NOT NULL
                                CONSTRAINT uq_staff_email UNIQUE,
    phone       VARCHAR2(20)    NOT NULL
);

CREATE SEQUENCE seq_staff_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_staff_id
BEFORE INSERT ON STAFF
FOR EACH ROW
BEGIN
    SELECT seq_staff_id.NEXTVAL INTO :NEW.staff_id FROM DUAL;
END;
/

-- ============================================================
-- TABLE 2: CUSTOMER
-- ============================================================
CREATE TABLE CUSTOMER (
    customer_id NUMBER          PRIMARY KEY,
    full_name   VARCHAR2(100)   NOT NULL,
    email       VARCHAR2(100)   NOT NULL
                                CONSTRAINT uq_customer_email UNIQUE,
    phone       VARCHAR2(20)    NOT NULL,
    license_no  VARCHAR2(50)    NOT NULL
                                CONSTRAINT uq_license UNIQUE,
    address     VARCHAR2(255),
    created_at  DATE            DEFAULT SYSDATE NOT NULL
);

CREATE SEQUENCE seq_customer_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_customer_id
BEFORE INSERT ON CUSTOMER
FOR EACH ROW
BEGIN
    SELECT seq_customer_id.NEXTVAL INTO :NEW.customer_id FROM DUAL;
END;
/

-- ============================================================
-- TABLE 3: VEHICLE
-- ============================================================
CREATE TABLE VEHICLE (
    vehicle_id  NUMBER          PRIMARY KEY,
    make        VARCHAR2(50)    NOT NULL,
    model       VARCHAR2(50)    NOT NULL,
    year        NUMBER(4)       NOT NULL
                                CONSTRAINT chk_vehicle_year
                                CHECK (year BETWEEN 2000 AND 2030),
    plate_no    VARCHAR2(20)    NOT NULL
                                CONSTRAINT uq_plate UNIQUE,
    category    VARCHAR2(30)    NOT NULL
                                CONSTRAINT chk_category
                                CHECK (category IN ('Economy','Standard','SUV','Luxury','Van')),
    daily_rate  NUMBER(8,2)     NOT NULL
                                CONSTRAINT chk_daily_rate CHECK (daily_rate > 0),
    status      VARCHAR2(20)    DEFAULT 'Available' NOT NULL
                                CONSTRAINT chk_vehicle_status
                                CHECK (status IN ('Available','Rented','Maintenance'))
);

CREATE SEQUENCE seq_vehicle_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_vehicle_id
BEFORE INSERT ON VEHICLE
FOR EACH ROW
BEGIN
    SELECT seq_vehicle_id.NEXTVAL INTO :NEW.vehicle_id FROM DUAL;
END;
/

-- ============================================================
-- TABLE 4: BOOKING
-- ============================================================
CREATE TABLE BOOKING (
    booking_id  NUMBER          PRIMARY KEY,
    customer_id NUMBER          NOT NULL
                                CONSTRAINT fk_booking_customer
                                REFERENCES CUSTOMER(customer_id),
    vehicle_id  NUMBER          NOT NULL
                                CONSTRAINT fk_booking_vehicle
                                REFERENCES VEHICLE(vehicle_id),
    staff_id    NUMBER          NOT NULL
                                CONSTRAINT fk_booking_staff
                                REFERENCES STAFF(staff_id),
    start_date  DATE            NOT NULL,
    end_date    DATE            NOT NULL,
    total_days  NUMBER          NOT NULL,
    total_cost  NUMBER(10,2)    NOT NULL
                                CONSTRAINT chk_total_cost CHECK (total_cost >= 0),
    status      VARCHAR2(20)    DEFAULT 'Pending' NOT NULL
                                CONSTRAINT chk_booking_status
                                CHECK (status IN ('Pending','Active','Completed','Cancelled')),
    CONSTRAINT chk_dates CHECK (end_date > start_date)
);

CREATE SEQUENCE seq_booking_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_booking_id
BEFORE INSERT ON BOOKING
FOR EACH ROW
BEGIN
    SELECT seq_booking_id.NEXTVAL INTO :NEW.booking_id FROM DUAL;
    -- Auto-calculate total_days and total_cost from dates and vehicle rate
    SELECT :NEW.end_date - :NEW.start_date INTO :NEW.total_days FROM DUAL;
    SELECT (:NEW.end_date - :NEW.start_date) * v.daily_rate
    INTO :NEW.total_cost
    FROM VEHICLE v
    WHERE v.vehicle_id = :NEW.vehicle_id;
END;
/

-- ============================================================
-- TABLE 5: PAYMENT
-- ============================================================
CREATE TABLE PAYMENT (
    payment_id  NUMBER          PRIMARY KEY,
    booking_id  NUMBER          NOT NULL
                                CONSTRAINT fk_payment_booking
                                REFERENCES BOOKING(booking_id)
                                CONSTRAINT uq_payment_booking UNIQUE,
    pay_date    DATE            DEFAULT SYSDATE NOT NULL,
    amount      NUMBER(10,2)    NOT NULL
                                CONSTRAINT chk_amount CHECK (amount > 0),
    method      VARCHAR2(30)    NOT NULL
                                CONSTRAINT chk_method
                                CHECK (method IN ('Cash','Credit Card','Debit Card','Online')),
    status      VARCHAR2(20)    DEFAULT 'Pending' NOT NULL
                                CONSTRAINT chk_payment_status
                                CHECK (status IN ('Pending','Completed','Refunded'))
);

CREATE SEQUENCE seq_payment_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_payment_id
BEFORE INSERT ON PAYMENT
FOR EACH ROW
BEGIN
    SELECT seq_payment_id.NEXTVAL INTO :NEW.payment_id FROM DUAL;
END;
/

-- ============================================================
-- VIEWS
-- ============================================================

-- View 1: Active rentals with customer and vehicle info
CREATE OR REPLACE VIEW vw_active_rentals AS
    SELECT
        b.booking_id,
        c.full_name          AS customer_name,
        c.phone              AS customer_phone,
        v.make || ' ' || v.model AS vehicle,
        v.plate_no,
        b.start_date,
        b.end_date,
        b.total_days,
        b.total_cost
    FROM BOOKING b
    JOIN CUSTOMER c ON b.customer_id = c.customer_id
    JOIN VEHICLE  v ON b.vehicle_id  = v.vehicle_id
    WHERE b.status = 'Active';

-- View 2: Revenue summary per vehicle category
CREATE OR REPLACE VIEW vw_revenue_by_category AS
    SELECT
        v.category,
        COUNT(b.booking_id)     AS total_bookings,
        SUM(p.amount)           AS total_revenue,
        ROUND(AVG(p.amount), 2) AS avg_revenue
    FROM VEHICLE  v
    JOIN BOOKING  b ON v.vehicle_id = b.vehicle_id
    JOIN PAYMENT  p ON b.booking_id = p.booking_id
    WHERE p.status = 'Completed'
    GROUP BY v.category;

-- View 3: Customer rental history
CREATE OR REPLACE VIEW vw_customer_history AS
    SELECT
        c.customer_id,
        c.full_name,
        COUNT(b.booking_id)  AS total_rentals,
        SUM(b.total_cost)    AS total_spent,
        MAX(b.end_date)      AS last_rental_date
    FROM CUSTOMER c
    LEFT JOIN BOOKING b ON c.customer_id = b.customer_id
    GROUP BY c.customer_id, c.full_name;

-- ============================================================
-- END OF SCHEMA
-- ============================================================
