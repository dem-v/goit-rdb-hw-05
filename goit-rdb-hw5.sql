USE mydb;
-- ======================
-- Task 1
-- ======================
SELECT *, (SELECT customer_id FROM orders WHERE orders.id = order_details.order_id)
FROM order_details;

-- ======================
-- Task 2
-- ======================
SELECT *
FROM order_details
WHERE order_id IN (SELECT id FROM orders WHERE orders.shipper_id = 3);

-- ======================
-- Task 3
-- ======================
SELECT order_id, AVG(quantity) 
FROM (SELECT order_id, quantity FROM order_details WHERE quantity > 10) temp
GROUP BY order_id;

-- ======================
-- Task 4
-- ======================
WITH temp AS
(
SELECT order_id, quantity FROM order_details WHERE quantity > 10
)
SELECT order_id, AVG(quantity) 
FROM temp
GROUP BY order_id;

-- ======================
-- Task 5
-- ======================
DROP FUNCTION IF EXISTS CalculateRatio;

DELIMITER //

CREATE FUNCTION CalculateRatio(A FLOAT, B FLOAT)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result INT;
    SET result = A / B;
    RETURN result;
END //

DELIMITER ;

SELECT CalculateRatio(quantity, 7.0)
FROM order_details;