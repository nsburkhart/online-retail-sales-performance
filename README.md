# Online Retail Sales Performance Analysis

## Project Overview

This project analyzes an online retail transaction dataset using
PostgreSQL and Tableau. The goal was to clean the raw transaction data,
answer business questions with SQL, investigate unusual trends and
outliers, and build a dashboard that summarizes sales performance,
customer behavior, geographic performance, and product performance.

## Tableau Dashboard

![Online Retail Sales Performance Dashboard](Dashboard%20Screenshot.png)

## Tools Used

-   PostgreSQL
-   SQL
-   Tableau

## Data Preparation

The raw transaction data was loaded into PostgreSQL and cleaned before
analysis. Key preparation steps included:

-   Creating a cleaned transaction table from the raw data
-   Calculating transaction revenue as `price * quantity`
-   Reviewing missing customer IDs
-   Investigating returns and negative quantities
-   Reviewing zero-price transactions and blank descriptions
-   Identifying and excluding non-product transaction codes such as
    adjustments, fees, bank charges, discounts, postage, samples, and
    test entries when analyzing product performance
-   Excluding incomplete December 2011 data from the final monthly trend
    dashboard

## SQL Analysis

The analysis used SQL techniques including:

-   `GROUP BY` and aggregate functions
-   `COUNT(DISTINCT ...)`
-   `CASE WHEN`
-   `JOIN`
-   CTEs
-   Subqueries
-   `HAVING`
-   `DATE_TRUNC`
-   `LAG()` window functions
-   Month-over-month percentage calculations

Business questions explored included:

-   How do revenue, orders, and average order value change over time?
-   What caused a major decline in January performance?
-   Which customers generate the most revenue?
-   How important are repeat customers?
-   How geographically concentrated is the business?
-   Which international markets have strong order values?
-   Which products generate the most sustained revenue?
-   Are top-product rankings being distorted by unusually large one-time
    orders?

## Key Findings

-   The 24 complete months used in the final dashboard generated
    approximately **£20.3M in revenue** from **39,259 orders**.
-   Overall average order value was approximately **£517.90**.
-   **72.39%** of identified customers were repeat customers.
-   Repeat customers generated approximately **96.80%** of
    identified-customer revenue.
-   The average repeat customer generated approximately **11.53x** more
    revenue than the average one-time customer.
-   The United Kingdom accounted for **85.21%** of total revenue,
    showing strong geographic concentration.
-   Among established non-UK markets, the Netherlands stood out with an
    average order value of approximately **£2,430.84** across **228
    orders**.
-   January's lower average price per item was partly explained by a
    shift toward lower-priced products. The share of units priced under
    £2 increased from **64.11% in December to 76.38% in January**.
-   One January product, `MEDIUM CERAMIC TOP STORAGE JAR`, sold **74,215
    units** at an average price of approximately **£1.04**, contributing
    to the lower average selling price.
-   `PAPER CRAFT , LITTLE BIRDIE` initially appeared to be a top product
    by revenue, but its entire **£168,469.60** came from a single order
    of **80,995 units**. This showed why revenue rankings should be
    checked for outliers and sustained demand.
-   After requiring products to appear across at least 100 distinct
    orders, `REGENCY CAKESTAND 3 TIER` and
    `WHITE HANGING HEART T-LIGHT HOLDER` remained leading products by
    revenue.

## Tableau Dashboard

The Tableau dashboard includes:

-   Total Revenue KPI
-   Total Orders KPI
-   Average Order Value KPI
-   Repeat Customer Rate KPI
-   Monthly Revenue Trend
-   Top International Markets
-   Top 10 Products by Revenue

The dashboard was built from four SQL-generated CSV datasets:

-   `monthly_performance.csv`
-   `customer_analysis.csv`
-   `geographic_performance.csv`
-   `product_performance.csv`

## Project Structure

``` text
Online-Retail-Sales-Performance/
├── README.md
├── Online Retail Sales Performance Dashboard.twb
├── sql/
│   └── retail_sales_analysis.sql
├── data/
│   ├── monthly_performance.csv
│   ├── customer_analysis.csv
│   ├── geographic_performance.csv
│   └── product_performance.csv
└── images/
    └── dashboard.png
```

## What I Learned

This project strengthened my ability to move from raw transactional data
to business-facing analysis. I practiced cleaning data, building
multi-step SQL queries, validating unusual results instead of accepting
rankings at face value, using CTEs and window functions for trend
analysis, and translating SQL outputs into a Tableau dashboard.

A major takeaway was that a useful analysis requires more than
calculating metrics. Several findings required investigating the reason
behind the number, such as determining why average selling price
declined and identifying when a top-product ranking was driven by a
single outlier order.
