-- ============================================================
-- Online Retail Sales Performance Analysis
-- PostgreSQL
-- ============================================================
-- Core SQL queries used to generate the datasets for the
-- Tableau sales performance dashboard.
-- ============================================================


-- ============================================================
-- 1. MONTHLY PERFORMANCE
-- Revenue, order volume, and average order value by month.
-- Incomplete December 2011 data is excluded.
-- ============================================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT invoice) AS total_orders,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice),
        2
    ) AS avg_order_value
FROM clean_transactions
WHERE invoice_date < '2011-12-01'
GROUP BY month
ORDER BY month;


-- ============================================================
-- 2. CUSTOMER ANALYSIS
-- Segments identified customers into one-time and repeat
-- customers and compares customer count and revenue.
-- ============================================================

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice) AS total_orders
    FROM clean_transactions
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
),
customer_types AS (
    SELECT
        customer_id,
        total_orders,
        CASE
            WHEN total_orders = 1 THEN 'One-time'
            ELSE 'Repeat'
        END AS customer_type
    FROM customer_orders
)
SELECT
    ct.customer_type,
    COUNT(DISTINCT t.customer_id) AS number_of_customers,
    SUM(t.revenue) AS total_revenue,
    ROUND(
        SUM(t.revenue) / COUNT(DISTINCT t.customer_id),
        2
    ) AS avg_revenue_per_customer
FROM clean_transactions t
JOIN customer_types ct
    ON t.customer_id = ct.customer_id
GROUP BY ct.customer_type;


-- ============================================================
-- 3. GEOGRAPHIC PERFORMANCE
-- Revenue, order volume, and average order value by country.
-- ============================================================

SELECT
    country,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT invoice) AS total_orders,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice),
        2
    ) AS avg_order_value
FROM clean_transactions
GROUP BY country
ORDER BY total_revenue DESC;


-- ============================================================
-- 4. PRODUCT PERFORMANCE
-- Ranks products by revenue while excluding transaction codes
-- representing adjustments, fees, discounts, postage, samples,
-- test entries, and other non-product activity.
-- ============================================================

SELECT
    description,
    COUNT(DISTINCT invoice) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS total_revenue
FROM clean_transactions
WHERE stock_code NOT IN (
    'ADJUST',
    'ADJUST2',
    'AMAZONFEE',
    'B',
    'BANK CHARGES',
    'C2',
    'D',
    'DOT',
    'M',
    'm',
    'POST',
    'S',
    'TEST001',
    'TEST002'
)
GROUP BY description
ORDER BY total_revenue DESC;
