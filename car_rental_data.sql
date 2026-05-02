-- ============================================================
-- CAR RENTAL MANAGEMENT SYSTEM - SAMPLE DATA
-- Student: Talha Aftab | SAP ID: 63091
-- ============================================================

-- ============================================================
-- INSERT STAFF (5 records)
-- ============================================================
INSERT INTO STAFF (full_name, role, email, phone) VALUES ('Ahmed Raza',    'Manager', 'ahmed.raza@carrental.com',   '0300-1234567');
INSERT INTO STAFF (full_name, role, email, phone) VALUES ('Sara Khan',     'Agent',   'sara.khan@carrental.com',    '0301-2345678');
INSERT INTO STAFF (full_name, role, email, phone) VALUES ('Bilal Hussain', 'Agent',   'bilal.hussain@carrental.com','0302-3456789');
INSERT INTO STAFF (full_name, role, email, phone) VALUES ('Fatima Malik',  'Agent',   'fatima.malik@carrental.com', '0303-4567890');
INSERT INTO STAFF (full_name, role, email, phone) VALUES ('Usman Ali',     'Mechanic','usman.ali@carrental.com',    '0304-5678901');

-- ============================================================
-- INSERT CUSTOMERS (8 records)
-- ============================================================
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Talha Aftab',   'talha.aftab@gmail.com',   '0311-1111111', 'LHR-2019-001', 'House 12, Street 4, Lahore');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Hamza Tariq',   'hamza.tariq@gmail.com',   '0312-2222222', 'ISB-2018-045', 'Plot 7, F-10, Islamabad');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Zara Ahmed',    'zara.ahmed@gmail.com',    '0313-3333333', 'KHI-2020-112', 'Flat 3, Block B, Karachi');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Ali Hassan',    'ali.hassan@gmail.com',    '0314-4444444', 'RWP-2017-089', 'Street 9, Saddar, Rawalpindi');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Ayesha Noor',   'ayesha.noor@gmail.com',   '0315-5555555', 'LHR-2021-200', 'House 5, DHA Phase 2, Lahore');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Omar Farooq',   'omar.farooq@gmail.com',   '0316-6666666', 'ISB-2019-330', 'House 88, G-9, Islamabad');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Sana Ijaz',     'sana.ijaz@gmail.com',     '0317-7777777', 'MUL-2016-055', 'Street 2, Multan Cantt');
INSERT INTO CUSTOMER (full_name, email, phone, license_no, address) VALUES ('Kamran Bashir', 'kamran.bashir@gmail.com', '0318-8888888', 'KHI-2022-401', 'Flat 10, Gulshan, Karachi');

-- ============================================================
-- INSERT VEHICLES (10 records)
-- ============================================================
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Toyota',  'Corolla',   2020, 'LHR-1234', 'Standard', 5000,  'Rented');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Honda',   'Civic',     2021, 'ISB-5678', 'Standard', 5500,  'Rented');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Suzuki',  'Alto',      2019, 'KHI-9012', 'Economy',  2500,  'Available');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Toyota',  'Fortuner',  2022, 'RWP-3456', 'SUV',      12000, 'Rented');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Honda',   'BRV',       2021, 'LHR-7890', 'SUV',      8000,  'Available');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Toyota',  'Camry',     2023, 'ISB-2345', 'Luxury',   15000, 'Rented');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Hyundai', 'Tucson',    2022, 'KHI-6789', 'SUV',      10000, 'Available');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Suzuki',  'Wagon R',   2020, 'RWP-0123', 'Economy',  3000,  'Rented');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Toyota',  'HiAce',     2019, 'LHR-4567', 'Van',      18000, 'Maintenance');
INSERT INTO VEHICLE (make, model, year, plate_no, category, daily_rate, status) VALUES ('Mercedes','C-Class',   2023, 'ISB-8901', 'Luxury',   25000, 'Available');

-- ============================================================
-- INSERT BOOKINGS (12 records)
-- Note: total_days and total_cost are AUTO-CALCULATED by trigger
-- We still pass them as 0 — trigger overwrites them
-- ============================================================
INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (1, 1, 2, DATE '2026-04-01', DATE '2026-04-04', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (2, 2, 3, DATE '2026-04-05', DATE '2026-04-08', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (3, 4, 2, DATE '2026-04-10', DATE '2026-04-15', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (4, 6, 1, DATE '2026-04-12', DATE '2026-04-14', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (5, 8, 4, DATE '2026-04-18', DATE '2026-04-21', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (6, 1, 3, DATE '2026-04-22', DATE '2026-04-25', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (7, 3, 2, DATE '2026-04-25', DATE '2026-04-27', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (8, 5, 4, DATE '2026-04-28', DATE '2026-05-02', 0, 0, 'Completed');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (1, 6, 1, DATE '2026-05-01', DATE '2026-05-04', 0, 0, 'Active');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (3, 2, 3, DATE '2026-05-02', DATE '2026-05-06', 0, 0, 'Active');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (5, 4, 2, DATE '2026-05-03', DATE '2026-05-07', 0, 0, 'Active');

INSERT INTO BOOKING (customer_id, vehicle_id, staff_id, start_date, end_date, total_days, total_cost, status)
VALUES (2, 8, 4, DATE '2026-04-01', DATE '2026-04-03', 0, 0, 'Cancelled');

-- ============================================================
-- INSERT PAYMENTS (11 records — 1 booking cancelled, no payment)
-- ============================================================
INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (1,  DATE '2026-04-04', 15000, 'Cash',         'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (2,  DATE '2026-04-08', 16500, 'Credit Card',  'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (3,  DATE '2026-04-15', 60000, 'Online',       'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (4,  DATE '2026-04-14', 30000, 'Debit Card',   'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (5,  DATE '2026-04-21', 9000,  'Cash',         'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (6,  DATE '2026-04-25', 15000, 'Online',       'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (7,  DATE '2026-04-27', 5000,  'Cash',         'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (8,  DATE '2026-05-02', 32000, 'Credit Card',  'Completed');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (9,  DATE '2026-05-01', 45000, 'Online',       'Pending');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (10, DATE '2026-05-02', 22000, 'Debit Card',   'Pending');

INSERT INTO PAYMENT (booking_id, pay_date, amount, method, status)
VALUES (11, DATE '2026-05-03', 48000, 'Credit Card',  'Pending');

-- Commit all inserts
COMMIT;

-- ============================================================
-- VERIFY DATA
-- ============================================================
SELECT 'STAFF'    AS tbl, COUNT(*) AS rows FROM STAFF    UNION ALL
SELECT 'CUSTOMER' AS tbl, COUNT(*) AS rows FROM CUSTOMER UNION ALL
SELECT 'VEHICLE'  AS tbl, COUNT(*) AS rows FROM VEHICLE  UNION ALL
SELECT 'BOOKING'  AS tbl, COUNT(*) AS rows FROM BOOKING  UNION ALL
SELECT 'PAYMENT'  AS tbl, COUNT(*) AS rows FROM PAYMENT;
