-- Bike Store Sales Performance Analysis (SQL)

-- TOTAL REVENUE - ÜMUMİ SATIŞ
SELECT ROUND(SUM(quantity * list_price * (1 - discount)), 2)
AS total_revenue
FROM order_items ;


-- TOTAL ORDERS - ÜMUMİ SİFARİŞ SAYI
SELECT COUNT(DISTINCT order_id) FROM order_items ;


-- TOP 5 GELIRLI MEHSUL
SELECT * FROM(
SELECT p.product_name,SUM(oi.quantity * p.list_price * (1 - oi.discount))
AS revenues 
FROM products p 
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_name
ORDER BY revenues DESC)
WHERE ROWNUM<=5;


-- HER MAGAZA UZRE GELIR
SELECT s.store_name,ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS revenue 
FROM orders o JOIN stores s
ON o.store_id=s.store_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY s.store_name;


-- TOP 5 MÜŞTƏRİ
SELECT * FROM(
SELECT c.first_name|| ' ' ||c.last_name AS customer , ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS revenue
FROM orders o JOIN customers c 
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.first_name|| ' ' ||c.last_name
ORDER BY revenue DESC)
WHERE ROWNUM<=5;
