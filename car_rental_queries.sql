-- ============================================================
-- CAR RENTAL MANAGEMENT SYSTEM - SQL QUERIES
-- Student: Talha Aftab | SAP ID: 63091
-- Course: Database Management System | Spring 2026
-- Riphah International University
-- ============================================================

-- ============================================================
-- SECTION 1: JOIN QUERIES
-- ============================================================

-- Query 1: List all bookings with customer name, vehicle, and staff who handled it
SELECT
    b.booking_id,
    c.full_name      AS customer_name,
    v.make || ' ' || v.model AS vehicle,
    v.plate_no,
    s.full_name      AS handled_by,
    b.start_date,
    b.end_date,
    b.total_days,
    b.total_cost,
    b.status
FROM BOOKING b
JOIN CUSTOMER c ON b.customer_id = c.customer_id
JOIN VEHICLE  v ON b.vehicle_id  = v.vehicle_id
JOIN STAFF    s ON b.staff_id    = s.staff_id
ORDER BY b.booking_id;

-- Query 2: List all completed bookings with payment details
SELECT
    b.booking_id,
    c.full_name      AS customer_name,
    v.make || ' ' || v.model AS vehicle,
    b.total_cost,
    p.amount         AS amount_paid,
    p.method         AS payment_method,
    p.pay_date,
    p.status         AS payment_status
FROM BOOKING  b
JOIN CUSTOMER c ON b.customer_id = c.customer_id
JOIN VEHICLE  v ON b.vehicle_id  = v.vehicle_id
JOIN PAYMENT  p ON b.booking_id  = p.booking_id
WHERE b.status = 'Completed'
ORDER BY p.pay_date;

-- Query 3: List all customers with their booking count (including customers with no bookings)
SELECT
    c.customer_id,
    c.full_name,
    c.phone,
    COUNT(b.booking_id) AS total_bookings
FROM CUSTOMER c
LEFT JOIN BOOKING b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.full_name, c.phone
ORDER BY total_bookings DESC;

-- Query 4: Show all active rentals with customer contact and vehicle plate
SELECT
    b.booking_id,
    c.full_name      AS customer_name,
    c.phone          AS customer_phone,
    v.make || ' ' || v.model AS vehicle,
    v.plate_no,
    v.category,
    b.start_date,
    b.end_date,
    b.total_days,
    b.total_cost
FROM BOOKING  b
JOIN CUSTOMER c ON b.customer_id = c.customer_id
JOIN VEHICLE  v ON b.vehicle_id  = v.vehicle_id
WHERE b.status = 'Active'
ORDER BY b.start_date;

-- Query 5: Revenue generated per staff member
SELECT
    s.staff_id,
    s.full_name      AS staff_name,
    s.role,
    COUNT(b.booking_id)  AS bookings_handled,
    SUM(p.amount)        AS total_revenue_generated
FROM STAFF   s
JOIN BOOKING b ON s.staff_id    = b.staff_id
JOIN PAYMENT p ON b.booking_id  = p.booking_id
WHERE p.status = 'Completed'
GROUP BY s.staff_id, s.full_name, s.role
ORDER BY total_revenue_generated DESC;

-- ============================================================
-- SECTION 2: SUBQUERY QUERIES
-- ============================================================

-- Query 6: Find customers who have spent more than the average customer spending
SELECT
    c.customer_id,
    c.full_name,
    c.email,
    SUM(b.total_cost) AS total_spent
FROM CUSTOMER c
JOIN BOOKING  b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.full_name, c.email
HAVING SUM(b.total_cost) > (
    SELECT AVG(total_per_customer)
    FROM (
        SELECT SUM(total_cost) AS total_per_customer
        FROM BOOKING
        GROUP BY customer_id
    )
)
ORDER BY total_spent DESC;

-- Query 7: Find vehicles that have never been booked
SELECT
    vehicle_id,
    make || ' ' || model AS vehicle,
    plate_no,
    category,
    daily_rate,
    status
FROM VEHICLE
WHERE vehicle_id NOT IN (
    SELECT DISTINCT vehicle_id FROM BOOKING
);

-- Query 8: Find the most expensive booking and show its full details
SELECT
    b.booking_id,
    c.full_name     AS customer_name,
    v.make || ' ' || v.model AS vehicle,
    b.total_days,
    b.total_cost
FROM BOOKING  b
JOIN CUSTOMER c ON b.customer_id = c.customer_id
JOIN VEHICLE  v ON b.vehicle_id  = v.vehicle_id
WHERE b.total_cost = (
    SELECT MAX(total_cost) FROM BOOKING
);

-- Query 9: List customers who have rented an SUV
SELECT DISTINCT
    c.customer_id,
    c.full_name,
    c.phone,
    c.email
FROM CUSTOMER c
WHERE c.customer_id IN (
    SELECT b.customer_id
    FROM BOOKING b
    JOIN VEHICLE v ON b.vehicle_id = v.vehicle_id
    WHERE v.category = 'SUV'
);

-- Query 10: Find vehicles with daily rate higher than average daily rate
SELECT
    vehicle_id,
    make || ' ' || model AS vehicle,
    category,
    daily_rate,
    status
FROM VEHICLE
WHERE daily_rate > (
    SELECT AVG(daily_rate) FROM VEHICLE
)
ORDER BY daily_rate DESC;

-- ============================================================
-- SECTION 3: AGGREGATION QUERIES
-- ============================================================

-- Query 11: Total revenue, total bookings, average booking value
SELECT
    COUNT(b.booking_id)         AS total_bookings,
    SUM(p.amount)               AS total_revenue,
    ROUND(AVG(p.amount), 2)     AS avg_booking_value,
    MAX(p.amount)               AS highest_payment,
    MIN(p.amount)               AS lowest_payment
FROM BOOKING  b
JOIN PAYMENT  p ON b.booking_id = p.booking_id
WHERE p.status = 'Completed';

-- Query 12: Revenue and booking count grouped by vehicle category
SELECT
    v.category,
    COUNT(b.booking_id)         AS total_bookings,
    SUM(p.amount)               AS total_revenue,
    ROUND(AVG(b.total_days), 1) AS avg_rental_days,
    MAX(p.amount)               AS max_payment
FROM VEHICLE  v
JOIN BOOKING  b ON v.vehicle_id = b.vehicle_id
JOIN PAYMENT  p ON b.booking_id = p.booking_id
WHERE p.status = 'Completed'
GROUP BY v.category
ORDER BY total_revenue DESC;

-- Query 13: Monthly booking and revenue summary
SELECT
    TO_CHAR(b.start_date, 'YYYY-MM') AS month,
    COUNT(b.booking_id)              AS total_bookings,
    SUM(b.total_cost)                AS total_cost,
    SUM(p.amount)                    AS collected_revenue
FROM BOOKING  b
JOIN PAYMENT  p ON b.booking_id = p.booking_id
WHERE p.status = 'Completed'
GROUP BY TO_CHAR(b.start_date, 'YYYY-MM')
ORDER BY month;

-- Query 14: Payment method usage breakdown
SELECT
    method,
    COUNT(*)                    AS total_transactions,
    SUM(amount)                 AS total_amount,
    ROUND(AVG(amount), 2)       AS avg_amount
FROM PAYMENT
WHERE status = 'Completed'
GROUP BY method
ORDER BY total_amount DESC;

-- Query 15: Top 3 most rented vehicles
SELECT * FROM (
    SELECT
        v.vehicle_id,
        v.make || ' ' || v.model AS vehicle,
        v.plate_no,
        v.category,
        COUNT(b.booking_id) AS times_rented
    FROM VEHICLE v
    JOIN BOOKING b ON v.vehicle_id = b.vehicle_id
    GROUP BY v.vehicle_id, v.make, v.model, v.plate_no, v.category
    ORDER BY times_rented DESC
)
WHERE ROWNUM <= 3;

-- ============================================================
-- SECTION 4: VIEW QUERIES
-- ============================================================

-- Query 16: Select from active rentals view
SELECT * FROM vw_active_rentals;

-- Query 17: Select from revenue by category view
SELECT * FROM vw_revenue_by_category;

-- Query 18: Select from customer history view
SELECT * FROM vw_customer_history ORDER BY total_spent DESC;

-- ============================================================
-- END OF QUERIES
-- ============================================================
