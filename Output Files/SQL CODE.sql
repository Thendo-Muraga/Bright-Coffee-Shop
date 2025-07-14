SELECT store_location,product_detail,product_type,

--AGGERATED
    COUNT(transaction_id) AS number_of_sales,
    SUM(transaction_qty*unit_price) AS total_revenue,
    SUM(transaction_qty) AS number_of_units_sold,

--DATES 
    TO_DATE (transaction_date) AS purchase_date, 
    TO_CHAR(TO_DATE(transaction_date), 'YYYYMM')AS month_id, 
    DAYNAME(TO_DATE(transaction_date)) AS day_of_week,
    DATE_PART(HOUR,transaction_time) AS hour_of_day,
    MONTHNAME(transaction_date) AS month_name,
    
--CASE STATEMENTS
CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN transaction_time BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
    ELSE  'Night'
    END AS time_bucket,

    CASE 
    WHEN DAYNAME(TO_DATE(transaction_date)) IN ('Sat', 'Sun') THEN   'Weekend'
    ELSE 'Weekday'
    END AS week_bucket,

    CASE
    WHEN SUM(transaction_qty*unit_price) BETWEEN 0 AND 120 THEN 'Low'
    WHEN SUM(transaction_qty*unit_price) BETWEEN 121 AND 240 THEN 'Medium'
    ELSE 'High'
    END AS spender_bucket,

    CASE
    
    WHEN MONTH(transaction_date) IN (12, 1, 2) THEN 'Summer'
    WHEN MONTH(transaction_date) IN (3, 4, 5) THEN 'Autumn'
    WHEN MONTH(transaction_date) IN (6, 7, 8) THEN 'Winter'
    ELSE 'Spring'
    END AS year_seasons,
    
FROM transcation.sales.coffee_shop

--GROUPING BY
GROUP BY
store_location,
product_detail,
product_type,
transaction_date,
time_bucket,
week_bucket,
purchase_date,
month_id,
day_of_week,
hour_of_day

--ORDERING BY
ORDER BY number_of_sales DESC; 
