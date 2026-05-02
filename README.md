# Car Rental Management System
### Database Management System — Semester Project

**Student:** Talha Aftab
**SAP ID:** 63091
**Section:** BSCS 4-1
**Instructor:** Mr. Ihtisham Ullah
**University:** Riphah International University Islamabad I-14
**Session:** Spring 2026

---

## Project Overview

The Car Rental Management System is a relational database designed to manage the core operations of a vehicle rental business. It handles customer records, vehicle inventory, booking schedules, payment processing, and staff management through a fully normalized Oracle SQL database.

---

## Database Design

**Entities:** Customer, Vehicle, Staff, Booking, Payment

**Relationships:**
- A customer can make many bookings (1:N)
- A vehicle can be assigned to many bookings (1:N)
- A staff member can manage many bookings (1:N)
- Each booking has exactly one payment (1:1)

**Normalization:** All tables satisfy Third Normal Form (3NF)

---

## Repository Contents

| File | Description |
|------|-------------|
| `car_rental_schema_11g.sql` | Full schema — tables, sequences, triggers, views |
| `car_rental_data.sql` | Sample data — 5 staff, 8 customers, 10 vehicles, 12 bookings, 11 payments |
| `car_rental_queries.sql` | 18 SQL queries — joins, subqueries, aggregations, views |

---

## How to Run

1. Open **Oracle SQL Developer** and connect to your database
2. Open `car_rental_schema_11g.sql` → Select All → Run Script (F5)
3. Open `car_rental_data.sql` → Select All → Run Script (F5)
4. Open `car_rental_queries.sql` → run individual queries with F9

---

## Tools Used

- Oracle Database 11g Express Edition
- Oracle SQL Developer
- Draw.io (ERD design)

---

## Queries Covered

**Join Queries**
1. All bookings with customer, vehicle and staff details
2. Completed bookings with payment details
3. Customer booking count including customers with no bookings
4. Active rentals with customer contact information
5. Revenue generated per staff member

**Subquery Queries**

6. Customers who spent above average
7. Vehicles never booked
8. Most expensive booking
9. Customers who rented an SUV
10. Vehicles with above-average daily rate

**Aggregation Queries**

11. Overall revenue and booking statistics
12. Revenue breakdown by vehicle category
13. Monthly booking and revenue summary
14. Payment method usage breakdown
15. Top 3 most rented vehicles

**View Queries**

16. Active rentals view
17. Revenue by category view
18. Customer history view
