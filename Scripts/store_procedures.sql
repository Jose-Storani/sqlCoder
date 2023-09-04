use billingsystem;

DELIMITER //

CREATE PROCEDURE InsertProduct(
    IN product_code VARCHAR(255),
    IN brand_id TINYINT,
    IN product_name VARCHAR(60),
    IN product_description TINYTEXT,
    IN category_id TINYINT,
    IN stock INT,
    IN created_by_employee_id INT
)
BEGIN
    INSERT INTO billingSystem.Products (
        `code`, `brand`, `name`, `description`, `category`, `stock`, `created_by`
    )
    VALUES (
        product_code, brand_id, product_name, product_description, category_id, stock_quantity, created_by_employee_id
    );
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE UpdateProductStock(
    IN product_code VARCHAR(255),
    IN new_stock_quantity INT
)
BEGIN
    UPDATE billingSystem.Products
    SET `stock` = new_stock_quantity
    WHERE `code` = product_code;
END //

DELIMITER ;


