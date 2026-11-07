-- bigquery-public-data.thelook_ecommerce.users

-- SELECT
--   order_id,
--   status,
--   country
-- FROM bigquery-public-data.thelook_ecommerce.users
-- left JOIN bigquery-public-data.thelook_ecommerce.orders
--   ON users.id = orders.user_id
-- where order_id is null;

-- SELECT
--   order_id,
--   status,
--   country
-- FROM bigquery-public-data.thelook_ecommerce.users
-- INNER JOIN bigquery-public-data.thelook_ecommerce.orders
--   ON users.id = orders.user_id;

-- Display the product name, category, department, brand, and retail price from the products table.
-- Limit the results to the first 20 products.

SELECT
  name,
  category,
  department,
  brand,
  retail_price
FROM bigquery-public-data.thelook_ecommerce.products
LIMIT 20;

-- The marketing team wants to prepare a campaign for premium products.
-- Find products with a `retail_price` above 100.
-- Display the product name, category, brand, and retail price, then sort them from the highest price to the lowest.

SELECT
  name,
  category,
  brand,
  retail_price
FROM
  bigquery-public-data.thelook_ecommerce.products
WHERE
  retail_price > 100
ORDER BY retail_price DESC;

-- The Product team wants to identify the category with the highest number of products.
-- Calculate the number of products in each category from the `products` table,
-- then sort the results starting with the largest number of products.

SELECT
  category,
  COUNT(*) AS total_Product
FROM
  bigquery-public-data.thelook_ecommerce.products
GROUP BY
  category
ORDER BY
  total_Product DESC;

-- The CRM team wants to see customers who have placed orders.
-- Join the `users` and `orders` tables to display the order ID, order status, date the order was created, and the customer's first and last name.

SELECT order_id, status, orders.created_at, users.first_name, users.last_name
FROM bigquery-public-data.thelook_ecommerce.users
JOIN
  bigquery-public-data.thelook_ecommerce.orders
  ON
    users.id = orders.user_id;

-- The business manager wants to identify the product category with the highest total sales value.
-- Join the `order_items` and `products` tables, then calculate the total sales value by category.
-- Display the category and total sales, and sort the results starting with the highest value.
-- Use `order_items.sale_price` as the transaction value per item.

SELECT category, round(sum(sale_price), 2) AS total_sales
FROM bigquery-public-data.thelook_ecommerce.products
JOIN
  bigquery-public-data.thelook_ecommerce.order_items
  ON
    order_items.product_id = products.id
GROUP BY
  category
ORDER BY
  total_sales DESC;
