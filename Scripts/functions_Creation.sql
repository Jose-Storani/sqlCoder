use billingsystem;
select * from branch;
select * from employee;
select * from invoice;
select * from invoice where YEAR(date) = 2022 and month(date)=10;



DELIMITER $$
CREATE FUNCTION unpayed_invoice(id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE invoice_q_unpaid INT;
    
    SELECT COUNT(status) INTO invoice_q_unpaid
    FROM invoice
    WHERE status = 'inpaga' AND client_id = id;
    RETURN invoice_q_unpaid;
END
$$
DELIMITER ;

select unpayed_invoice(2) as facturas_impagas;

