-- ============================================================
-- LOGISTICS COMPANY DATA ANALYSIS WITH SQL
-- Author  : Paras Soni
-- Email   : iparassoni2005@gmail.com
-- Tools   : MySQL Workbench
-- Dataset : employee_details, customer, shipment_details,
--           payment_details, membership, status
-- ============================================================

-- ============================================================
-- DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS logistics_db;
USE logistics_db;

-- ============================================================
-- SECTION 1: BASIC ANALYSIS
-- Staffing | Segmentation | Classification | Frequency
-- ============================================================

-- Query 1: Branch-wise count of employees in descending order
-- Purpose: Optimize staff deployment across branches
SELECT 
    E_BRANCH, 
    COUNT(E_ID) AS Employee_Count
FROM employee_details
GROUP BY E_BRANCH
ORDER BY Employee_Count DESC;

-- Query 3: Names and designations of all employees in 'NY' branch
-- Purpose: Branch-level employee lookup
SELECT 
    E_Name, 
    E_DESIGNATION
FROM employee_details
WHERE E_BRANCH = 'NY';

-- Query 4: Total number of customers in each customer type
-- Purpose: Customer segmentation (Wholesale, Retail, Internal Goods)
SELECT 
    C_TYPE, 
    COUNT(*) AS total_customers
FROM customer
GROUP BY C_TYPE;

-- Query 6: Designation-wise employee count in descending order
-- Purpose: Workforce planning by role
SELECT 
    E_DESIGNATION, 
    COUNT(E_ID) AS total_employees
FROM employee_details
GROUP BY E_DESIGNATION
ORDER BY total_employees DESC;

-- ============================================================
-- SECTION 2: INTERMEDIATE ANALYSIS
-- Averages | Payments | Filtering
-- ============================================================

-- Query 2: Average payment amount by payment mode (non-null dates only)
-- Purpose: Understand payment behavior per mode
SELECT 
    payment_mode, 
    AVG(amount) AS avg_payment
FROM payment_details
WHERE payment_date IS NOT NULL
GROUP BY payment_mode;

-- Query 5: Shipment status and delivery date for 'Delivery Boy' employees
-- Purpose: Track delivery performance by role
SELECT 
    shipment_details.SH_ID,
    status.CURRENT_STATUS,
    status.DELIVERY_DATE
FROM shipment_details
JOIN status ON status.SH_ID = shipment_details.SH_ID
JOIN employee_details ON employee_details.E_ID = shipment_details.E_ID
WHERE employee_details.E_DESIGNATION = 'Delivery Boy';

-- Query 7: Average shipment weight by payment status
--          (excluding content starting with 'H')
-- Purpose: Weight-payment correlation analysis
SELECT 
    payment_details.PAYMENT_STATUS, 
    AVG(shipment_details.SH_WEIGHT) AS avg_shipment_weight
FROM shipment_details
JOIN payment_details ON payment_details.C_ID = shipment_details.C_ID
WHERE shipment_details.SH_CONTENT NOT LIKE 'H%'
GROUP BY payment_details.PAYMENT_STATUS;

-- Query 8: Average shipment weight per domain (Domestic vs International)
-- Purpose: Compare weight distribution across shipment domains
SELECT 
    SH_DOMAIN, 
    AVG(SH_WEIGHT) AS avg_weight
FROM shipment_details
GROUP BY SH_DOMAIN;

-- Query 11: Membership dates for customers with 'Paid' payment status
-- Purpose: Identify active paid members
SELECT 
    customer.C_ID, 
    membership.START_DATE, 
    membership.END_DATE
FROM customer
JOIN membership ON membership.M_ID = customer.C_ID
JOIN payment_details ON payment_details.C_ID = customer.C_ID
WHERE payment_details.PAYMENT_STATUS = 'Paid';

-- Query 12: Clients with 'Card Payment' and 'Regular' service type
-- Purpose: Identify preferred payment-service combinations
SELECT DISTINCT 
    customer.C_NAME
FROM customer
JOIN payment_details ON customer.C_ID = payment_details.C_ID
JOIN shipment_details ON customer.C_ID = shipment_details.C_ID
WHERE payment_details.Payment_Mode = 'Card Payment'
  AND shipment_details.SER_TYPE = 'Regular';

-- ============================================================
-- SECTION 3: ADVANCED ANALYSIS
-- Revenue | Behavior | Comparison | Efficiency
-- ============================================================

-- Query 9: Top 3 shipments with highest charges and client names
-- Purpose: Identify high-value shipments for priority handling
SELECT 
    customer.C_NAME, 
    shipment_details.SH_ID, 
    SH_CHARGES
FROM shipment_details
JOIN customer ON shipment_details.C_ID = customer.C_ID
ORDER BY SH_CHARGES DESC
LIMIT 3;

-- Query 10: Customer count by type in descending order
-- Purpose: Identify dominant customer segments
SELECT 
    C_Type, 
    COUNT(*) AS customer_count
FROM customer
GROUP BY C_Type
ORDER BY customer_count DESC;

-- Query 13: Customer count by payment status in descending order
-- Purpose: Measure payment compliance across customer base
SELECT 
    Payment_Status, 
    COUNT(DISTINCT C_ID) AS customer_count
FROM payment_details
GROUP BY Payment_Status
ORDER BY customer_count DESC;

-- Query 14: Customer count by service type in descending order
-- Purpose: Identify most-used service types
SELECT 
    C_TYPE, 
    COUNT(C_ID) AS customer_count
FROM CUSTOMER
GROUP BY C_TYPE
ORDER BY customer_count DESC;

-- Query 15: Customer count by shipment domain in descending order
-- Purpose: Understand domestic vs international demand
SELECT 
    SH_DOMAIN, 
    COUNT(DISTINCT C_ID) AS customer_count
FROM shipment_details
GROUP BY SH_DOMAIN
ORDER BY customer_count DESC;

-- ============================================================
-- BONUS: ADVANCED SQL — Window Functions & CTEs
-- ============================================================

-- Bonus 1: Branch revenue ranking using RANK() window function
-- Purpose: Identify top revenue-generating branches
SELECT 
    E_BRANCH,
    SUM(SH_CHARGES) AS total_revenue,
    RANK() OVER (ORDER BY SUM(SH_CHARGES) DESC) AS revenue_rank
FROM employee_details
JOIN shipment_details ON employee_details.E_ID = shipment_details.E_ID
GROUP BY E_BRANCH;

-- Bonus 2: CTE to find customers with above-average shipment charges
-- Purpose: Segment high-value customers for business strategy
WITH avg_charges AS (
    SELECT AVG(SH_CHARGES) AS overall_avg FROM shipment_details
)
SELECT 
    customer.C_NAME,
    shipment_details.SH_ID,
    shipment_details.SH_CHARGES
FROM shipment_details
JOIN customer ON shipment_details.C_ID = customer.C_ID
JOIN avg_charges ON shipment_details.SH_CHARGES > avg_charges.overall_avg
ORDER BY SH_CHARGES DESC;

-- Bonus 3: CASE WHEN — Classify shipments by weight category
-- Purpose: Operational planning based on weight tiers
SELECT 
    SH_ID,
    SH_WEIGHT,
    SH_DOMAIN,
    CASE 
        WHEN SH_WEIGHT < 200  THEN 'Light'
        WHEN SH_WEIGHT < 600  THEN 'Medium'
        WHEN SH_WEIGHT < 900  THEN 'Heavy'
        ELSE 'Extra Heavy'
    END AS weight_category
FROM shipment_details
ORDER BY SH_WEIGHT DESC;

-- ============================================================
-- END OF ANALYSIS
-- ============================================================
