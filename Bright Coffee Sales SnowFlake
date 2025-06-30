SELECT store_location,product_detail,product_type,

--AGGERATED
    COUNT(transaction_id) AS number_of_transcation,
    SUM(transaction_id*unit_price) AS total_revenue,
    SUM(transaction_qty) AS number_of_unit_sold,

--DATES 
    TO_DATE (transaction_date) AS purchase_date, 
    TO_CHAR(TO_DATE(transaction_date), 'YYYYMM')AS month_id, 
    DAYNAME(TO_DATE(transaction_date)) AS day_of_week,
    DATE_PART(HOUR,transaction_time) AS hour_of_day,
    
--CASE STATEMENTS
CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN transaction_time BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
    ELSE  'Night'
    END AS time_bucket,

    CASE 
    WHEN DAYNAME(TO_DATE(transaction_date)) IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
    END AS week_bucket,

    CASE
    WHEN SUM(transaction_id*unit_price) BETWEEN 0 AND 120 THEN 'Low'
    WHEN SUM(transaction_id*unit_price) BETWEEN 121 AND 240 THEN 'Medium'
    ELSE 'High'
    END AS spender_bucket,
     
FROM transcation.sales.coffee_shop
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

ORDER BY number_of_unit_sold DESC ;

