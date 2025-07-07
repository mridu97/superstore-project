
CREATE TABLE customer (customer_id VARCHAR(20) PRIMARY KEY,
customer_name VARCHAR(100), segment VARCHAR(50), city VARCHAR(100), state VARCHAR(100), region VARCHAR(50), country VARCHAR(50), postal_code VARCHAR(20));

CREATE TABLE product (product_id VARCHAR(20) PRIMARY KEY,
product_name VARCHAR(100), category VARCHAR(50), sub_category VARCHAR(50));

CREATE TABLE orders (order_id VARCHAR(20), order_date DATE, ship_date DATE, ship_mode VARCHAR(50), customer_id VARCHAR(20), product_id VARCHAR(20), 
sales DECIMAL(10,2), quantity INT, discount DECIMAL(4,2), profit DECIMAL(10,2), 
PRIMARY KEY (order_id, product_id), FOREIGN KEY (customer_id) REFERENCES customer(customer_id), FOREIGN KEY (product_id) REFERENCES product(product_id));

--data exploration 
Total profit
SELECT SUM(profit) AS total_profit
FROM orders;

--total count of rows
SELECT COUNT(*)
FROM orders;

--top 5 cutomers
SELECT customer_name, SUM(sales) AS total_sales
FROM customer AS c
JOIN orders AS o 
ON c.customer_id = o.customer_id
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

--total customer per segment
SELECT COUNT(customer_id) AS total_customers, segment
FROM customer
GROUP BY segment;

--sales by region
SELECT c.region, SUM(o.sales) AS total_sales
FROM orders AS o
JOIN customer AS c 
ON c.customer_id = o.customer_id
GROUP BY region
ORDER BY total_sales DESC;

--Monthly sales trend
SELECT DATE_FORMAT(STR_TO_date(order_date, '%m/%d/%Y'), '%Y-%M') AS month, SUM(sales) AS total_sales
FROM orders
WHERE order_date IS NOT NULL
GROUP BY month
ORDER BY total_sales DESC
LIMIT 10;

--Data analysis
--Identify Loss-Making Products
SELECT product_name, SUM(profit) AS total_profit 
FROM product AS p
JOIN orders AS o
on p.product_id = o.product_id
GROUP BY product_name
HAVING total_profit < 0
ORDER BY total_profit ASC
LIMIT 10;

--Sales and profit by region
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM customer AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY region
ORDER BY total_sales DESC;

--Top 10 products by profit
SELECT product_name, SUM(profit) AS total_profit
FROM product AS p
JOIN orders AS o
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;







