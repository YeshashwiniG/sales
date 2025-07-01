CREATE DATABASE sales_data;
USE sales_data;

CREATE TABLE sales (
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

INSERT INTO sales (order_date, amount, product_id) VALUES('2024-01-10', 500.00, 101),
INSERT INTO sales (order_date, amount, product_id) VALUES('2024-01-10', 300.00, 102),
INSERT INTO sales (order_date, amount, product_id) VALUES('2024-02-12', 450.00, 103),
INSERT INTO sales (order_date, amount, product_id) VALUES('2024-02-15', 700.00, 101),
INSERT INTO sales (order_date, amount, product_id) VALUES('2024-03-01', 650.00, 104),
INSERT INTO sales (order_date, amount, product_id) VALUES('2024-03-20', 550.00, 105);

SELECT 
    order_date,
    SUM(amount) AS daily_revenue,
    COUNT(*) AS total_orders
FROM sales
GROUP BY order_date
ORDER BY order_date;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    product_id,
    SUM(amount) AS product_revenue
FROM sales
GROUP BY year, month, product_id
ORDER BY year, month, product_revenue DESC;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    ROUND(SUM(amount) / COUNT(*), 2) AS avg_order_value
FROM sales
GROUP BY year, month
ORDER BY year, month;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_revenue
FROM sales
GROUP BY year, month
HAVING SUM(amount) < 10000
ORDER BY monthly_revenue;

SELECT 
    year,
    month,
    product_id,
    product_revenue
FROM (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(MONTH FROM order_date) AS month,
        product_id,
        SUM(amount) AS product_revenue,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
                     ORDER BY SUM(amount) DESC) AS rank
    FROM sales
    GROUP BY year, month, product_id
) ranked_products
WHERE rank = 1;

SELECT 
    order_date,
    SUM(amount) OVER (ORDER BY order_date) AS cumulative_revenue
FROM sales
ORDER BY order_date;

WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS year_month,
        SUM(amount) AS revenue
    FROM sales
    GROUP BY year_month
)
SELECT 
    year_month,
    revenue,
    LAG(revenue) OVER (ORDER BY year_month) AS previous_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY year_month) AS revenue_change
FROM monthly_revenue
WHERE revenue < LAG(revenue) OVER (ORDER BY year_month);


SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT product_id) AS unique_products,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS average_revenue_per_order
FROM sales;

